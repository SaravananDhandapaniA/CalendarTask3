//
//  CEMainCalendarViewModel.swift
//  CalenderTask
//
//  Created by Tringapps on 24/06/22.
//

import Foundation

class CEMainCalendarViewModel {
     
    func arrayOfDates() -> NSArray {
            
            let numberOfDays: Int = 60
            let startDate = Date()
            let formatter: DateFormatter = DateFormatter()
            formatter.dateFormat = "d"
            let calendar = Calendar.current
            var offset = DateComponents()
            var dates: [Any] = [formatter.string(from: startDate)]
            
            for i in 1..<numberOfDays {
                offset.day = i
                let nextDay: Date? = calendar.date(byAdding: offset, to: startDate)
                let nextDayString = formatter.string(from: nextDay!)
                dates.append(nextDayString)
            }
            return dates as NSArray
        }
    
    func arrayOfDays() -> NSArray {
            
            let numberOfDays: Int = 30
            let startDate = Date()
            let formatter: DateFormatter = DateFormatter()
            formatter.dateFormat = "EEE"
            let calendar = Calendar.current
            var offset = DateComponents()
            var dates: [Any] = [formatter.string(from: startDate)]
            
            for i in 1..<numberOfDays {
                offset.day = i
                let nextDay: Date? = calendar.date(byAdding: offset, to: startDate)
                let nextDayString = formatter.string(from: nextDay!)
                dates.append(nextDayString)
            }
            return dates as NSArray
        }
    
    
}
