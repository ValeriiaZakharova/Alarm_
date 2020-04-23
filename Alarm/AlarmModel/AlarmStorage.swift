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
    
    func getAlarms() -> [Alarm] {
        return alarms
    }
    
    func saveStorage() {
        //let data = Data() // instead of create `Data()` you need to convert `alarms` into Data, see `Codable` and `JSONDecoder` | `JSONEncoder`
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(alarms) {
            defaults.set(encoded, forKey: "com.lera.storage.alarms")
        }
        
    }
}
