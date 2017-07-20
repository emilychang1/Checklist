//
//  MainTableViewController.swift
//  Checklist
//
//  Created by Emily Chang on 7/18/17.
//  Copyright © 2017 Emily Chang. All rights reserved.
//

import UIKit
import os.log

class MainTableViewController: UITableViewController {
    
    var items = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
//        if let savedMeals = loadMeals() {
//            meals += savedMeals
//        }
//        else {
            // Load the sample data.
        navigationItem.leftBarButtonItem = editButtonItem
            loadSampleList()
        //}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as? ItemTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ItemTableViewCell.")
        }

        cell.itemLabel.text = items[indexPath.row]

        return cell
    }


    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            items.remove(at: indexPath.row)
            saveList()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            items.append("hi")
            saveList()
            tableView.insertRows(at: [indexPath], with: .fade)
            
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func loadSampleList() {

         let item1 = "Year 1"
        
         let item2 = "Year 2"
        
         let item3 = "Year 3"
        items += [item1, item2, item3]

    }
    
    private func saveList() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(items, toFile: ItemNest.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadList() -> [String]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: ItemNest.ArchiveURL.path) as? [String]
    }
    
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        
    }

}
