//
//  ViewController.swift
//  Alarm
//
//  Created by Valeriia Zakharova on 22.04.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import UIKit

class AlarmListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let alarmService = AlarmsService(alarmStorage: AlarmStorage(UserDefaults.standard),
                                             alarmNotificationManager: AlarmNotificationManager())
    
    private var alarms: [Alarm] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadList()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        reloadList()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nc = segue.destination as! UINavigationController
        let vc = nc.topViewController as! CreateAlarmViewController
        vc.alarmService = alarmService
    }
    
    private func reloadList() {
        alarmService.fetchAlarms(callback: { [weak self] alarms in
            guard let self = self else { return }
            self.alarms = alarms
            self.tableView.reloadData()
        })
    }
    
    @IBAction func createTapped(_ sender: Any) {
        //        let vc = CreateAlarmViewController()
        //        vc.alarmsStorage = alarmsStorage
        //        let nc = UINavigationController(rootViewController: vc)
        //        self.present(nc, animated: true, completion: nil)
    }
}

//MARK: - TableViewDataSource, TableViewDelegate Methods

extension AlarmListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlarmCell", for: indexPath) as! AlarmCell
        
        cell.updateCell(alarm: alarms[indexPath.row])
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let alarm = alarms[indexPath.row]
        
        if editingStyle == .delete {
            alarmService.remove(alarm: alarm)
            print("\(alarm.title) has been deleted")
            reloadList()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: -  Alarm Cell Delegate

extension AlarmListViewController: AlarmCellDelegate {
    
    func toggleTapped(cell: AlarmCell) {
        
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let alarm = alarms[indexPath.row]
        
        if cell.toggle.isOn {
            alarmService.turnOn(alarm: alarm)
            reloadList()
        } else {
            alarmService.turnOff(alarm: alarm)
            reloadList()
        }
    }
}
