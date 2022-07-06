//
//  CEEventsOrganizerViewModel.swift
//  CalenderTask
//
//  Created by Tringapps on 05/07/22.
//

import Foundation


class CEEventsOrganizerViewModel {
    
    var height = [300,200,200,300,300,200,200,300,300,200]

    
    var eventsItem = CEMainCalendarViewController.presentDateFilteredArray
    
    var eventsCount : Int{
        let items = eventsItem
        print(items)
        return items.count 
    }
}
