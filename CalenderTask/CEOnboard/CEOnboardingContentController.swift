//
//  CEOnboardingController.swift
//  CalenderTask
//
//  Created by Tringapps on 27/06/22.
//

import UIKit
import Lottie

class CEOnboardingContentController: UIViewController {
    
    
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!

    
    var index = 0
    var heading = ""
    var subHeading = ""
    var animationFile = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        configData() 
       
    }
    
    func configData() {
        titleLabel.text = heading
        subTitleLabel.text = subHeading
        
        let animation = Animation.named(animationFile)
        animationView.animation = animation
        animationView.frame = view.bounds
        animationView.play()
        animationView.loopMode = .loop
        animationView.backgroundBehavior = .pauseAndRestore
    }
    
}
