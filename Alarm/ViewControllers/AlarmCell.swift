//
//  AlarmCell.swift
//  Alarm
//
//  Created by Valeriia Zakharova on 23.04.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import UIKit

class AlarmCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var daysLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    func updateCell(model: Alarm) {
        titleLabel.text = model.title
        timeLabel.text = model.time
        daysLabel.text = model.iterate.map({ (day) -> String in
            day.shortName()
        }).joined(separator: " ")
        
    }

    @IBAction func toggleTapped(_ sender: UISwitch) {
        
    }
}
