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
   // var quantityTextField: UITextField? = nil
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
        navigationItem.title = "Your Shopping List"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "Avenir Next Condensed", size: 20)!]
        //UILabel.appearance().font = UIFont(name: "Avenir Next", size: 17.0)


        startObservingDatabase()
        //cell.layoutMargins = UIEdgeInsets.Zero
        //self.view.addGestureRecognizer(UIGestureRecognizer(target:self.view, action: #selector(UIView.endEditing(_:))))


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }
    @IBAction func addList(_ sender: Any) {
        getListName()
    }
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        self.view.endEditing(true);
        return false;
    }
    
    func getListName() {
        self.alertController = UIAlertController(title: "Item Name", message: "Enter an item to add to your shopping list", preferredStyle: UIAlertControllerStyle.alert)
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
            textField.autocorrectionType = UITextAutocorrectionType.yes
            // Enter the textfield customization code here.
            self.titleTextField = textField
            self.titleTextField?.placeholder = "Enter Item Name"
        }
//        alertController?.addTextField() { (textField:UITextField!) -> Void in textField.autocorrectionType = UITextAutocorrectionType.yes }
    
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listName", for: indexPath) as! ItemTableViewCell
        //let list = lists[indexPath.row]
        let rowNumber = indexPath.row
        cell.itemName.text = lists[rowNumber].title
        //cell.detailTextLabel?.text = "11/21"

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
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:    #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
