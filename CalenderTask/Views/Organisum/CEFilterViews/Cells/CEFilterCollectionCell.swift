//
//  CEFilterCollectionCell.swift
//  CalenderTask
//
//  Created by Tringapps on 11/07/22.
//

import UIKit

class CEFilterCollectionCell: UICollectionViewCell {
    
    
    @IBOutlet weak var filterTitle: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        oval()
    }
    
    func configDataForFilterCell(name: String , color: String) {
        
        filterTitle.text = name
        self.backgroundColor = UIColor(named: color)
        
    }
    
    func initialCellSetup(color: String) {
        self.backgroundColor = UIColor(named: color)
        filterTitle.textColor = .black
    }
    
    func selectedCellSetup() {
        self.backgroundColor = .blue
        filterTitle.textColor = .white
    }
    
    func selectAllCellSetup() {
        self.backgroundColor = .blue
        filterTitle.textColor = .white
    }

}
