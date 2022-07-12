//
//  AddEventViewController.swift
//  CalenderTask
//
//  Created by Tringapps on 01/07/22.
//

import UIKit

protocol CEAddEventDelegate : NSObjectProtocol {
    func didReloadView()

}

class CEAddEventViewController: UIViewController , UISheetPresentationControllerDelegate , EventTypeButtonDelegate{
    
    @IBOutlet weak var addEventDoneButton: UIButton!
    
    @IBOutlet weak var addEventView: CEAddEventView!
    
    var viewModel = CEAddEventViewModel()
    
    let datePicker = UIDatePicker()
    let startTimePicker = UIDatePicker()
    let endTimePicker = UIDatePicker()
    var selectedColor : String?
    var selectedEventType: String?
    

    let persistance = CEPersistanceService.shared
    
//    weak var eventTypeDelegate: CEEventsTypeDelegate?
    weak var addEventDelegate: CEAddEventDelegate?

    var isButtonEnable = Bool()
    
    override var sheetPresentationController: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareSheet()
        prepareCollectionViewForAddEvents()
        addEventView.buttonDelegate = self
        prepareEventType()
        createDatePicker()
    }

    func prepareCollectionViewForAddEvents(){
        self.addEventView.resuableCollectionView.collectionView.register(UINib.init(nibName: "CEAddEventCollectionCell", bundle: .main), forCellWithReuseIdentifier: "CEAddEventCell")
        addEventView.resuableCollectionView.collectionView.delegate = self
        addEventView.resuableCollectionView.collectionView.dataSource = self
        addEventView.resuableCollectionView.collectionView.backgroundColor = UIColor(red: 214 / 255.0, green: 108 / 255.0, blue: 90 / 255.0, alpha: 1.0)
        if let layout = addEventView.resuableCollectionView.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
    }
    
    func prepareSheet() {
        sheetPresentationController.delegate = self
        sheetPresentationController.selectedDetentIdentifier = .medium
        sheetPresentationController.prefersGrabberVisible = true
        sheetPresentationController.detents = [.medium()]
    }
    
    func createDatePicker() {
        let toolBar1 = UIToolbar()
        let toolBar2 = UIToolbar()
        let toolBar3 = UIToolbar()
        toolBar1.sizeToFit()
        toolBar2.sizeToFit()
        toolBar3.sizeToFit()
        let doneButtonForDatePicker = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButonForDatePicker))
        let doneButtonForStartTime = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonForStartTime))
        let doneButtonForEndTime = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonForEndTime))
        toolBar1.setItems([doneButtonForDatePicker], animated: true)
        toolBar2.setItems([doneButtonForStartTime], animated: true)
        toolBar3.setItems([doneButtonForEndTime], animated: true)

        addEventView.dateTextField.inputAccessoryView = toolBar1
        addEventView.startTimeTextField.inputAccessoryView = toolBar2
        addEventView.endTimeTextField.inputAccessoryView = toolBar3
        
        addEventView.dateTextField.inputView = datePicker
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        
        addEventView.startTimeTextField.inputView = startTimePicker
        startTimePicker.preferredDatePickerStyle = .wheels
        startTimePicker.datePickerMode = .time
        
        addEventView.endTimeTextField.inputView = endTimePicker
        endTimePicker.preferredDatePickerStyle = .wheels
        endTimePicker.datePickerMode = .time
    }
    
    @objc func doneButonForDatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        addEventView.dateTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func doneButtonForStartTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        addEventView.startTimeTextField.text = formatter.string(from: startTimePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func doneButtonForEndTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        addEventView.endTimeTextField.text = formatter.string(from: endTimePicker.date)
        self.view.endEditing(true)
    }
    
    
    func didEventTypeButtonPress(sender: UIAlertController) {
        prepareEventType()
        self.present(sender, animated: true, completion: nil)
    }

    
    func prepareEventType() {
        selectedEventType = addEventView.pickerViewButton.titleLabel?.text
        if selectedEventType == "Event Type" {
            addEventView.startTimeTextField.isHidden = true
            addEventView.endTimeTextField.isHidden = true
            addEventView.pickerViewButton.isHidden = false
        } else if selectedEventType == "Meeting" {
            addEventView.startTimeTextField.isHidden = false
            addEventView.endTimeTextField.isHidden = false
            addEventView.pickerViewButton.isHidden = true
        } else if selectedEventType == "Allday" {
            addEventView.startTimeTextField.isHidden = true
            addEventView.endTimeTextField.isHidden = true
            addEventView.pickerViewButton.isHidden = false
            addEventView.pickerViewButton.isEnabled = false
        } else  if selectedEventType == "Remainder" {
            addEventView.startTimeTextField.isHidden = false
            addEventView.endTimeTextField.isHidden = true
            addEventView.pickerViewButton.isHidden = true
            addEventView.startTimeTextField.frame.origin = CGPoint(x: 150.0, y: 8.0)
        }
    }

    
    @IBAction func doneButtonClicked(_ sender: Any) {

        let newEvents = CalendarEvent(context: persistance.context)
        newEvents.date = addEventView.dateTextField.text
        newEvents.title = addEventView.titleTextField.text
        newEvents.color = selectedColor
        newEvents.eventType = selectedEventType
        newEvents.startTime = addEventView.startTimeTextField.text
        newEvents.endTime = addEventView.endTimeTextField.text
        newEvents.location = addEventView.locationTextField.text
        newEvents.repeatMode = addEventView.repeatModeTextField.text
        
        self.persistance.save()
        self.addEventDelegate?.didReloadView()
        self.dismiss(animated: true, completion: nil)
    }
    
   
    
    
}

extension CEAddEventViewController: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = addEventView.resuableCollectionView.collectionView.dequeueReusableCell(withReuseIdentifier: "CEAddEventCell", for: indexPath) as? CEAddEventCollectionCell else {return UICollectionViewCell()}
        cell.setupCell(color: viewModel.backgroundColorArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedColor = viewModel.backgroundColorArray[indexPath.row]
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    
}

