//
//  AlarmStorage.swift
//  Alarm
//
//  Created by Valeriia Zakharova on 23.04.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import Foundation

class AlarmStorage {
    
    private var alarms: [Alarm] = []
    
    func addalarm(_ alarm: Alarm) {
        alarms.append(alarm)
    }
    
    func getAlarms() -> [Alarm] {
        return alarms
        
    }
}
