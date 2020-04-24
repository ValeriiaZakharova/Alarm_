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
    
    private let alarmsStorage = AlarmStorage(UserDefaults.standard)
    
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
        vc.alarmsStorage = alarmsStorage
    }
    
    private func reloadList() {
        alarmsStorage.fetchAlarms(callback: { [weak self] alarms in
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
        
        cell.updateCell(model: alarms[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        let alarm = alarms[indexPath.row]
        
        if editingStyle == .delete {
            alarmsStorage.remove(alarm: alarm)
            reloadList()
        }
    }
}
