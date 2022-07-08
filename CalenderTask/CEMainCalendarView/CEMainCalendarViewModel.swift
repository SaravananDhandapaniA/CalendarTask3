//
//  CEMainCalendarViewModel.swift
//  CalenderTask
//
//  Created by Tringapps on 24/06/22.
//

import Foundation

class CEMainCalendarViewModel {
     
    let numberOfDays: Int = 15
    var startDate = Date()
    var scrollDate: Date?
    let formatter: DateFormatter = DateFormatter()
    let calendar = Calendar.current
    var offset = DateComponents()
    var dates: [Date] = []
    var forwarArray: [Date] = []
    var backwardArray: [Date] = []
    var timeResult : [Date] = []
    
//    var calendar : Calendar {
//    var calc = Calendar.current
//      calc.timeZone = TimeZone(secondsFromGMT: -3600*10) ?? .current
//       return calc
//    }

    
    func dateArray() -> [Date] {
        var date1: [Date] = []
        var date2: [Date] = []
        for i in 0..<numberOfDays {
            offset.day = i
            let nextDate: Date = calendar.date(byAdding: offset, to: startDate) ?? Date()
            date1.append(nextDate)
        }
        
        for i in 1..<numberOfDays {
            offset.day = -i
            let nextDate: Date = calendar.date(byAdding: offset, to: startDate) ?? Date()
            date2.append(nextDate)
        }
        dates = date2.reversed() + date1
        
        return dates
    }

    func scrollForward() -> [Date] {
        var forwardDate: [Date] = []
        for i in 1..<numberOfDays {
            offset.day = i
            let nextDate: Date = calendar.date(byAdding: offset, to: scrollDate!) ?? Date()
            forwardDate.append(nextDate)
        }
        forwarArray = forwardDate
        dates = dates + forwarArray
        return dates
    }
    
    func scrollBackward() -> [Date]{
        var backwardDate: [Date] = []
        for i in 1..<5 {
            offset.day = -i
            let nextDate: Date = calendar.date(byAdding: offset, to: scrollDate!) ?? Date()
            backwardDate.append(nextDate)
        }
        backwardArray = backwardDate.reversed()
        dates.insert(contentsOf: backwardArray, at: 0)
//       print(dates)
        return dates
    }


    func timeArray(fromStart start: Date, toEnd end: Date, component: Calendar.Component, value: Int) -> [Date] {
        var working = start
        repeat {
            timeResult.append(working)
            guard let new = Calendar.current.date(byAdding: component, value: value, to: working) else { return timeResult }
            working = new
        } while working <= end
//        print(timeResult)
        return timeResult
    }
    
    
//    func currentTime(date: [Date]) -> [String]{
//        let date = date
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "hh:mm a"
//        let dateInString = dateFormatter.string(from: date)
//        return [dateInString]
//    }
    
    
//    func stringToDate() {
//    let dateString = "Thu, 22 Oct 2015 07:45:17 +0000"
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "EEE, dd MMM yyyy hh:mm:ss +zzzz"
//    dateFormatter.locale = Locale.init(identifier: "en_GB")
//
//    let dateObj = dateFormatter.date(from: dateString)
//
//    dateFormatter.dateFormat = "MM-dd-yyyy"
//    print("Dateobj: \(dateFormatter.string(from: dateObj!))")
//    }
//
//    func makeTimeInterval(startTime:String ,endTime:String) -> String
//    {
//
//        let timeFormat = DateFormatter()
//        timeFormat.dateFormat = "hh:mm a"
//        var fromTime:Date?  = (timeFormat.date(from:startTime))
//        let toTime:Date?  = (timeFormat.date(from:endTime))
//
//        var dateByAddingThirtyMinute : Date?
//        let timeinterval : TimeInterval = toTime?.timeIntervalSince((fromTime ?? Date())) ?? TimeInterval()
//        let numberOfIntervals : Double = timeinterval / 3600;
//        var formattedDateString : String?
//
//
//        for _ in stride(from: 0, to: Int(numberOfIntervals * 2), by: 1)
//        {
//            dateByAddingThirtyMinute = fromTime?.addingTimeInterval(1800)
//            fromTime = dateByAddingThirtyMinute
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "hh:mm a"
//            formattedDateString = dateFormatter.string(from: dateByAddingThirtyMinute ?? Date())
//            print("Time after 30 min = \(formattedDateString ?? "Sara")")
//
//        }
//
//        return formattedDateString ?? "Sara"
//
//    }
    
    func dayString(date: Date) -> String {
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
    
    func dayInWeek(_ date: Date) -> String {
        formatter.dateFormat = "EEE"
        return formatter.string(from: date)
    }
    
    func monthString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: -3600*10)
        return dateFormatter.string(from: date)
    }
    func yearString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
        return dateFormatter.string(from: date)
    }
    
    func dateConverter(string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
        let date = dateFormatter.date(from: string)
        return date ?? Date()
    }
    
    func presentDateConverter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM  d"
        return dateFormatter.string(from: date)
    }
    
    func timeCalculateConverter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
    }
    func convetTime(at index : Int) -> String {
        let date = timeResult[index]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
    }
    
    func dateStringConverter(date:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
//    func timeConverter(string: String) -> Date {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-mm-dd hh:mm a"
//        let date = dateFormatter.date(from: string)
//        return date ?? Date()
//    }

//    func dayString(date: Date) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "d"
//        return dateFormatter.string(from: date)
//    }
    
}
