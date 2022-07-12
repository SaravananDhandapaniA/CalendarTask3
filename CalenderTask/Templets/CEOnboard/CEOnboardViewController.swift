//
//  CEOnboardViewController.swift
//  CalenderTask
//
//  Created by Tringapps on 27/06/22.
//

import UIKit

class CEOnboardViewController: UIViewController , CEOnboardPageViewDelegate {
    
    @IBOutlet weak var nextwidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var skipWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var skipHeightConstraint: NSLayoutConstraint!
    
    
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton! {
        didSet{
            nextButton.layer.cornerRadius = 25
            nextButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var skipButton: UIButton! {
        didSet{
            skipButton.layer.cornerRadius = 25
            skipButton.layer.masksToBounds = true
        }
    }
    
    var OnBoardPageViewController : CEOnboardPageController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        if let index = OnBoardPageViewController?.viewModel.currentIndex {
            switch index {
            case 0...2:
                OnBoardPageViewController?.forwardPage()
            case 3:
                dismiss(animated: true, completion: nil)
               
            default : break
            }
        }
        updateUI()
    }
    
    @IBAction func skipButtonTapped(_ sender: Any) {
        if let index = OnBoardPageViewController?.viewModel.currentIndex{
            switch index {
            case 0:
                dismiss(animated: true, completion: nil)

            case 1:
                OnBoardPageViewController?.backwardPage()
            case 2:
                OnBoardPageViewController?.backwardPage()
            case 3:
                dismiss(animated: true, completion: nil)

            default : break
            }
        }
        updateUI()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let pageVc = destination as? CEOnboardPageController {
            OnBoardPageViewController = pageVc
            OnBoardPageViewController?.pageDelegate = self
        }
    }
    
    func updateUI() {
        if let index = OnBoardPageViewController?.viewModel.currentIndex {
            switch index {
            case 0:
                nextButton.setTitle("NEXT", for: .normal)
                skipButton.setTitle("SKIP", for: .normal)
                nextButton.frame.origin = CGPoint(x: 0, y: 46)
                skipButton.frame.origin = CGPoint(x: 0, y: 116)
//                nextwidthConstraint.constant = 200
//                nextHeightConstraint.constant = 50
//                skipWidthConstraint.constant = 200
//                skipHeightConstraint.constant = 50
//                nextButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
//                nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//                skipButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
//                skipButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
                skipButton.isHidden = false
            case 1:
                nextButton.setTitle(">", for: .normal)
                skipButton.setTitle("<", for: .normal)
                nextButton.frame.origin = CGPoint(x: 100, y: 46)
                skipButton.frame.origin = CGPoint(x: -100, y: 46)
//                nextButton.translatesAutoresizingMaskIntoConstraints = false
//                skipButton.translatesAutoresizingMaskIntoConstraints = false
//                nextwidthConstraint.constant = 100
//                nextHeightConstraint.constant = 50
//                skipWidthConstraint.constant = 100
//                skipHeightConstraint.constant = 50
//                nextButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
//                nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//                skipButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
//                skipButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
                skipButton.isHidden = false
            case 2:
                nextButton.setTitle(">", for: .normal)
                skipButton.setTitle("<", for: .normal)
                nextButton.frame.origin = CGPoint(x: 100, y: 46)
                skipButton.frame.origin = CGPoint(x: -100, y: 46)
//                nextwidthConstraint.constant = 100
//                nextHeightConstraint.constant = 50
//                skipWidthConstraint.constant = 100
//                skipHeightConstraint.constant = 50
//                nextButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
//                nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//                skipButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
//                skipButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
                skipButton.isHidden = false
            case 3:
                nextButton.setTitle("START", for: .normal)
                nextButton.frame.origin = CGPoint(x: 0, y: 46)
                skipButton.frame.origin = CGPoint(x: 0, y: 116)
//                nextwidthConstraint.constant = 200
//                nextHeightConstraint.constant = 50
//                skipWidthConstraint.constant = 200
//                skipHeightConstraint.constant = 50
//                nextButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
//                nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//                skipButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
//                skipButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
                skipButton.isHidden = true
            default: break
            }
            pageControl.currentPage = index
        }
    }
    
    func didUpdatePageIndex(curretIndex: Int) {
        updateUI()
    }
    
}
