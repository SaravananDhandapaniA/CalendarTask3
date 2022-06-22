//
//  CalenderViewController.swift
//  CalenderTask
//
//  Created by Tringapps on 09/06/22.
//

import UIKit


class CalenderViewController: UIViewController, UITableViewDelegate,
                              UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource , addEventDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var eventTableView: UITableView!
    @IBOutlet weak var dividerView: UIView!
    var viewModel = CalendarViewModel()
    var totalSquares = [String]()
    var currentDate = Date()
    var result: EventData?
    
    var selectedIndex = Int()
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
       // setCellsView()
        setMonthView()
    }
                                    
    @IBAction func nextMonth(_ sender: Any ) {
        guard let next = viewModel.plusMonth(date: currentDate) else {return}
        let firstOfMonth = viewModel.firstOfMonth(date: next)
        let nextString = viewModel.monthString(date: next)
        let curr = viewModel.monthString(date: Date())
        if nextString == curr {
            currentDate = Date()
            setMonthView()
        } else {
            currentDate = firstOfMonth
            print("current date after clicking next:\(currentDate)")
            setMonthView()
        }
        eventTableView.reloadData()
    }
    @IBAction func prevMonth(_ sender: Any) {
        guard let prev = viewModel.minusMonth(date: currentDate) else {return}
        let firstOfMonth = viewModel.firstOfMonth(date: prev)
        let prevString = viewModel.monthString(date: prev)
        let curr = viewModel.monthString(date: Date())
        if prevString == curr {
            currentDate = Date()
            setMonthView()
        } else {
            currentDate = firstOfMonth
            setMonthView()
        }
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
        cell.layer.cornerRadius = cell.frame.width / 2
        if cell.isHidden {
            cell.isHidden = false
        }

        let currDate = viewModel.dayString(date: Date())
        let selectedDate = viewModel.dayString(date: currentDate)
        if currDate == totalSquares[indexPath.row] && currDate == selectedDate{
            cell.backgroundColor = .red
            cell.dayOfMonth.textColor = .white
        } else if selectedDate != currDate && selectedDate == totalSquares[indexPath.row] {
            cell.backgroundColor = .black
            cell.dayOfMonth.textColor = .white
        } else {
             cell.backgroundColor = .clear
            cell.dayOfMonth.textColor = .black
        }
        
        if (cell.dayOfMonth.text) == "" {
            cell.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CalendarCell else {return}
        cell.dayOfMonth.textColor = .white
        cell.backgroundColor = .black
        let selectedDate = "\(viewModel.yearString(date: currentDate) + "-" + viewModel.monthString(date: currentDate) + "-" + totalSquares[indexPath.row])"
        currentDate = viewModel.dateConverter(string: selectedDate)
        monthLabel.text =  viewModel.dayString(date: currentDate) + " " + viewModel.monthString(date: currentDate) + " " + viewModel.yearString(date: currentDate)
        collectionView.reloadData()
        eventTableView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CalendarCell else {return}
        cell.backgroundColor = .clear
        cell.dayOfMonth.textColor = .black
    }
    // TableView Delegate and DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let filteredArray = eventMapping()
        return filteredArray.isEmpty ? 1 : filteredArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let items = eventMapping()
        if items.isEmpty {
            guard let cell = eventTableView.dequeueReusableCell(withIdentifier: "EmptyEventDisplayCell", for: indexPath) as? EmptyEventDisplayCell else {return UITableViewCell()}
            return cell
        }
        guard let cell = eventTableView.dequeueReusableCell(withIdentifier: "EventDisplayCell", for: indexPath) as? EventDisplayCell else {return UITableViewCell()}
        cell.eventTitle.text = items[indexPath.row].title
        cell.eventStart.text = items[indexPath.row].startTime
        cell.eventEnd.text = items[indexPath.row].endTime
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = CGFloat()
        let items = eventMapping()
        if items.isEmpty {
            height = 350
        } else {
            height = 60
        }
        return height
    }
    
    @IBAction func addEventButtonTapped(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "EventViewController") as? EventViewController else {return}
            vc.delegate = self
            self.present(vc, animated: true, completion: nil)
    }

    
    func eventMapping() -> [EventDataModel] {
        guard let event = result?.eventDataArray else {return []}
        let date = viewModel.dateString(date: currentDate)
        let eventFilter = event.filter{$0.date == date}
        return eventFilter
    }
    
    func didAddEvent(_ events: EventDataModel) {
        result?.eventDataArray.append(events)
        eventTableView.reloadData()
    }

}
