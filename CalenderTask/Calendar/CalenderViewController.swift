//
//  CalenderViewController.swift
//  CalenderTask
//
//  Created by Tringapps on 09/06/22.
//

import UIKit


class CalenderViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var monthLabel: UILabel!
    
    var date = CalendarTableCell()
    var viewModel = CalendarViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 300
        monthLabel.text =  viewModel.dayString(date: date.selectedDate) + " " + viewModel.monthString(date: date.selectedDate) + " " + viewModel.yearString(date: date.selectedDate)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.monthsInYear(date: date.selectedDate)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarTableCell", for: indexPath) as? CalendarTableCell else {return UITableViewCell()}
        cell.setMonthView(indexPath)
        return cell
    }
}
