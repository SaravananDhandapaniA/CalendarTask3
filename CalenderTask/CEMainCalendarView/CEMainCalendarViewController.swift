//
//  CEMainCalendarViewController.swift
//  CalenderTask
//
//  Created by Tringapps on 24/06/22.
//

import UIKit

class CEMainCalendarViewController: UIViewController {
    
    @IBOutlet weak var presentDateView: CEPresentDateHeader!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var allDayEventView: UIView!
    @IBOutlet weak var ReusableTableView: CEReusableTableView!
    
    var selectedDate = Date()
    var selectedIndex : IndexPath = [0,14]
    var currentDate = Date()
    var viewModel = CEMainCalendarViewModel()
    var dateArray: [Date]
    {
        return viewModel.dates
    }
    
    var timeArray: [Date]
    {
        return viewModel.timeResult
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollectionView()
        prepareTableView()
        preparePresentDateView()
//        viewModel.currentTime()
    }
    
    func preparePresentDateView() {
        presentDateView.presentTitleView.topLabel.text = viewModel.presentDateConverter(date: viewModel.startDate)
        let tap = UITapGestureRecognizer(target: self, action: #selector(CEMainCalendarViewController.tapFunction))
        presentDateView.presentTitleView.topLabel.isUserInteractionEnabled = true
        presentDateView.presentTitleView.topLabel.addGestureRecognizer(tap)
        presentDateView.presentButtonView.leftButton.setImage(UIImage(named: "AddIcon"), for: .normal)
        presentDateView.presentButtonView.rightButton.setImage(UIImage(named: "EventIcon"), for: .normal)
    }
    
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        collectionView.selectItem(at:selectedIndex, animated: false, scrollPosition: .centeredHorizontally)
        }
    
    func registerTableCell() {
        self.ReusableTableView.tableView.register(UINib.init(nibName: "CEMainEventsTableViewCell", bundle: .main), forCellReuseIdentifier: "CEMainTableCell")
    }
    
    
    func prepareTableView() {
        ReusableTableView.tableView.dataSource = self
        ReusableTableView.tableView.delegate = self
        registerTableCell()
        ReusableTableView.tableView.rowHeight = 80
//        let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate)
        let _ = viewModel.timeArray(fromStart: viewModel.dateConverter(string: "2022-06-30 12:00 AM"), toEnd: viewModel.dateConverter(string: "2022-07-01 12:00 AM") , component: .minute, value: 30)
    }
    
    func prepareCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        let _ = viewModel.dateArray()
        collectionView.selectItem(at:selectedIndex, animated: false, scrollPosition: .centeredHorizontally)
    }


    @IBAction func filterButtonTapped(_ sender: Any) {
        let detail = CEReusableController()
        self.present(detail, animated: true, completion: nil)
    }
    
}


extension CEMainCalendarViewController : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dateArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CEMainCollectionCell", for: indexPath) as? CEMainCalendarCollectionViewCell else {return UICollectionViewCell()}
        cell.configData(viewModel.dayString(date: dateArray[indexPath.row]), viewModel.dayInWeek(dateArray[indexPath.row]))
        cell.setup(viewModel.startDate,dateArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CEMainCalendarCollectionViewCell else {return}
        selectedDate = dateArray[indexPath.row]
        cell.selectedCellView(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CEMainCalendarCollectionViewCell else {return}
        cell.deSelectedCellView(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == dateArray.count - 1) {
            viewModel.scrollDate = dateArray[indexPath.row]
            let _ = viewModel.scrollForward()
            collectionView.reloadData()
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in collectionView.visibleCells {
            let indexPath = collectionView.indexPath(for: cell)
            if (indexPath?.row == 0) {
                viewModel.scrollDate = dateArray[indexPath!.row]
                let _ = viewModel.scrollBackward()
                selectedIndex.item += 4
                collectionView.reloadData()
            }
        }
    }


    
}


extension CEMainCalendarViewController : UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = ReusableTableView.tableView.dequeueReusableCell(withIdentifier: "CEMainTableCell", for: indexPath) as? CEMainEventsTableViewCell  else {return UITableViewCell()}
        cell.timeLabel.text = viewModel.timeCalculateConverter(date: timeArray[indexPath.row])
        return cell
    }

}

