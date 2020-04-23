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
    
    var alarmsStorage = AlarmStorage()
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nc = segue.destination as! UINavigationController
        let vc = nc.topViewController as! CreateAlarmViewController
        vc.alarmsStorage = alarmsStorage
    }

    @IBAction func createTapped(_ sender: Any) {
        
//        let vc = CreateAlarmViewController()
//        vc.alarmsStorage = alarmsStorage
//        let nc = UINavigationController(rootViewController: vc)
//        self.present(nc, animated: true, completion: nil)
        
    }
    
}

extension AlarmListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmsStorage.getAlarms().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlarmCell", for: indexPath)
        
        cell.textLabel?.text = alarmsStorage.getAlarms()[indexPath.row].title
        cell.detailTextLabel?.text = alarmsStorage.getAlarms()[indexPath.row].time
        
        return cell
    }
    
}
