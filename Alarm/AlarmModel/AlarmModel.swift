//
//  AlarmModel.swift
//  Alarm
//
//  Created by Valeriia Zakharova on 22.04.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import Foundation

struct Alarm: Codable {
    var title: String
    var time: String
    var iterate: [DayOfTheWeek]
}

enum DayOfTheWeek: String, Codable {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
    
    func shortName() -> String {
        switch self {
        case .monday: return "Mn"
        case .tuesday: return "Tu"
        case .wednesday: return "Wd"
        case .thursday: return "Th"
        case .friday: return "Fr"
        case .saturday: return "St"
        case .sunday: return "Sn"
            
        }
    }
}
