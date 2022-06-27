//
//  CEInitialOnboardingCell.swift
//  CalenderTask
//
//  Created by Tringapps on 23/06/22.
//

import UIKit

class CEOnboardingCalendarCell: UICollectionViewCell {

    var viewModel = CEOnBoardViewModel()
    
    var index = IndexPath()

    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
  

    @IBAction func nextButtonTapped(_ sender: Any) {
        if viewModel.currentPage == (viewModel.slides.count) - 1 {
            print("IT IS IN LAST PAGE")
        } else {
            viewModel.currentPage += 1
            print("currentPage:\(viewModel.currentPage)")
        }
        
        print("clicked")
    }
    
    
}
