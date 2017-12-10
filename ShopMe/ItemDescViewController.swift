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

    
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    var user: User!
    var ref: DatabaseReference!
    private var databaseHandle: DatabaseHandle!
    var department = ""
    var item = ""
    var number = 0
    var array = [String]()
    
    let produce:[String] = ["$1.09", "$0.18", "$2.72", "$1.69", "$0.89", "$1.92", "$0.66", "$0.51"]
    let snacks:[String] = ["$3.40", "$2.92", "$4.50", "$2.28", "$3.23", "$2.92", "$2.50", "$4.54"]
    let pasta:[String] = ["$2.26", "$1.46", "$1.46", "$3.40", "$1.46", "$4.36", "$0.32", "$0.32"]
    let breakfast:[String] = ["$2.79", "$2.55", "$3.75", "$3.75", "$3.97", "3$.75", "$3.74", "$3.01"]
    let frozen:[String] = ["$5.99", "$2.71", "$3.40", "$6.79", "$3.41", "$3.56", "$3.39", "$2.71"]
    let dairy:[String] = ["$2.03", "$3.74", "$2.94", "$4.53", "$2.94", "$2.94", "$3.40", "$0.99"]
    let pantry:[String] = ["$2.27", "$2.85", "$2.90", "$4.50", "$2.90", "$3.97", "$2.60", "$1.22"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user = Auth.auth().currentUser
        ref = Database.database().reference()
        print(department)
        print(number)
        
        if department == "produce" {
            array = produce
        }
        if department == "dairy" {
            array = dairy
        }
        if department == "frozen" {
            array = frozen
        }
        if department == "breakfast" {
            array = breakfast
        }
        if department == "pasta" {
            array = pasta
        }
        if department == "snacks" {
            array = snacks
        }
        if department == "pantry" {
            array = pantry
        }
        
        self.itemName.text = item
        self.itemPrice.text = array[number]
        self.itemImage.image = UIImage(named: item + ".png")
        
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
