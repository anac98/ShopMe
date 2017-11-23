//
//  ListTableViewController.swift
//  ShopMe
//
//  Created by Joanna Wu on 10/28/17.
//  Copyright © 2017 Joanna Wu. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class ListTableViewController: UITableViewController {
    
    @IBOutlet var listTable: UITableView!
    var titleTextField: UITextField? = nil
    var alertController: UIAlertController? = nil
    var lists = [List]()
    var lTitle: String?
    
    var user: User!
    var ref: DatabaseReference!
    private var databaseHandle: DatabaseHandle!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user = Auth.auth().currentUser
        ref = Database.database().reference()
        
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.layoutMargins = UIEdgeInsets.zero
        navigationItem.title = "Shopping Lists"
        startObservingDatabase()
        //cell.layoutMargins = UIEdgeInsets.Zero


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    @IBAction func addList(_ sender: Any) {
        getListName()
    }
    
    func getListName() {
        self.alertController = UIAlertController(title: "List Name", message: "Enter a title for your shopping list", preferredStyle: UIAlertControllerStyle.alert)
        let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            let userInput = self.alertController!.textFields![0].text
            if userInput!.isEmpty {
                return
            }
//            self.lTitle = self.titleTextField!.text!
//            self.lists.append(List(snapshot: self.lTitle!))
//            self.listTable.reloadData()
            self.ref.child("users").child(self.user.uid).child("lists").childByAutoId().child("title").setValue(userInput)
            
        })
        self.alertController!.addAction(ok)
        self.alertController!.addTextField { (textField) -> Void in
            // Enter the textfield customization code here.
            self.titleTextField = textField
            self.titleTextField?.placeholder = "Enter Shopping List Title"
        }
        
        present(self.alertController!, animated: true, completion: nil)
        
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
        return lists.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listName", for: indexPath)
        //let list = lists[indexPath.row]
        let rowNumber = indexPath.row
        cell.textLabel?.text = lists[rowNumber].title
        cell.detailTextLabel?.text = "11/21"

        // Configure the cell...
        return cell
    }
 
    func startObservingDatabase () {
        databaseHandle = ref.child("users/\(self.user.uid)/lists").observe(.value, with: { (snapshot) in
            var newLists = [List]()
            
            for listSnapShot in snapshot.children {
                let list = List(snapshot: listSnapShot as! DataSnapshot)
                newLists.append(list)
            }
            
            self.lists = newLists
            self.tableView.reloadData()
            
        })
    }
    
    deinit {
        ref.child("users/\(self.user.uid)/lists").removeObserver(withHandle: databaseHandle)
    }
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let list = lists[indexPath.row]
            list.ref?.removeValue()
            // Delete the row from the data source
            //tableView.deleteRows(at: [indexPath], with: .fade)
        }
//        else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
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

}
