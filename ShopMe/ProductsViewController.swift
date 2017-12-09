//
//  ProductsViewController.swift
//  iOSProject12
//
//  Created by Ke, Joshua C on 12/7/17.
//  Copyright © 2017 Ke, Joshua C. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var myCollectionView3: UICollectionView!
    
    let array:[String] = ["apple", "banana", "broccoli", "carrots", "celery", "spinach", "pomegranate", "brussels", "dragonfruit", "mango"]
    let array2:[String] = ["apple", "banana", "broccoli", "carrots", "celery", "spinach", "pomegranate","brussels", "dragonfruit", "mango"]
    //  let array:[String] = ["milk"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false;
        let itemSize = UIScreen.main.bounds.width/2 - 100
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumInteritemSpacing = 100
        layout.minimumLineSpacing = 100
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Number of views
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    //Populate view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as! myCell3
        //if myLabelView2.text = "dairy" {
        cell3.myImageView3.image = UIImage(named: array[indexPath.row] + ".png")
        cell3.myLabelView3.text = array2[indexPath.row]
        //} else {
        //      cell3.myImageView3.image = UIImage(named: array[indexPath.row] + ".png")
        
        //  }
        
        cell3.layer.cornerRadius = cell3.frame.size.width/2
        cell3.clipsToBounds = true
        return cell3
    }
    
}

