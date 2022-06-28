//
//  CEMainCalendarViewController.swift
//  CalenderTask
//
//  Created by Tringapps on 24/06/22.
//

import UIKit

class CEMainCalendarViewController: UIViewController {
    
//    @IBOutlet weak var addEventButton: UIButton!
//    @IBOutlet weak var eventOrganizerButton: UIButton!
//    @IBOutlet weak var presentDateLabel: UILabel!
//    @IBOutlet weak var presentTaskCountLabel: UILabel!
    
    @IBOutlet weak var presentDateView: CEPresentDateHeader!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var allDayEventView: UIView!
    
    var currentDate = Date()
    var selectedDate = 28
    var viewModel = CEMainCalendarViewModel()
    var dateArray: NSArray
    {
        return viewModel.arrayOfDates()
    }
    var dayArray : NSArray {
        return viewModel.arrayOfDays()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollectionView()
        prepareTableView()
        buttonImageLoad()
    }
    
    func buttonImageLoad() {
        presentDateView.presentButtonView.leftButton.setImage(UIImage(named: "PlusIcon"), for: .normal)
        presentDateView.presentButtonView.rightButton.setImage(UIImage(named: "EventsIcon"), for: .normal)
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
        let detail = CEReusableController()
        self.present(detail, animated: true, completion: nil)
    }
    
    @IBAction func eventOrganizerTapped(_ sender: Any) {
        
    }

    @IBAction func filterButtonTapped(_ sender: Any) {
//        let storyBoard = UIStoryboard(name: "CEReusableViewController", bundle: nil)
//        guard let vc = storyBoard.instantiateViewController(withIdentifier: "CEReusableViewController") as? CEReusableViewController else {return}
//        self.present(vc, animated: true, completion: nil)
        let detail = CEReusableController()
        self.present(detail, animated: true, completion: nil)
    }
    
}


extension CEMainCalendarViewController : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CEMainCollectionCell", for: indexPath) as? CEMainCalendarCollectionViewCell else {return UICollectionViewCell()}
        cell.dateLabel.text = self.dateArray[indexPath.row] as? String
        cell.dayLabel.text = self.dayArray[indexPath.row] as? String
        cell.oval()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let centeredIndexPath = IndexPath.init(item: selectedDate, section: 0)
        collectionView.scrollToItem(at: centeredIndexPath, at: .centeredHorizontally, animated: true)
        if indexPath == centeredIndexPath {
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if collectionView == scrollView {
            setSelectedItemFromScrollView(scrollView)
        }
    }
    
    func setSelectedItemFromScrollView(_ scrollView: UIScrollView) {
        if collectionView == scrollView {
            let center = CGPoint(x: scrollView.center.x + scrollView.contentOffset.x, y: scrollView.center.y + scrollView.contentOffset.y)
            let index = collectionView.indexPathForItem(at: center)
            if index != nil {
                collectionView.scrollToItem(at: index!, at: .centeredHorizontally, animated: true)
                self.collectionView.selectItem(at: index, animated: false, scrollPosition: [])
                self.collectionView(self.collectionView, didSelectItemAt: index!)
                
                self.selectedDate = (index?.row)!
//                self.selectedDateLabel.text = self.calendarArray?[(index?.row)!] as! String?
            }
            else {
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if collectionView == scrollView && !decelerate  {
                    setSelectedItemFromScrollView(scrollView)
                }
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
