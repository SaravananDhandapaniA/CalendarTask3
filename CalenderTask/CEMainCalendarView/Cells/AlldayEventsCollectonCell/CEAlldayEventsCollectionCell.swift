//
//  AlldayEventsCollectionCell.swift
//  CalenderTask
//
//  Created by Tringapps on 04/07/22.
//

import UIKit

class CEAlldayEventsCollectionCell: UICollectionViewCell {
    
    

    @IBOutlet weak var allDayEventTitle: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ovalForAllDayevent()
    }

    func configDataForAlldayevents(data : CalendarEvent) {
        allDayEventTitle.text = data.title
        self.backgroundColor = UIColor(named: data.color!)
    }
}
