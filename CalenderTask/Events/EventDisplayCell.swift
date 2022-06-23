//
//  EventDisplayCell.swift
//  CalenderTask
//
//  Created by Tringapps on 15/06/22.
//

import UIKit

class EventDisplayCell: UITableViewCell {
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventStart: UILabel!
    @IBOutlet weak var eventEnd: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
