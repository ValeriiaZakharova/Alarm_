//
//  AlarmCell.swift
//  Alarm
//
//  Created by Valeriia Zakharova on 23.04.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import UIKit

protocol AlarmCellDelegate: class {
    func toggleTapped(cell: AlarmCell)
}

class AlarmCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var daysLabel: UILabel!
    
    @IBOutlet weak var toggle: UISwitch!
    
    weak var delegate: AlarmCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    func updateCell(alarm: Alarm) {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        
        titleLabel.text = alarm.title
        timeLabel.text = dateFormatter.string(from: alarm.time)
        daysLabel.text = alarm.iterate.map({ (day) -> String in
            day.shortName()
        }).joined(separator: " ")
        toggle.isOn = alarm.isEnabled
    }

    @IBAction func toggleTapped(_ sender: UISwitch) {
        delegate?.toggleTapped(cell: self)
    }
}
