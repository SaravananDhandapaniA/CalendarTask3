//
//  ExampleViewController.swift
//  CalenderTask
//
//  Created by Tringapps on 14/06/22.
//

import UIKit

class ExampleViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var month: UILabel!
    
    @IBOutlet weak var calendarView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModewl = CalendarViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 300
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExampleTableViewCell", for: indexPath) as? ExampleTableViewCell else {return UITableViewCell()}
        return cell
    }
    
}
