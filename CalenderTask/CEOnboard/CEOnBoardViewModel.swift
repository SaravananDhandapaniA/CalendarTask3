//
//  CEOnBoardViewModel.swift
//  CalenderTask
//
//  Created by Tringapps on 23/06/22.
//

import Foundation
import UIKit

class CEOnBoardViewModel {
    
    var summaryView: CEOnBoardSummary?


    var currentPage = 0 {
        didSet{
            summaryView?.pageControl.currentPage = currentPage
        }
    }

    var slides = [CEOnBoardModel]()

    func configData() {
        slides = [
            CEOnBoardModel(title: "Calendar", description: "1", image: #imageLiteral(resourceName: "slide1")),
            CEOnBoardModel(title: "Custom Calendar Events", description: "2", image: #imageLiteral(resourceName: "slide2")),
            CEOnBoardModel(title: "Persist the Event", description: "3", image: #imageLiteral(resourceName: "slide3")),
            CEOnBoardModel(title: "Custom Filter", description: "4", image: #imageLiteral(resourceName: "slide1"))
        ]
    }

//    func getCellIdentifier() -> String {
//
//        if currentPage == 0 {
//            return "CEOnboardCalendar"
//        } else if currentPage == 3 {
//            return "CEOnboardFilter"
//        } else {
//            return "CEOnboardEvent"
//        }
//    }
    
    
   

    
}
