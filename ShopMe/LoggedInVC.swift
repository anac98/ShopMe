//
//  LoggedInVC.swift
//  iOSProject
//
//  Created by Ke, Joshua C on 10/30/17.
//  Copyright © 2017 Ke, Joshua C. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoggedInVC: UIViewController {

    @IBAction func logoutTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            
            self.dismiss(animated: true, completion: nil)
            
            
        } catch {
            print("There was a problem logging out")
        }
        
    }
}
