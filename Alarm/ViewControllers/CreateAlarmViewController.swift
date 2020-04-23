//
//  CreateNewAlarmViewController.swift
//  Alarm
//
//  Created by Valeriia Zakharova on 22.04.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import UIKit

class CreateAlarmViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var timeTextField: UITextField!
    
    private var timePicker: UIDatePicker?
    
    var alarmsStorage: AlarmStorage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // alarmsStorage?.getAlarms() = defaults.array(forKey: "AlarmsStorage") as! [Alarm]
        
        setUpTimePicker()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {

        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let time = timeTextField.text, let title = titleTextField.text else {
            return
        }
        
        let newAlarm = Alarm(title: title, time: time, iterate: [])
        alarmsStorage?.add(alarm: newAlarm)
    
        dismiss(animated: true, completion: nil)
    
    }
    
    @IBAction func daySelected(_ sender: UIButton) {
        
        
    }
    
    
    
    @objc func viewTapped(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func timeChanged(timePicker: UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        
        //timeFormatter.dateFormat = "HH:mm"
        timeTextField.text = timeFormatter.string(from: timePicker.date)
        view.endEditing(true)
    }
    
    private func setUpTimePicker() {
        
        timePicker = UIDatePicker()
        timePicker?.datePickerMode = .time
        
        timePicker?.addTarget(self, action: #selector(timeChanged(timePicker:)), for: .valueChanged)
        
        timeTextField.inputView = timePicker
    }

    
    func showAlert() {
        let alertController = UIAlertController(title: nil, message: "Please fill all fields", preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

}
