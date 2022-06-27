//
//  CEMainCalendarViewController.swift
//  CalenderTask
//
//  Created by Tringapps on 24/06/22.
//

import UIKit

class CEMainCalendarViewController: UIViewController {
    
    @IBOutlet weak var addEventButton: UIButton!
    @IBOutlet weak var eventOrganizerButton: UIButton!
    @IBOutlet weak var presentDateLabel: UILabel!
    @IBOutlet weak var presentTaskCountLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    
    var viewModel = CEMainCalendarViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollectionView()
        prepareTableView()
    }
    
    func registerTableCell() {
        self.tableView.register(UINib.init(nibName: "CEMainEventsTableViewCell", bundle: .main), forCellReuseIdentifier: "CEMainTableCell")
    }
    
    
    func prepareTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        registerTableCell()
        tableView.rowHeight = 80
    }
    
    func prepareCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    
    
    @IBAction func addEventTapped(_ sender: Any) {
    }
    
    @IBAction func eventOrganizerTapped(_ sender: Any) {
    }

    @IBAction func filterButtonTapped(_ sender: Any) {
    }
    
}


extension CEMainCalendarViewController : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.daysInMonth
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CEMainCollectionCell", for: indexPath) as? CEMainCalendarCollectionViewCell else {return UICollectionViewCell()}
        cell.oval()
        return cell
    }
    
}


extension CEMainCalendarViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CEMainTableCell", for: indexPath) as? CEMainEventsTableViewCell  else {return UITableViewCell()}
        return cell
    }
    
    
}
