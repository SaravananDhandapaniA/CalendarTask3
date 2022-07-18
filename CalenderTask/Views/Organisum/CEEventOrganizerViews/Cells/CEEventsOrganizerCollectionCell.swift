//
//  CEEventsOrganizerCollectionCell.swift
//  CalenderTask
//
//  Created by Tringapps on 03/07/22.
//

import UIKit

class CEEventsOrganizerCollectionCell: UICollectionViewCell {
    
    var viewModel = CEEventsOrganizerCellViewModel()
    
    

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var startTimeLabel: UILabel!
    
    @IBOutlet weak var endTimeLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var eventColorView: UIView!
    
    @IBOutlet weak var eventsTimeStackView: UIStackView!
    
    @IBOutlet weak var startTimeStackView: UIStackView!
    
    @IBOutlet weak var endTimeStackView: UIStackView!
    
    
    @IBOutlet weak var eventType: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configDataForOrganizerCell(data: CalendarEvent) {
        viewModel.data = data
        
        dateLabel.text = viewModel.date
        startTimeLabel.text = viewModel.startTime
        endTimeLabel.text = viewModel.endTime
        titleLabel.text = viewModel.title
        eventColorView.backgroundColor = UIColor(named: viewModel.color)
        eventType.text = viewModel.eventType
    }
}
