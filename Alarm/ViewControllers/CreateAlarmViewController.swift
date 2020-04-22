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
        
        // save a new alarm here
        
    }
    
    @objc func viewTapped(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func setUpTimePicker() {
        
        timePicker = UIDatePicker()
        timePicker?.datePickerMode = .time
        
        timePicker?.addTarget(self, action: #selector(timeChanged(timePicker:)), for: .valueChanged)
        
        timeTextField.inputView = timePicker
    }
    
    @objc func timeChanged(timePicker: UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        
        //timeFormatter.dateFormat = "HH:mm"
        timeTextField.text = timeFormatter.string(from: timePicker.date)
        view.endEditing(true)
    }

}
