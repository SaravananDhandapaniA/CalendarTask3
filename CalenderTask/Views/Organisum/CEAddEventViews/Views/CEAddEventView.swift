//
//  CEAddEventView.swift
//  CalenderTask
//
//  Created by Tringapps on 02/07/22.
//

import UIKit

protocol EventTypeButtonDelegate: NSObject {
    func didEventTypeButtonPress(sender:UIAlertController)
}

protocol RepeatModeDelegate : NSObjectProtocol {
    func didRepeatTapped()
}


class CEAddEventView: UIView, UIPickerViewDelegate, UIPickerViewDataSource  {
    
   
    var viewModel = CEAddEventViewModel()
    var selectedRow = 0
    let screenWidth = UIScreen.main.bounds.width - 10
    let screenHeight = UIScreen.main.bounds.height / 2
    
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var titleTextField: UITextField!
        
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var repeatModeTextField: UITextField!
    
    @IBOutlet weak var resuableCollectionView: CEReusableCollectionView!
    
    @IBOutlet weak var pickerViewButton: UIButton!
    
    @IBOutlet weak var startTimeTextField: UITextField!
    
    @IBOutlet weak var endTimeTextField: UITextField!
    
    
    weak var buttonDelegate: EventTypeButtonDelegate?
    weak var repeatDelegate: RepeatModeDelegate?
    
    var view : UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        view = loadViewFromNib()
        view.frame = self.bounds
        addSubview(view)
    }
    
    func loadViewFromNib() ->UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CEAddEventView", bundle: bundle)
        guard let view = nib.instantiate(withOwner: self , options: nil).first as? UIView else{return UIView()}
        return view
    }
    

    @IBAction func popUpPickerClicked(_ sender: Any) {
        print("press ")
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: screenWidth, height: screenWidth)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.selectRow(selectedRow, inComponent: 0, animated: true)
        vc.view.addSubview(pickerView)
        pickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        
        let alert = UIAlertController(title: "Select Event Type", message: "", preferredStyle: .actionSheet)
        alert.popoverPresentationController?.sourceView = pickerViewButton
        alert.popoverPresentationController?.sourceRect = pickerViewButton.bounds
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction)
            in
        }))
        
        alert.addAction(UIAlertAction(title: "Select", style: .default, handler: { (UIAlertAction) in
            self.selectedRow = pickerView.selectedRow(inComponent: 0)
            let selected = self.viewModel.eventTypes [self.selectedRow]
            let name = selected
            self.pickerViewButton.setTitle(name, for: .normal)
        }))
        self.buttonDelegate?.didEventTypeButtonPress(sender: alert)

    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.eventTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
        label.text = Array(viewModel.eventTypes)[row]
        label.sizeToFit()
        return label
    }
    
    
    @IBAction func showDropDownButtonTapped(_ sender: Any) {
        repeatDelegate?.didRepeatTapped()
    }
    

}
