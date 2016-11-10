//
//  PickekCell.swift
//  test2
//
//  Created by Alex on 11/10/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

protocol PickerViewDelegate {
    func userSelected (choice:Int)
}


class PickerCell: UITableViewCell {

    @IBOutlet weak var picker: UIPickerView!
    var pickerViewdelegate: PickerViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      //      picker.showsSelectionIndicator = false

            picker.selectRow (0, inComponent: 0, animated: false)
 
    }
    
}


extension PickerCell: UIPickerViewDataSource, UIPickerViewDelegate {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    

    
    func pickerView (_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return 10
        
        
    }
    
    // MARK: UIPickerViewDelegate
    func pickerView (_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        picker.subviews[1].isHidden = true
        picker.subviews[2].isHidden = true
        return String (row)
        
    }
    
    internal func pickerView (_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
        pickerViewdelegate?.userSelected (choice: 3)
    }
    

}
