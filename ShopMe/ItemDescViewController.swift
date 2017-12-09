//
//  ItemDescViewController.swift
//  ShopMe
//
//  Created by Joanna Wu on 12/7/17.
//  Copyright © 2017 Joanna Wu. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class ItemDescViewController: UIViewController {

    @IBOutlet weak var itemName: UILabel!
    var user: User!
    var ref: DatabaseReference!
    private var databaseHandle: DatabaseHandle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user = Auth.auth().currentUser
        ref = Database.database().reference()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func addToList(_ sender: Any) {
        addToList()
    }
    
    func addToList() {
        self.ref.child("users").child(self.user.uid).child("lists").childByAutoId().child("title").setValue(itemName.text)
        self.presentLoggedInScreen()
    }
    
    
    func presentLoggedInScreen() {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homepage = storyboard.instantiateViewController(withIdentifier: "Main")
        //        let loggedInVC:LoggedInVC = storyboard.instantiateViewController(withIdentifier: "LoggedInVC") as! LoggedInVC
        self.present(homepage, animated: true, completion: nil)
    }
    /*
     
     
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
