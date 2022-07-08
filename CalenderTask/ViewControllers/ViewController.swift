//
//  ViewController.swift
//  CalenderTask
//
//  Created by Tringapps on 09/06/22.
//

import UIKit

class ViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        presentingOnboardVc()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    func presentingOnboardVc() {
        let storyBoard = UIStoryboard(name: "CEOnboarding", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "CEOnboardViewController") as? CEOnboardViewController {
            present(vc, animated: true, completion: nil)
        }
    }
    
}
