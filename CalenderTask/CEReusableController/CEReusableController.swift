//
//  CEReusableController.swift
//  CalenderTask
//
//  Created by Tringapps on 27/06/22.
//

import UIKit

class CEReusableController: UIViewController , UISheetPresentationControllerDelegate {
    
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
