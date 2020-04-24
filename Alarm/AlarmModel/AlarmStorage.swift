//
//  AlarmStorage.swift
//  Alarm
//
//  Created by Valeriia Zakharova on 23.04.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import Foundation

class AlarmStorage {
    
    private var alarms: [Alarm] = [] {
        didSet {
            saveStorage()
        }
    }
    
    private let defaults: UserDefaults
    
    init(_ defaults: UserDefaults) {
        self.defaults = defaults
        if let data = defaults.object(forKey: "com.lera.storage.alarms") as? Data {
            let decoder = JSONDecoder()
            if let loadedAlarms = try? decoder.decode(Array<Alarm>.self, from: data) {
                alarms = loadedAlarms
            }
        }
    }
    
    func add(alarm: Alarm) {
        alarms.append(alarm)
    }
    
    /// request to local storage to get all alarms
    func fetchAlarms(callback: @escaping ([Alarm]) -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) { [weak self] in
            guard let self = self else {
                callback([])
                return
            }
            callback(self.alarms)
        }
    }
    
    func remove(alarm: Alarm) {
        /// find index of parameter `alarm`
        let alarmIndex = alarms.firstIndex(where: { internalAlarm -> Bool in
            return internalAlarm.identifier == alarm.identifier
        })
        
        guard let index = alarmIndex else {
            assertionFailure("There is no such alarm in storage: \(alarm.title)")
            return
        }
        alarms.remove(at: index)
    }
    
    func saveStorage() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(alarms) {
            defaults.set(encoded, forKey: "com.lera.storage.alarms")
        }
    }
}
