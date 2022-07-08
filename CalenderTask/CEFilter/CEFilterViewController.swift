//
//  CEFilterViewController.swift
//  CalenderTask
//
//  Created by Tringapps on 07/07/22.
//

import UIKit

class CEFilterViewController: UIViewController , UISheetPresentationControllerDelegate{

    override var sheetPresentationController: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareSheet()
    }

    func prepareSheet() {
        sheetPresentationController.delegate = self
        sheetPresentationController.selectedDetentIdentifier = .medium
        sheetPresentationController.prefersGrabberVisible = true
        sheetPresentationController.detents = [.medium()]
    }
    
}
