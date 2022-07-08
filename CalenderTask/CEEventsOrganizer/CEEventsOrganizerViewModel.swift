//
//  CEEventsOrganizerViewModel.swift
//  CalenderTask
//
//  Created by Tringapps on 05/07/22.
//

import Foundation


class CEEventsOrganizerViewModel {
    
    var height = [300,200,200,300,300,200,200,300,300,200]

    var eventArray: [CalendarEvent] {
       return CEMainCalendarViewController.presentDateFilteredArray
    }
    
    var eventsCount : Int{
        return eventArray.count
    }
}
