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
    
    @IBOutlet weak var monday: UIButton!
    
    @IBOutlet weak var tuesday: UIButton!
    
    @IBOutlet weak var wednesday: UIButton!
    
    @IBOutlet weak var thursday: UIButton!
    
    @IBOutlet weak var friday: UIButton!
    
    @IBOutlet weak var saturday: UIButton!
    
    @IBOutlet weak var sunday: UIButton!
    
    private var timePicker: UIDatePicker?
    
    var alarmsStorage: AlarmStorage?
    
    var alarmManager: AlarmNotificationManager?
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTimePicker()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        
        guard
            let timeText = timeTextField.text,
            let time = timeFormatter.date(from: timeText),
            let title = titleTextField.text,
            title.count > 0
            else {
                showAlert()
                return
        }
        
        var days: [DayOfTheWeek] = []
        
        if monday.isSelected {
            days.append(.monday)
        }
        if tuesday.isSelected {
            days.append(.tuesday)
        }
        if wednesday.isSelected {
            days.append(.wednesday)
        }
        if thursday.isSelected {
            days.append(.thursday)
        }
        if friday.isSelected {
            days.append(.friday)
        }
        if saturday.isSelected {
            days.append(.saturday)
        }
        if sunday.isSelected {
            days.append(.sunday)
        }
        
        let newAlarm = Alarm(title: title, time: time, iterate: days)
        
        alarmsStorage?.add(alarm: newAlarm)
        alarmManager?.scheduleRequest(for: newAlarm)
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func daySelected(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.alpha = 0.5
        } else {
            sender.alpha = 1
        }
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
    
    //MARK: - Picker
    
    private func setUpTimePicker() {
        
        timePicker = UIDatePicker()
        timePicker?.datePickerMode = .time
        
        timePicker?.addTarget(self, action: #selector(timeChanged(timePicker:)), for: .valueChanged)
        
        timeTextField.inputView = timePicker
    }
    
    //MARK: - Alert
    
    func showAlert() {
        let alertController = UIAlertController(title: nil, message: "Please fill all fields", preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
