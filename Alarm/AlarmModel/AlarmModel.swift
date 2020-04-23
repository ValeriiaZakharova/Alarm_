//
//  AlarmModel.swift
//  Alarm
//
//  Created by Valeriia Zakharova on 22.04.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import Foundation

struct Alarm {

    var title: String
    var time: String
    var iterate: [DayOfTheWeek]?
}

enum DayOfTheWeek: String {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
}
