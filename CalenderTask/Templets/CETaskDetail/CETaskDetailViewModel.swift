//
//  CETaskDetailViewModel.swift
//  CalenderTask
//
//  Created by Tringapps on 07/07/22.
//

import Foundation

class CETaskDetailViewModel {

    
    var date : String {
        return CEEventsOrganizerViewController.selectedEvent?.date ?? ""
    }
    
    var title : String {
        return  CEEventsOrganizerViewController.selectedEvent?.title ?? ""
    }
    
    var location : String {
        return  CEEventsOrganizerViewController.selectedEvent?.location ?? ""
    }
    
    var repeatMode : String {
        return  CEEventsOrganizerViewController.selectedEvent?.repeatMode ?? ""
    }
    
    var eventType : String {
        return  CEEventsOrganizerViewController.selectedEvent?.eventType ?? ""
    }
    
    var color : String {
        return  CEEventsOrganizerViewController.selectedEvent?.color ?? ""
    }
}
