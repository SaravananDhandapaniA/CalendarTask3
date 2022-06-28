//
//  CEOnboardPageController.swift
//  CalenderTask
//
//  Created by Tringapps on 27/06/22.
//

import UIKit

protocol CEOnboardPageViewDelegate : NSObjectProtocol {
    func didUpdatePageIndex(curretIndex: Int)
}

class CEOnboardPageController: UIPageViewController , UIPageViewControllerDataSource , UIPageViewControllerDelegate{
   
    weak var pageDelegate : CEOnboardPageViewDelegate?
   var viewModel = CEOnBoardViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        
        if let starting = contentViewController(at: 0){
            setViewControllers([starting], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! CEOnboardingContentController).index
        index -= 1
        return contentViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! CEOnboardingContentController).index
        index += 1
        return contentViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let contentView = pageViewController.viewControllers?.first as? CEOnboardingContentController {
                viewModel.currentIndex = contentView.index
                pageDelegate?.didUpdatePageIndex(curretIndex: viewModel.currentIndex)
            }
        }
    }
    
    
    func contentViewController(at index: Int) -> CEOnboardingContentController? {
        if index < 0 || index >= viewModel.pageTitle.count {
            return nil
        }
        
        let storyBoard = UIStoryboard(name: "CEOnboarding", bundle: nil)
        if let onBoardPageController = storyBoard.instantiateViewController(withIdentifier: "CEOnboardingContentController") as? CEOnboardingContentController {
            onBoardPageController.animationFile = viewModel.pageAnimation[index]
            onBoardPageController.heading = viewModel.pageTitle[index]
            onBoardPageController.subHeading = viewModel.pageSubTitle[index]
            onBoardPageController.index = index
            
            return onBoardPageController
        }
        return nil
    }
    
    func forwardPage(){
        viewModel.currentIndex += 1
        if let nextViewController = contentViewController(at: viewModel.currentIndex) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func backwardPage() {
        viewModel.currentIndex -= 1
        if let nextViewController = contentViewController(at: viewModel.currentIndex) {
            setViewControllers([nextViewController], direction: .reverse, animated: true, completion: nil)
        }
    }
}
