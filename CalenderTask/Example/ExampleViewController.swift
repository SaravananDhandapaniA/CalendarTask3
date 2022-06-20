//
//  ExampleViewController.swift
//  CalenderTask
//
//  Created by Tringapps on 14/06/22.
//

import UIKit

class ExampleViewController: UIViewController, UITableViewDataSource , UITableViewDelegate {
   
    @IBOutlet weak var monthTableView: UITableView!
    
    @IBOutlet weak var month: UILabel!
    var viewModel = CalendarViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        monthTableView.delegate = self
        monthTableView.dataSource = self
        monthTableView.rowHeight = 300
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExampleTableViewCell", for: indexPath) as? ExampleTableViewCell else {return UITableViewCell()}
        return cell
    }
    
}
