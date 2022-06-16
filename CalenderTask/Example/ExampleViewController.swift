//
//  ExampleViewController.swift
//  CalenderTask
//
//  Created by Tringapps on 14/06/22.
//

import UIKit

class ExampleViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var calendarView: UIView!
    @IBOutlet weak var monthCollectionView: UICollectionView!
    var viewModel = CalendarViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        monthCollectionView.delegate = self
        monthCollectionView.dataSource = self
        setCellsView()
    }
    func setCellsView() {
        guard  let flowLayout = monthCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else {return}
            flowLayout.estimatedItemSize = CGSize(width: 414, height: 300)
        }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MonthCalendarCell", for: indexPath) as? MonthCalendarCell else {return UICollectionViewCell()}

        return cell
    }
}
