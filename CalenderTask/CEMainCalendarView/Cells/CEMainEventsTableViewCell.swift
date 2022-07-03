//
//  CEMainEventsTableViewCell.swift
//  CalenderTask
//
//  Created by Tringapps on 27/06/22.
//

import UIKit

class CEMainEventsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var eventView: UIView!
    
    @IBOutlet weak var currentTimeView: UIView!
    
    @IBOutlet weak var eventTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        eventView.Viewoval()
    }
    
}
