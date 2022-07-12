//
//  CEEventsOrganizerCollectionCell.swift
//  CalenderTask
//
//  Created by Tringapps on 03/07/22.
//

import UIKit

class CEEventsOrganizerCollectionCell: UICollectionViewCell {
    

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var startTimeLabel: UILabel!
    
    @IBOutlet weak var endTimeLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var eventColorView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configDataForOrganizerCell(data: CalendarEvent) {
        
        dateLabel.text = data.date
        startTimeLabel.text = data.startTime
        endTimeLabel.text = data.endTime
        titleLabel.text = data.title
        eventColorView.backgroundColor = UIColor(named: data.color!)
    }
}
