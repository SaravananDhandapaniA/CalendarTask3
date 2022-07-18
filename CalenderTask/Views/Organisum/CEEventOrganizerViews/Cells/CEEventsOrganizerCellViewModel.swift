//
//  CEEventsOrganizerCellViewModel.swift
//  CalenderTask
//
//  Created by Tringapps on 07/07/22.
//

import Foundation

class CEEventsOrganizerCellViewModel {
    
    var data:CalendarEvent?
    
    var convertDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: data?.date ?? "")
        return date ?? Date()
    }
    
    var date : String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM YYYY EEEE"
        return formatter.string(from: convertDate)
    }
    
    var startTime: String {
        return data?.startTime ?? "00:00"
    }
    
    var endTime: String {
        return data?.endTime ?? "00:00"
    }
    
    var title: String {
        return data?.title ?? ""
    }
    
    var color: String {
        return data?.color ?? ""
    }
    
    var eventType: String {
        return data?.eventType ?? ""
    }
    
}
