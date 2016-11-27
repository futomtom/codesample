//
//  TableViewController.swift
//  test2
//
//  Created by Alex on 11/9/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController ,PickerViewDelegate {
    var datePickerIndexPath: IndexPath?
    var lastVerticalOffset: CGFloat = 0


    override func viewDidLoad() {
        super.viewDidLoad()
        let segment: UISegmentedControl = UISegmentedControl(items: ["First", "Second"])
        segment.sizeToFit()
        segment.tintColor = UIColor(red:0.99, green:0.00, blue:0.25, alpha:1.00)
        segment.selectedSegmentIndex = 0;
      //  segment.setTitleTextAttributes([NSFontAttributeName: UIFont(name:"ProximaNova-Light", size: 15)!],for: UIControlState.normal)
        navigationItem.titleView = segment

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if datePickerIndexPath != nil {
            return 11
        }
        return 10
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  indexPath == datePickerIndexPath ? 90 : 44
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
       
        if datePickerIndexPath != nil && datePickerIndexPath!.row == indexPath.row {
         //   let cell = tableView.dequeueReusableCell (withIdentifier: "pickercell") as! PickerCell
            // cell.pickerViewdelegate = self
            
            
              let cell = tableView.dequeueReusableCell (withIdentifier: "datepickercell") as! DatePickerCell
            

        return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = "\(indexPath.row)"
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        if datePickerIndexPath != nil {
            print ("datepick=\( datePickerIndexPath!.row )")
            print ("Index=\( indexPath.row )")
        }
        
        tableView.beginUpdates ()
        if datePickerIndexPath != nil && datePickerIndexPath!.row - 1 == indexPath.row {
            // -1 is picker's parent
            print ("close")
            tableView.deleteRows (at: [ datePickerIndexPath! ], with: .fade)
            
            datePickerIndexPath = nil
        } else {
            print ("picker open")
            if datePickerIndexPath != nil {
                //if already other picker open close deselect it
                // case 3
                tableView.deleteRows (at: [ datePickerIndexPath! ], with: .fade)
            }
            datePickerIndexPath = calculateDatePickerIndexPath (indexPathSelected: indexPath)    //datePickerIndexPath update to new one
            tableView.insertRows (at: [ datePickerIndexPath! ], with: .fade)   //insert new one.
        }
        tableView.deselectRow (at: indexPath, animated: true)
        tableView.endUpdates ()
    }
    
    
    func calculateDatePickerIndexPath (indexPathSelected: IndexPath) -> IndexPath {
        if datePickerIndexPath != nil && datePickerIndexPath!.row < indexPathSelected.row {
            return IndexPath (row: indexPathSelected.row, section: 0)
        } else {
            
            return IndexPath (row: indexPathSelected.row+1, section: 0)
        }
    }
    
    func userSelected(choice: Int) {
        
    }
  /*
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let verticalOffset = scrollView.contentOffset.y
        navigationController?.navigationBar.alpha =  scrollView.contentOffset.y / 300
        print ("verticalOffset = \(verticalOffset)")
        let scrollAmount = verticalOffset - lastVerticalOffset  //get scrolling amount since last update
        print(scrollAmount)
        lastVerticalOffset = verticalOffset
    
    }
*/

}
