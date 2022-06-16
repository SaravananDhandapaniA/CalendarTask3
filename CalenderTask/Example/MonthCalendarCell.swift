//
//  ExampleCalendarCell.swift
//  CalenderTask
//
//  Created by Tringapps on 14/06/22.
//

import UIKit

class MonthCalendarCell: UICollectionViewCell {
    @IBOutlet weak var dayCollectionView: UICollectionView!
    var viewModel = CalendarViewModel()
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    func setCellsView() {
        guard let flowLayout = dayCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else {return}
            flowLayout.estimatedItemSize = CGSize(width: 100, height: 100)
        }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DaysCalendarCell", for: indexPath) as? DaysCalendarCell else {return UICollectionViewCell()}
        return cell
    }
}
