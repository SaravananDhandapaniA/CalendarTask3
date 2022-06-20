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
    @IBOutlet weak var dividerView: UIView!
    var viewModel = CalendarViewModel()
    var totalSquares = [String]()
    var currentDate = Date()
    var result: EventData?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareForCollectionView()
        prepareForTableView()
        parseJson()
    }
    func prepareForTableView() {
        eventTableView.dataSource = self
        eventTableView.delegate = self
    }
    func prepareForCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        setCellsView()
        setMonthView()
    }
                                    
    @IBAction func nextMonth(_ sender: Any ) {
       currentDate = viewModel.plusMonth(date: currentDate)
        setMonthView()
        eventTableView.reloadData()

    }
    @IBAction func prevMonth(_ sender: Any) {
        currentDate = viewModel.minusMonth(date: currentDate)
        setMonthView()
        eventTableView.reloadData()
    }
    
    func parseJson() {
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {return}
        let url = URL(fileURLWithPath: path)
        do {
            let jsonData = try Data(contentsOf: url)
            result = try JSONDecoder().decode(EventData.self, from: jsonData)
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
        let daysInMonth = viewModel.daysInMonth(date: currentDate)
        let firstDayOfMonth = viewModel.firstOfMonth(date: currentDate)
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
        monthLabel.text =  viewModel.dayString(date: currentDate) + " " + viewModel.monthString(date: currentDate) + " " + viewModel.yearString(date: currentDate)
        collectionView.reloadData()
    }
    // Collection view Delegate and Data Source Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalSquares.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as? CalendarCell else {return UICollectionViewCell()}
        cell.dayOfMonth.text = totalSquares[indexPath.row]
        cell.backgroundColor = .clear
        cell.dayOfMonth.textColor = .black
        let defaultDate = viewModel.dayString(date: currentDate)
        if defaultDate == totalSquares[indexPath.row] {
            cell.backgroundColor = .red
            cell.dayOfMonth.textColor = .white
        }
        cell.layer.cornerRadius = cell.frame.width / 2
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CalendarCell else {return}
        cell.backgroundColor = .black
        cell.dayOfMonth.textColor = .white
        let selectedDate = "\(viewModel.yearString(date: currentDate) + "-" + viewModel.monthString(date: currentDate) + "-" + totalSquares[indexPath.row ])"
        currentDate = viewModel.dateConverter(string: selectedDate)
        setMonthView()
        eventTableView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CalendarCell else {return}
        cell.backgroundColor = .clear
        cell.dayOfMonth.textColor = .black
    }
    // TableView Delegate and DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result?.eventDataArray.count  ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if result?.eventDataArray[indexPath.row].date == viewModel.dateString(date: currentDate) {
            guard let cell = eventTableView.dequeueReusableCell(withIdentifier: "EventDisplayCell", for: indexPath) as? EventDisplayCell else {return UITableViewCell()}
            cell.eventTitle.text = result?.eventDataArray[indexPath.row].title
            cell.eventStart.text = result?.eventDataArray[indexPath.row].startTime
            cell.eventEnd.text = result?.eventDataArray[indexPath.row].endTime
            return cell
        } else {
            guard let cell = eventTableView.dequeueReusableCell(withIdentifier: "EmptyEventDisplayCell", for: indexPath) as? EmptyEventDisplayCell else {return UITableViewCell()}
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = CGFloat()
        if result?.eventDataArray[indexPath.row].date == viewModel.dateString(date: currentDate) {
            height = 60
        } else {
            height = 60
        }
        return height
    }

}
