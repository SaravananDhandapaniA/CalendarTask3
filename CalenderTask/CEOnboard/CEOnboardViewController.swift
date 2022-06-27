//
//  CEOnboardViewController.swift
//  CalenderTask
//
//  Created by Tringapps on 27/06/22.
//

import UIKit

class CEOnboardViewController: UIViewController , CEOnboardPageViewDelegate {
    
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
        if let index = OnBoardPageViewController?.currentIndex {
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
        if let index = OnBoardPageViewController?.currentIndex {
            switch index {
            case 0:
                dismiss(animated: true, completion: nil)
            case 1...2:
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
        if let index = OnBoardPageViewController?.currentIndex {
            switch index {
            case 0:
                nextButton.setTitle("NEXT", for: .normal)
                skipButton.setTitle("SKIP", for: .normal)
                skipButton.isHidden = false
            case 1:
                nextButton.setTitle("NEXT", for: .normal)
                skipButton.setTitle("PREV", for: .normal)
                skipButton.isHidden = false
            case 2:
                nextButton.setTitle("NEXT", for: .normal)
                skipButton.setTitle("PREV", for: .normal)
                skipButton.isHidden = false
            case 3:
                nextButton.setTitle("START", for: .normal)
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
