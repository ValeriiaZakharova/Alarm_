//
//  AlarmNotificationManager.swift
//  Alarm
//
//  Created by Valeriia Zakharova on 27.04.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import UIKit

class AlarmNotificationManager {
    
    func scheduleRequest(for alarm: Alarm) {
        
        print("alarm has been scheduled: \(alarm.title)")
        let center = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        content.title = alarm.title // "Wake up"
        content.body = "don't sleep"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["alarmData": "bzzzz"]
        content.sound = UNNotificationSound.default
        
        let dateComponents: DateComponents = Calendar.current.dateComponents([.hour, .minute], from: alarm.time)
    
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: alarm.identifier.uuidString, content: content, trigger: trigger)

        center.add(request)
    }
    
    func turnOff(alarm: Alarm) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [alarm.identifier.uuidString])
        print("Turning off alarm: \(alarm.title)")

    }
    
    func turnOn(alarm: Alarm) {
        print("Turning on alarm: \(alarm.title)")
        self.scheduleRequest(for: alarm)
    }
}
