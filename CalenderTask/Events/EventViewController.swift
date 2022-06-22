//
//  ExampleEventViewController.swift
//  CalenderTask
//
//  Created by Tringapps on 21/06/22.
//

import UIKit

protocol addEventDelegate: NSObjectProtocol {
    func didAddEvent(_ events : EventDataModel)
}

class EventViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var startTimePicker: UIDatePicker!
    @IBOutlet weak var endTimePicker: UIDatePicker!
    @IBOutlet weak var addButton: UIButton!

    var startTime : String?
    var endTime : String?
    weak var delegate: addEventDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.isEnabled = false
    }

  func getDatafromDatePicker(){
      let startDate = startTimePicker.date
      let endDate = endTimePicker.date
      startTime = startDate.dateStringWith(strFormat: "hh:mm a")
      endTime = endDate.dateStringWith(strFormat: "hh:mm a")
  }
    
    @IBAction func addButtonTapped(_ sender: Any) {
       getDatafromDatePicker()
        let newEvent = EventDataModel(title: titleTextField.text, date: dateTextField.text, startTime: startTime, endTime: endTime)
        delegate?.didAddEvent(newEvent)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func titlechanged(_ sender: Any) {
        if titleTextField.text == "" {
            addButton.isEnabled = false
        } else {
            addButton.isEnabled = true
        }
    }
}





extension Date {
    func dateStringWith(strFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = Calendar.current.timeZone
        dateFormatter.locale = Calendar.current.locale
        dateFormatter.dateFormat = strFormat
        return dateFormatter.string(from: self)
    }
}
