//
//  CEAddEventCollectionCell.swift
//  CalenderTask
//
//  Created by Tringapps on 02/07/22.
//

import UIKit

class CEAddEventCollectionCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        circle()
    }
    
    func setupCell(color: String ) {
        self.backgroundColor = UIColor(named: color)
    }

}
