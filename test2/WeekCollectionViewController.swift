//
//  WeekCollectionViewController.swift
//  test2
//
//  Created by Alex on 11/10/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class WeekCollectionViewController: UICollectionViewController {
    var weekday = 5    //改一週顯示幾天

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
         clearsSelectionOnViewWillAppear = false
        setupLayout()

    }

    func setupLayout () {
        
        let layout:UICollectionViewFlowLayout = collectionView?.collectionViewLayout  as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        let columns = CGFloat(weekday)
        let width =  floor(view.bounds.width / columns) - 1 
        layout.itemSize = CGSize(width: width, height: width*1.2)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var v : UICollectionReusableView! = nil
        if kind == UICollectionElementKindSectionHeader {
             v = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier:"head", for: indexPath)  as! weekReusableView
       

        }
        return v
    }



    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 90
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.red
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
