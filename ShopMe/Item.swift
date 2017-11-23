//
//  Item.swift
//  ShopMe
//
//  Created by Joanna Wu on 11/18/17.
//  Copyright © 2017 Joanna Wu. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Item {
    
    var ref: DatabaseReference?
    var title: String?
    
    init(snapshot: DataSnapshot) {
        ref = snapshot.ref
        
        let data = snapshot.value as! Dictionary<String, String>
        title = data["title"]! as String
    }
    
}
