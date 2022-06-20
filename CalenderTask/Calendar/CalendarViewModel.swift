//
//  CalendarViewModel.swift
//  CalenderTask
//
//  Created by Tringapps on 13/06/22.
//

import Foundation
import UIKit


class CalendarViewModel {

    let date = Date()
    let calendar = Calendar.current

    func plusMonth(date: Date) -> Date {
        return calendar.date(byAdding: .month, value: 1, to: date)!
    }
    func minusMonth(date: Date) -> Date {
        return calendar.date(byAdding: .month, value: -1, to: date)!
    }
    func dateString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
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
    func dateConverter(string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: string)
        return date!
    }

}


//let MonthsInYear = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
//let DaysOfMonth = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
//var DaysInMonths = [31,28,31,30,31,30,31,31,30,31,30,31]
//let date = Date()
//let calendar = Calendar.current
//
//var day = calendar.component(.day, from: date)
//var month = calendar.component(.month, from: date) - 1
//var year = calendar.component(.year, from: date)
//let weekday = calendar.component(.weekday, from: date)


//    var currentMonth = String()
//    var numberOfEmpty = Int()
//    var nextNumberOfEmptyBox = Int()
//    var prevNumberOfEmptyBox = 0
//    var direction = 0
//    var positionIndex = 0


//    func getStartDatePosition() {
//        switch direction {
//        case 0:
//            switch day{
//            case 1...7:
//                numberOfEmpty = weekday - day
//            case 8...14:
//                numberOfEmpty = weekday - day - 7
//            case 15...21:
//                numberOfEmpty = weekday - day - 14
//            case 22...28:
//                numberOfEmpty = weekday - day - 21
//            case 29...31:
//                numberOfEmpty = weekday - day - 28
//            default:
//                break
//            }
//            positionIndex = numberOfEmpty
//
//        case 1...:
//            nextNumberOfEmptyBox = (positionIndex + DaysInMonths[month]) % 7
//            positionIndex = nextNumberOfEmptyBox
//        case -1:
//            prevNumberOfEmptyBox = (7 - (DaysInMonths[month] - positionIndex) % 7)
//            if prevNumberOfEmptyBox == 7{
//                prevNumberOfEmptyBox = 0
//            }
//            positionIndex = prevNumberOfEmptyBox
//        default:
//            fatalError()
//        }
//    }
                                    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        switch direction{
//        case 0:
//            return DaysInMonths[month] + numberOfEmpty
//        case 1...:
//            return DaysInMonths[month] + nextNumberOfEmptyBox
//        case -1:
//            return DaysInMonths[month] + prevNumberOfEmptyBox
//        default:
//            fatalError()
//        }
//    }
    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as? CalendarCell else {return UICollectionViewCell()}
//        cell.backgroundColor = .clear
//        cell.dayOfMonth.textColor = .black
//
//        if cell.isHidden{
//            cell.isHidden = false
//        }
//
//        switch direction{
//        case 0:
//            cell.dayOfMonth.text = "\(indexPath.row + 1 - numberOfEmpty)"
//        case 1...:
//            cell.dayOfMonth.text = "\(indexPath.row + 1 - nextNumberOfEmptyBox)"
//        case -1:
//            cell.dayOfMonth.text = "\(indexPath.row + 1 - prevNumberOfEmptyBox)"
//        default:
//            fatalError()
//        }
//        if Int(cell.dayOfMonth.text!)! < 1{
//            cell.isHidden = true
//        }
//
//        if currentMonth == MonthsInYear[calendar.component(.month, from: date) - 1] && year == calendar.component(.year, from: date) && indexPath.row + 1 == day {
//            cell.backgroundColor = .red
//            cell.dayOfMonth.textColor = .white
//        }
//        cell.layer.cornerRadius = cell.frame.width / 2
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let cell = collectionView.cellForItem(at: indexPath) as? CalendarCell else {return}
//        cell.backgroundColor = .black
//        cell.dayOfMonth.textColor = .white
//        day = indexPath.row + 1
//        monthLabel.text = "\(day) \(currentMonth) \(year)"
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        guard let cell = collectionView.cellForItem(at: indexPath) as? CalendarCell else {return}
//               cell.backgroundColor = .clear
//               cell.dayOfMonth.textColor = .black
//    }
    



//        switch currentMonth {
//        case "December":
//            month = 0
//            year += 1
//            direction = 1
//            getStartDatePosition()
//            currentMonth = MonthsInYear[month]
//            monthLabel.text = "\(day)\(currentMonth) \(year)"
//            collectionView.reloadData()
//        default:
//            direction = 1
//            getStartDatePosition()
//            month += 1
//            currentMonth = MonthsInYear[month]
//            monthLabel.text = "\(day)\(currentMonth) \(year)"
//            collectionView.reloadData()
//        }


//        switch currentMonth {
//        case "January":
//            month = 11
//            year -= 1
//            direction = -1
//            getStartDatePosition()
//            currentMonth = MonthsInYear[month]
//            monthLabel.text = "\(day)\(currentMonth) \(year)"
//            collectionView.reloadData()
//        default:
//            month -= 1
//            direction = -1
//            getStartDatePosition()
//            currentMonth = MonthsInYear[month]
//            monthLabel.text = "\(day)\(currentMonth) \(year)"
//            collectionView.reloadData()
//        }
