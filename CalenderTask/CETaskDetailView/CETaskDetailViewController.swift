//
//  CETaskDetailViewController.swift
//  CalenderTask
//
//  Created by Tringapps on 06/07/22.
//

import UIKit

class CETaskDetailViewController: UIViewController, UISheetPresentationControllerDelegate  {
  
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var eventColorView: UIView!
    
    @IBOutlet weak var dateField: UITextField!
    
    @IBOutlet weak var titleField: UITextField!
    
    @IBOutlet weak var locationField: UITextField!
    
    @IBOutlet weak var repeatModeField: UITextField!
    
    @IBOutlet weak var eventTypeField: UITextField!
    
    var viewModel = CETaskDetailViewModel()
    
    override var sheetPresentationController: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareSheet()
//        let vc = CEEventsOrganizerViewController()
//        vc.TaskDetailDelegate = self
        configDataForTaskDetail()
    }
    
    func prepareSheet() {
        sheetPresentationController.delegate = self
        sheetPresentationController.selectedDetentIdentifier = .medium
        sheetPresentationController.prefersGrabberVisible = true
        sheetPresentationController.detents = [.medium()]
    }
    
    func configDataForTaskDetail() {
        dateField.text = viewModel.date
        titleField.text = viewModel.title
        locationField.text = viewModel.location
        repeatModeField.text = viewModel.repeatMode
        eventTypeField.text = viewModel.eventType
        eventColorView.backgroundColor = UIColor(named: viewModel.color )
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
