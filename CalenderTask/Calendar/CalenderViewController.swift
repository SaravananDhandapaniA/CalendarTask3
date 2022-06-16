//
//  CalenderViewController.swift
//  CalenderTask
//
//  Created by Tringapps on 09/06/22.
//

import UIKit

class CalenderViewController: UIViewController, UITableViewDelegate,
                                UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var eventTableView: UITableView!

    var viewModel = CalendarViewModel()
    var selectedDate = Date()
    var totalSquares = [String]()
    var result: EventData?
    var addedData = [EventDataModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        setCellsView()
        setMonthView()
        eventTableView.dataSource = self
        eventTableView.delegate = self
        eventTableView.rowHeight = 60
        parseJson()
//        array.append(EventDataModel(title: "Sara", Date: "11", startTime: "1:00 PM" , endTime: "2:00 PM"))
//        writeJson(items: array)
    }
//    var array: [EventDataModel] = {
//        do {
//  let fileURL = try FileManager.default.url(
 //   for: .desktopDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
//                .appendingPathComponent("data.json")
//
//            let data = try Data(contentsOf: fileURL)
//            let decoder = JSONDecoder()
//            let items = try decoder.decode([EventDataModel].self, from: data)
//            return items
//        } catch {
//            print(error.localizedDescription)
//            return []
//        }
//    }()
//
//    func writeJson(items: [EventDataModel]){
//
//        do {
// let fileURL = try FileManager.default.url(
// for: .desktopDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("data.json")
//            let encoder = JSONEncoder()
//            try encoder.encode(array).write(to: fileURL)
//
//        } catch {
//            print(error.localizedDescription)
//        }
//
//    }
    func parseJson() {
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {return}
        let url = URL(fileURLWithPath: path)
        do {
            let jsonData = try Data(contentsOf: url)
            result = try JSONDecoder().decode(EventData.self, from: jsonData)
            print(result!)
        } catch {
            print("Error:\(error)")
        }
    }
    func setCellsView() {
        let width = (collectionView.frame.size.width - 2) / 8
        let height = (collectionView.frame.size.height - 2) / 8
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {return}
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    func setMonthView() {
        totalSquares.removeAll()
        let daysInMonth = viewModel.daysInMonth(date: selectedDate)
        let firstDayOfMonth = viewModel.firstOfMonth(date: selectedDate)
        let startingSpace = viewModel.weekDay(date: firstDayOfMonth)
        var count = 1
        while count <= 42 {
            if count <= startingSpace || count - startingSpace > daysInMonth {
                totalSquares.append("")
            } else {
                totalSquares.append(String(count - startingSpace))
            }
            count += 1
        }
        monthLabel.text =  viewModel.dayString(date: selectedDate) + " " +
        viewModel.monthString(date: selectedDate) + " " + viewModel.yearString(date: selectedDate)
       collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalSquares.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as? CalendarCell else {return UICollectionViewCell()}
        cell.dayOfMonth.text = totalSquares[indexPath.row]
        cell.layer.cornerRadius = cell.frame.width / 2
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CalendarCell else {return}
        cell.backgroundColor = .black
        cell.dayOfMonth.textColor = .white
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CalendarCell else {return}
        cell.backgroundColor = .clear
        cell.dayOfMonth.textColor = .black
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (result?.eventDataArray.count)!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = eventTableView.dequeueReusableCell(withIdentifier: "EventDisplayCell", for: indexPath) as? EventDisplayCell else {return UITableViewCell()}
        cell.eventTitle.text = result?.eventDataArray[indexPath.row].title
        cell.eventStart.text = result?.eventDataArray[indexPath.row].startTime
        cell.eventEnd.text = result?.eventDataArray[indexPath.row].endTime
        return cell
    }
    @IBAction func nextMonth(_ sender: Any ) {
       selectedDate = viewModel.plusMonth(date: selectedDate)
       setMonthView()
    }
    @IBAction func prevMonth(_ sender: Any) {
        selectedDate = viewModel.minusMonth(date: selectedDate)
        setMonthView()
    }
}
