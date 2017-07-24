//
//  NestedItemTableViewController.swift
//  Checklist
//
//  Created by Emily Chang on 7/23/17.
//  Copyright © 2017 Emily Chang. All rights reserved.
//

import UIKit
import os.log

class NestedItemTableViewController: UITableViewController {
    
    var name = ""
    var items = [ItemNest]()


    @IBOutlet weak var nestedItemText: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        loadSample()

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
        print("printing name")
        print(name)
        print(items)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "nestedTableViewCell", for: indexPath) as? NestedItemTableViewCell  else {
            fatalError("The dequeued cell is not an instance of nestedTableViewCell.")
        }
        print(indexPath.row)
        print(items[indexPath.row])
        
        
        cell.nestedItemLabel.text = (items[indexPath.row]).name
        
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
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            //items.append("hi")
            //saveList()
            //tableView.insertRows(at: [indexPath], with: .fade)
            
        }
    }
    
    func loadSample() {
        let item1 = ItemNest(name: "year 1", nest: [ItemNest]())
        let item2 = ItemNest(name: "year 2", nest: [ItemNest]())
        let item3 = ItemNest(name: "year 3", nest: [ItemNest]())
        items += [item1, item2, item3]
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
    @IBAction func addNestedItem(_ sender: UITextField) {
        let newItem: ItemNest = ItemNest(name: sender.text!, nest: [ItemNest]())
        items.append(newItem)
        self.tableView.reloadData()
        nestedItemText.text = ""
    }


}

