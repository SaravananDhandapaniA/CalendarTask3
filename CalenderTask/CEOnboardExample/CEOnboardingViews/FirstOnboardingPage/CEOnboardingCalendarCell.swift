//
//  CEInitialOnboardingCell.swift
//  CalenderTask
//
//  Created by Tringapps on 23/06/22.
//

import UIKit

class CEOnboardingCalendarCell: UICollectionViewCell {

//    var viewModel = CEOnBoardViewModel()
    
    var slides = [CEOnBoardModel]()
    var currentPage = 0
    
    func configData() {
        slides = [
            CEOnBoardModel(title: "Calendar", description: "1", image: #imageLiteral(resourceName: "slide1")),
            CEOnBoardModel(title: "Custom Calendar Events", description: "2", image: #imageLiteral(resourceName: "slide2")),
            CEOnBoardModel(title: "Persist the Event", description: "3", image: #imageLiteral(resourceName: "slide3")),
            CEOnBoardModel(title: "Custom Filter", description: "4", image: #imageLiteral(resourceName: "slide1"))
        ]
    }
    
    var index = IndexPath()

    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
  

    @IBAction func nextButtonTapped(_ sender: Any) {
        if currentPage == (slides.count) - 1 {
            print("IT IS IN LAST PAGE")
        } else {
            currentPage += 1
            print("currentPage:\(currentPage)")
        }
        
        print("clicked")
    }
    
    
}
