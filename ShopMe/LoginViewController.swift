//
//  ViewController.swift
//  iOSProject
//
//  Created by Ke, Joshua C on 10/30/17.
//  Copyright © 2017 Ke, Joshua C. All rights reserved.
//

import UIKit
import FirebaseAuth


class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var createAccount: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        // Do any additional setup after loading the view, typically from a nib.
        createAccount.setTitleColor(UIColor.gray, for: .disabled)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            self.presentLoggedInScreen()
        }
    }
    
    @IBAction func createAccountTapped(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password, completion: { user, error in
                if let firebaseError = error {
                    print(firebaseError.localizedDescription)
                    return
                }
                self.presentLoggedInScreen()
                
            })
        }
        createAccount.isEnabled = false
        //im currently just greying out the button so you can tell that something changed
    }
    
    
    @IBAction func loginTapped(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if let firebaseError = error {
                    print(firebaseError.localizedDescription)
                    return
                }
                self.presentLoggedInScreen()
            })
        }
    }
    
    func presentLoggedInScreen() {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homepage = storyboard.instantiateViewController(withIdentifier: "Main")
//        let loggedInVC:LoggedInVC = storyboard.instantiateViewController(withIdentifier: "LoggedInVC") as! LoggedInVC
        self.present(homepage, animated: true, completion: nil)
    }
    
}


