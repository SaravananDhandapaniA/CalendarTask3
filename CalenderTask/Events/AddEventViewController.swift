//
//  AddEventViewController.swift
//  CalenderTask
//
//  Created by Tringapps on 13/06/22.
//

import UIKit

class AddEventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = EventViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewData = viewModel.cellForRowAt(indexPath: indexPath)
        if (indexPath.row == 0 && indexPath.section == 0) || (indexPath.row == 1 && indexPath.section == 0) {
            guard  let cell = tableView.dequeueReusableCell(withIdentifier: "EventInputCell", for: indexPath) as? EventInputCell else { return UITableViewCell()}
            cell.eventInputField.placeholder = viewData.list[indexPath.row]
            return cell
        }
        else {
            guard  let cell = tableView.dequeueReusableCell(withIdentifier: "EventTimeIntervalCell", for: indexPath) as? EventTimeIntervalCell else { return UITableViewCell()}
            cell.intervelLabel.text = viewData.list[indexPath.row]
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections(tableView: tableView)
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForHeaderInSection(section: section)
    }
    
}
