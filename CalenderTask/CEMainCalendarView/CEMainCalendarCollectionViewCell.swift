//
//  CEMainCalendarCollectionViewCell.swift
//  CalenderTask
//
//  Created by Tringapps on 24/06/22.
//

import UIKit

class CEMainCalendarCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var dayLabel: UILabel!
    
    func configData(_ date: String  , _ day: String ) {
        dateLabel.text = date
        dayLabel.text = day
    }
    
    func setup(_ presentDate: Date , _ presentIndex: Date) {
        if presentDate == presentIndex  {
            self.backgroundColor = .red
            dateLabel.textColor = .white
            dayLabel.textColor = .white
        } else {
            self.backgroundColor = .white
            dateLabel.textColor = .black
            dayLabel.textColor = .black
        }
        self.oval()
    }
    
    func selectedCellView(_ indexPath: IndexPath) {
        self.backgroundColor = .gray
        dateLabel.textColor = .white
        dayLabel.textColor = .white
    }
    
    func deSelectedCellView(_ indexPath: IndexPath) {
        if indexPath == [0,14] {
            self.backgroundColor = .red
            dateLabel.textColor = .white
            dayLabel.textColor = .white
        } else {
            self.backgroundColor = .clear
            dateLabel.textColor = .black
            dayLabel.textColor = .black
        }
    }
    
}
