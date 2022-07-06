//
//  CEMainCalendarViewController.swift
//  CalenderTask
//
//  Created by Tringapps on 24/06/22.
//

import UIKit
import CoreData

class CEMainCalendarViewController: UIViewController , StoreButtonDelegate {
   
    @IBOutlet weak var presentDateView: CEPresentDateHeader!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var ReusableTableView: CEReusableTableView!
    @IBOutlet weak var alldayCollectionView: CEReusableCollectionView!
    
    var selectedDate = Date()
    var selectedIndex : IndexPath = [0,14]
    var currentDate = Date()
    var viewModel = CEMainCalendarViewModel()
    var dateArray: [Date] { return viewModel.dates }
//    var timeArray: [Date] { return viewModel.timeResult }
    let persistance = CEPersistanceService.shared
    
  static var presentDateFilteredArray = [CalendarEvent]()
    
    var events = [CalendarEvent]()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerReusableCells()
        prepareCollectionView()
        prepareTableView()
        fetchDataFromCore()
        preparePresentDateView()
    }
    
    func preparePresentDateView() {
        presentDateView.presentTitleView.topLabel.text = viewModel.presentDateConverter(date: viewModel.startDate)
        let tap = UITapGestureRecognizer(target: self, action: #selector(CEMainCalendarViewController.tapFunction))
        presentDateView.presentTitleView.topLabel.isUserInteractionEnabled = true
        presentDateView.presentTitleView.topLabel.addGestureRecognizer(tap)
        presentDateView.presentButtonView.leftButton.setImage(UIImage(named: "AddIcon"), for: .normal)
        presentDateView.presentButtonView.rightButton.setImage(UIImage(named: "EventIcon"), for: .normal)
        presentDateView.presentButtonView.buttonDelegate = self
    }
    
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        collectionView.selectItem(at:selectedIndex, animated: false, scrollPosition: .centeredHorizontally)
        }
    
    func registerReusableCells() {
        self.ReusableTableView.tableView.register(UINib.init(nibName: "CEMainEventsTableViewCell", bundle: .main), forCellReuseIdentifier: "CEMainTableCell")
        self.alldayCollectionView.collectionView.register(UINib.init(nibName: "AlldayEventsCollectionCell", bundle: .main), forCellWithReuseIdentifier: "AllDayEventsCell")
    }
    
    
    func prepareTableView() {
        ReusableTableView.tableView.dataSource = self
        ReusableTableView.tableView.delegate = self
        ReusableTableView.tableView.rowHeight = 80
//        let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate)
        let _ = viewModel.timeArray(fromStart: viewModel.dateConverter(string: "2022-06-30 12:00 AM"), toEnd: viewModel.dateConverter(string: "2022-07-01 12:00 AM") , component: .minute, value: 30)
    }
    
    func prepareCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        alldayCollectionView.collectionView.dataSource = self
        alldayCollectionView.collectionView.delegate = self
        if let layout = alldayCollectionView.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.itemSize.width = 100
            layout.itemSize.height = 40
        }
        let _ = viewModel.dateArray()
        collectionView.selectItem(at:selectedIndex, animated: false, scrollPosition: .centeredHorizontally)
    }
    
    func fetchDataFromCore() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("PersistedDataUpdated"), object: nil, queue: .main) { (_) in

        }
        persistance.fetch(CalendarEvent.self) { [weak self](events) in
            self?.events = events
            print(events.count)
            self?.ReusableTableView.tableView.reloadData()
            if events == []{
                self?.getJsonDataAndStore()
            }
        }
        //        getJsonDataAndStore()
//                deleteAllDataInCore()
    }
    
    func getJsonDataAndStore() {

        let url = Bundle.main.url(forResource: "CEData", withExtension: "json")

        if let url = url {
            let data = try? Data(contentsOf: url)
            do{
                guard let data = data
                else{return}

                guard let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] else{return}
                let events: [CalendarEvent] = jsonArray.compactMap {

                        let date = $0["date"] as? String
                        let title = $0["title"] as? String
                        let color = $0["color"] as? String
                        let eventType = $0["eventType"] as? String
                        let startTime = $0["startTime"] as? String
                        let endTime = $0["endTime"] as? String
                        let location = $0["location"] as? String
                        let repeatMode = $0["repeatMode"] as? String

                    let calendarEvent = CalendarEvent(context: persistance.context)
                    calendarEvent.date = date
                    calendarEvent.title = title
                    calendarEvent.color = color
                    calendarEvent.eventType = eventType
                    calendarEvent.startTime = startTime
                    calendarEvent.endTime = endTime
                    calendarEvent.location = location
                    calendarEvent.repeatMode = repeatMode

                    return calendarEvent
                }
                self.events = events
                DispatchQueue.main.async {
                    self.persistance.save()
                }
            }
            catch{
                print(error)
            }
        }

    }
    
    func deleteAllDataInCore(){

        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "CalendarEvent")
        let deleteAllReq = NSBatchDeleteRequest(fetchRequest: fetchReq)

        do{
            try persistance.context.execute(deleteAllReq)
        }catch let error{
            print(error)
        }
    }

    
    func didLeftsButtonPress(sender: UIViewController) {
        self.present(sender, animated: true, completion: nil)
    }

    func didRightButtonPress(sender: UIViewController) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.pushViewController(sender, animated: true)
    }
    
    @IBAction func filterButtonTapped(_ sender: Any) {
        let filterScreen = CEReusableController()
        self.present(filterScreen, animated: true, completion: nil)
    }

    
    
}





extension CEMainCalendarViewController : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == alldayCollectionView.collectionView) {
            let filteredArray = filterForAlldayEvents()
            return filteredArray.isEmpty ? 0 : filteredArray.count
        }

        return dateArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (collectionView == alldayCollectionView.collectionView) {
            let filteredArray = filterForAlldayEvents()
            guard let cell = alldayCollectionView.collectionView.dequeueReusableCell(withReuseIdentifier: "AllDayEventsCell", for: indexPath) as? AlldayEventsCollectionCell else {return UICollectionViewCell()}
            cell.configDataForAlldayevents(data: filteredArray[indexPath.row])
            return cell
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CEMainCollectionCell", for: indexPath) as? CEMainCalendarCollectionViewCell else {return UICollectionViewCell()}
        cell.configData(viewModel.dayString(date: dateArray[indexPath.row]), viewModel.dayInWeek(dateArray[indexPath.row]))
        cell.setup(viewModel.startDate,dateArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CEMainCalendarCollectionViewCell else {return}
        selectedDate = dateArray[indexPath.row]
        cell.selectedCellView(indexPath)
        ReusableTableView.tableView.reloadData()
        alldayCollectionView.collectionView.reloadData()
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
        return viewModel.timeResult.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = ReusableTableView.tableView.dequeueReusableCell(withIdentifier: "CEMainTableCell", for: indexPath) as? CEMainEventsTableViewCell  else {return UITableViewCell()}
//        cell.timeLabel.text = viewModel.timeCalculateConverter(date:viewModel.timeResult[indexPath.row])
        cell.timeLabel.text = viewModel.convetTime(at: indexPath.row)
        let items = eventMappingForCurrentDate()
        CEMainCalendarViewController.presentDateFilteredArray = items
        presentDateView.presentTitleView.bottomLabel.text = "\(items.count) tasks today"
        
        let eventFilter = items.filter{$0.startTime == cell.timeLabel.text}

        if !eventFilter.isEmpty {
            cell.eventTitle.text = eventFilter.first?.title
            cell.eventView.backgroundColor = UIColor(named: eventFilter.first?.color ?? "Red")
        } else {
            cell.eventTitle.text = ""
            cell.eventView.backgroundColor = .clear
        }


        return cell
    }
    
    func eventMappingForCurrentDate() -> [CalendarEvent] {
        let event = events
        let date = viewModel.dateStringConverter(date: selectedDate)
        let eventFilter = event.filter{$0.date == date}
        return eventFilter
    }
    func filterForAlldayEvents() -> [CalendarEvent] {
        let items = eventMappingForCurrentDate()
        let eventType = "Allday"
        let filterEventType = items.filter{$0.eventType == eventType}
        return filterEventType
    }

}

