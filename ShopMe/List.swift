
//
//  List.swift
//  ShopMe
//
//  Created by Joanna Wu on 11/21/17.
//  Copyright © 2017 Joanna Wu. All rights reserved.
//

import Foundation
import FirebaseDatabase

class List {
    
    var ref: DatabaseReference?
    var title: String?
    //var items = String?
//    var dictionary : [String: [String : Item]] = [:[:]]
    
    init(snapshot: DataSnapshot) {
        ref = snapshot.ref

        let data = snapshot.value as! Dictionary<String,String> //
        title = data["title"]! as String
        //items = data["items"]! as String
    }
}
