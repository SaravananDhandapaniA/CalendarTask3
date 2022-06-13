//
//  CalenderViewController.swift
//  CalenderTask
//
//  Created by Tringapps on 09/06/22.
//

import UIKit


class CalenderViewController: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    
    var viewModel = CalendarViewModel()
    var selectedDate = Date()
    var totalSquares = [String]()
    var totalMonths = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        setCellsView()
        setMonthView()
        
    }
    
    func setCellsView() {
        let width = (collectionView.frame.size.width - 2) / 8
        let height = (collectionView.frame.size.height - 2) / 8
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    func setMonthView() {
        totalSquares.removeAll()
        
        let daysInMonth = viewModel.daysInMonth(date: selectedDate)
        let firstDayOfMonth = viewModel.firstOfMonth(date: selectedDate)
        let startingSpace = viewModel.weekDay(date: firstDayOfMonth)
        
        var count = 1
        
        while(count <= 42) {
            
            if (count <= startingSpace || count - startingSpace > daysInMonth )
            {
                totalSquares.append("")
            } else {
                totalSquares.append(String(count - startingSpace))
            }
            count += 1
        }
        
        monthLabel.text =  viewModel.dayString(date: selectedDate) + " " + viewModel.monthString(date: selectedDate) + " " + viewModel.yearString(date: selectedDate)
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as? CalendarCell else {return UICollectionViewCell()}
        cell.dayOfMonth.text = totalSquares[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = totalSquares[indexPath.item]
        print(selectedCell)
    }
    
    
}
