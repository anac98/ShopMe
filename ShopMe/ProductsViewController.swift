//
//  ProductsViewController.swift
//  iOSProject12
//
//  Created by Ke, Joshua C on 12/7/17.
//  Copyright © 2017 Ke, Joshua C. All rights reserved.
//

import UIKit
import CoreData

class ProductsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var myCollectionView3: UICollectionView!
    var departments: [String] = ["dairy", "frozen", "pasta", "produce", "snacks", "pantry", "breakfast"]
    var department = ""
    var array = [String]()
    

    let produce:[String] = ["apple", "banana", "broccoli", "carrots", "celery", "spinach", "pear", "tomato"]
    let snacks:[String] = ["cheetos", "chipsahoy", "doritos", "fruitsnacks", "popcorn", "ritz", "skittles", "zbar"]
    let pasta:[String] = ["barilla", "elbows", "farfalle", "macncheese", "penne", "ramen", "ramen2", "ramen3"]
    let breakfast:[String] = ["cheerios", "chewy", "cinnamon", "cocoa", "granola", "honeynut", "oatmeal", "poptarts"]
    let frozen:[String] = ["icecream", "pancakes", "peas", "pizzarolls", "popsicle", "texastoast", "uncrustables", "waffles"]
    let dairy:[String] = ["chocmilk", "milk", "mozzarellacheese", "parmesan", "sharpcheddar", "smokybacon", "stringcheese", "yogurt"]
    let pantry:[String] = ["cayenne", "jif", "ketchup", "mayo", "mustard", "nutella", "oil", "syrup"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setDept()
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as! myCell3
        cell3.myImageView3.image = UIImage(named: array[indexPath.row] + ".png")
        cell3.myLabelView3.text = array[indexPath.row]
        cell3.layer.cornerRadius = cell3.frame.size.width/2
        cell3.clipsToBounds = true
        return cell3
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDesc" {
            
            let detailsVC = segue.destination as! ItemDescViewController
            let cell = sender as! myCell3
            let indexPaths = self.myCollectionView3.indexPath(for: cell)
            let thisItem = self.array[indexPaths!.row]
            detailsVC.department = department
            detailsVC.item = thisItem
            detailsVC.number = (indexPaths?.row)!
            
        }
    }
    
}

