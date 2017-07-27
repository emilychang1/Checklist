//
//  MainTableViewController.swift
//  Checklist
//
//  Created by Emily Chang on 7/18/17.
//  Copyright © 2017 Emily Chang. All rights reserved.
//

import UIKit
import os.log

class MainTableViewController: UITableViewController, UITextFieldDelegate, MyProtocol {
    
    var items = [ItemNest]()
    
    var valueSentFromSecondViewController:String?
    
    @IBOutlet weak var newTextField: UITextField!

    override func viewDidAppear(_ animated: Bool) {
        if items.count > 0{
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newTextField.delegate = self
        //newTextField.returnKeyType = .return
        

        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        navigationItem.rightBarButtonItem = editButtonItem
        
        if let savedList = loadList() {
            items += savedList
        }
        else {
            // Load the sample data.
        //
            loadSampleList()
        }
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

        cell.itemLabel.text = (items[indexPath.row]).name

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
            //items.append("hi")
            //saveList()
            //tableView.insertRows(at: [indexPath], with: .fade)
            
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newItem = items[(self.tableView.indexPathForSelectedRow?.row)!]
        let destinationVC = segue.destination as! NestedItemTableViewController
        destinationVC.items = newItem.nest
        destinationVC.name = newItem.name
        destinationVC.item = newItem
        
        destinationVC.delegate = self
        
        //destinationVC.parentItem =
        //change: acounts only for two levels. need to implement parentItem property which gets updated everytime child list changes

        //self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func loadSampleList() {
        let item1 = ItemNest(name: "year 1", nest: [ItemNest](), parent: nil)
        let item2 = ItemNest(name: "year 2", nest: [item1], parent: nil)
        let item3 = ItemNest(name: "year 3", nest: [ItemNest](), parent: nil)
        items += [item2, item3]

    }
    
    func saveList() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(items, toFile: ItemNest.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
    
    func loadList() -> [ItemNest]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: ItemNest.ArchiveURL.path) as? [ItemNest]
    }
    
    func setResultOfBusinessLogic(updated: ItemNest) {
        print("sent")
        print(updated)
        self.items.append(updated)
    }
    
    @IBAction func addNewItemEnd(_ sender: UITextField) {
        let newItem: ItemNest = ItemNest(name: sender.text!, nest: [ItemNest](), parent: nil)
        items.append(newItem)
        saveList()
        self.tableView.reloadData()
        newTextField.text = ""
    }
    
    @IBAction func checkoff(_ sender: UIButton) {
        //items.remove(at: sender.)
        let buttonPosition = sender.convert(CGPoint.zero, to: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
        items.remove(at: (indexPath?.row)!)
        saveList()
        tableView.deleteRows(at: [(indexPath)!], with: .top)
    }
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

