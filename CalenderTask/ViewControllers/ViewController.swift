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
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        let storyBoard = UIStoryboard(name: "CEOnboarding", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "CEOnboardViewController") as? CEOnboardViewController {
            present(vc, animated: true, completion: nil)
        }
    }
    
}
