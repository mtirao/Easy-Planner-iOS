//
//  CalendarTableViewCell.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 5/16/17.
//  Copyright © 2017 Marcos Tirao. All rights reserved.
//

import UIKit

class CalendarTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var calendar: CalendarView!
    @IBOutlet weak var yearLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
