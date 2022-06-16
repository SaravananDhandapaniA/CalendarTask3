//
//  CalendarViewModel.swift
//  CalenderTask
//
//  Created by Tringapps on 13/06/22.
//

import Foundation
import UIKit

class CalendarViewModel {
    let calendar = Calendar.current
    func plusMonth(date: Date) -> Date {
        return calendar.date(byAdding: .month, value: 1, to: date)!
    }
    func minusMonth(date: Date) -> Date {
        return calendar.date(byAdding: .month, value: -1, to: date)!
    }
    func dayString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: date)
    }
    func monthString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: date)
    }
    func yearString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
        return dateFormatter.string(from: date)
    }
    func daysInMonth(date: Date) -> Int {
        guard let range = calendar.range(of: .day, in: .month, for: date) else {return Int()}
        return range.count
    }
    func monthsInYear(date: Date) -> Int {
        guard let range = calendar.range(of: .month, in: .year, for: date) else {return Int()}
        return range.count
    }
    func dayOfMonth(date: Date) -> Int? {
        let components = calendar.dateComponents([.day], from: date)
        return components.day
    }
    func firstOfMonth(date: Date) -> Date {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }
    func weekDay(date: Date) -> Int {
        let components = calendar.dateComponents([.weekday], from: date)
        return components.weekday! - 1
    }
}
