//
//  CEMainCalendarViewModel.swift
//  CalenderTask
//
//  Created by Tringapps on 24/06/22.
//

import Foundation

class CEMainCalendarViewModel {
     
    var calenderData = CalendarViewModel()
    
    var daysInMonth : Int {
        return calenderData.daysInMonth(date: Date())
    }
    
}
