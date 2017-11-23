//
//  AddListTableViewController.swift
//  
//
//  Created by Joanna Wu on 10/30/17.
//

import Foundation
import UIKit
import Firebase

class AddListTableViewController: UITableViewController {
    
    var user: User!
    var lists: List!
    var alertController: UIAlertController? = nil
    var titleTextField: UITextField? = nil
    var listTitle: String? = ""
    var items = [Item]()
    var ref: DatabaseReference!
    private var databaseHandle: DatabaseHandle!
    
    //@IBOutlet weak var itemTextField: UITextField!
    //var ok: UIAlertAction? = NSObject
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user = Auth.auth().currentUser
        ref = Database.database().reference()
        
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.layoutMargins = UIEdgeInsets.zero
        startObservingDatabase()
        //getListName()
        //setListName(action: (alertController?.actions[0])!)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func getListName() {
//        self.alertController = UIAlertController(title: "List Name", message: "Enter a title for your shopping list", preferredStyle: UIAlertControllerStyle.alert)
//        let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) -> Void in
//            self.navigationItem.title = self.titleTextField!.text!
//        })
//        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (action) -> Void in
//            let goBack = self.storyboard?.instantiateViewController(withIdentifier: "listView")
//            self.present(goBack!, animated: true, completion: nil)
//        }
//        self.alertController!.addAction(ok)
//        self.alertController!.addAction(cancel)
//
//        self.alertController!.addTextField { (textField) -> Void in
//            // Enter the textfield customization code here.
//            self.titleTextField = textField
//            self.titleTextField?.placeholder = "Enter Shopping List Title"
//        }
//
//        present(self.alertController!, animated: true, completion: nil)
//
//    }

    //    func addItem() {
//        let key = items.childByAutoId().key
//        let item = ["id": key,
//                    "itemName": itemTextField.text! as String]
//        items.child(key).setValue(item)
//    }

    @IBAction func addItem(_ sender: Any) {
        createItemCell()
    }
    
    func createItemCell() {
        self.alertController = UIAlertController(title: "Item Name", message: "Enter an item", preferredStyle: UIAlertControllerStyle.alert)
        let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            let userInput = self.alertController!.textFields![0].text
            if userInput!.isEmpty {
                return
            }
            //            self.lTitle = self.titleTextField!.text!
            //            self.lists.append(List(snapshot: self.lTitle!))
            //            self.listTable.reloadData()
            self.ref.child("users").child(self.user.uid).child("items").childByAutoId().child("title").setValue(userInput)
            
        })
        self.alertController!.addAction(ok)
        self.alertController!.addTextField { (textField) -> Void in
            // Enter the textfield customization code here.
            self.titleTextField = textField
            self.titleTextField?.placeholder = "Enter Item Name"
        }
        
        present(self.alertController!, animated: true, completion: nil)
    }
//    func createTableRow() -> UITableViewCell {
//        let cell: customCell = self.tableView.dequeueReusableCell(withIdentifier: "textField") as UITableViewCell! as! customCell
//        let tf = UITextField(frame: CGRect(x:20, y:0, width: 300, height: 20))
//        tf.placeholder = "Enter text here"
//        tf.font = UIFont.systemFont(ofSize: 15)
//        cell.addSubview(tf)
//        return cell
//    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of section
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemName2", for: indexPath)
        //let list = lists[indexPath.row]
        let rowNumber = indexPath.row
        cell.textLabel?.text = items[rowNumber].title
        //cell.detailTextLabel?.text = "11/21"
        
        // Configure the cell...
        return cell
//        let cell: customCell = self.tableView.dequeueReusableCell(withIdentifier: "textField") as UITableViewCell! as! customCell
//        let tf = UITextField(frame: CGRect(x:20, y:0, width: 300, height: 20))
//        tf.placeholder = "Enter text here"
//        tf.font = UIFont.systemFont(ofSize: 15)
//        cell.addSubview(tf)
//        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = items[indexPath.row]
            item.ref?.removeValue()
        }
    }
    
    func startObservingDatabase () {
        databaseHandle = ref.child("users/\(self.user.uid)/items").observe(.value, with: { (snapshot) in
            var newItems = [Item]()
            
            for itemSnapShot in snapshot.children {
                let item = Item(snapshot: itemSnapShot as! DataSnapshot)
                newItems.append(item)
            }
            
            self.items = newItems
            self.tableView.reloadData()
            
        })
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
 
    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        navigationItem.title = self.listTitle
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
