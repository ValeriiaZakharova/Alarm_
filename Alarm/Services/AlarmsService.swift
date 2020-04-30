//
//  AlarmsService.swift
//  Alarm
//
//  Created by Valeriia Zakharova on 29.04.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import Foundation

class AlarmsService {
    
    private let alarmStorage: AlarmStorage
    
    private let alarmNotificationManager: AlarmNotificationManager
    
    init(alarmStorage: AlarmStorage, alarmNotificationManager: AlarmNotificationManager) {
        self.alarmStorage = alarmStorage
        self.alarmNotificationManager = alarmNotificationManager
    }
    
    func fetchAlarms(callback: @escaping ([Alarm]) -> Void) {
        alarmStorage.fetchAlarms(callback: callback)
    }
    
    func create(alarm: Alarm) {
        alarmStorage.add(alarm: alarm)
        alarmNotificationManager.turnOn(alarm: alarm)
    }
    
    func remove(alarm: Alarm) {
        alarmStorage.remove(alarm: alarm)
        alarmNotificationManager.turnOff(alarm: alarm)
    }
    
    func turnOn(alarm: Alarm) {
        var alarmModel = alarm
        alarmModel.isEnabled = true
        alarmNotificationManager.turnOn(alarm: alarmModel)
        alarmStorage.update(alarm: alarmModel)
    }
    
    func turnOff(alarm: Alarm) {
        var alarmModel = alarm
        alarmModel.isEnabled = false
        alarmNotificationManager.turnOff(alarm: alarmModel)
        alarmStorage.update(alarm: alarmModel)
    }
}
