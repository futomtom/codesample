//
//  DatePickerCell.swift
//  test2
//
//  Created by Alex on 11/22/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class DatePickerCell: UITableViewCell {
    @IBOutlet weak var picker: UIDatePicker!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
