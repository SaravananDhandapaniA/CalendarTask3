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
    
    func configData() {
        dateLabel.text = "1"
        dayLabel.text = "MON"
    }
    
}
