//
//  CategoryViewController.swift
//  iOSProject12
//
//  Created by Ke, Joshua C on 11/20/17.
//  Copyright © 2017 Ke, Joshua C. All rights reserved.
//

import UIKit

class DepartmentViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var myCollectionView2: UICollectionView!
    
    let array:[String] = ["dairy", "frozen", "meat", "pasta", "produce", "snacks", "pantry", "breakfast"]
    let array2:[String] = ["dairy", "frozen", "meat", "pasta", "produce", "snacks", "pantry", "breakfast"]
    
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
        let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! myCell2
        cell2.myImageView2.image = UIImage(named: (array[indexPath.row] + ".jpg"))
        cell2.myLabelView2.text = array2[indexPath.row]
        cell2.layer.cornerRadius = cell2.frame.size.width/2
        cell2.clipsToBounds = true
        return cell2
    }
 
}
