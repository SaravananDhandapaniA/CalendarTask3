//
//  CECheckBox.swift
//  CalenderTask
//
//  Created by Tringapps on 11/07/22.
//

import UIKit

protocol CECheckBoxDelegate : NSObjectProtocol {
    func didSelectCheckBox(value:Bool)
}

class CECheckBox: UIButton {
    
    let checkedImage = UIImage(named: "checked")
    let unCheckedImage = UIImage(named: "unChecked")
    
    weak var checkBoxDelegate: CECheckBoxDelegate?
    
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: .normal)
                checkBoxDelegate?.didSelectCheckBox(value: true)
            } else {
                self.setImage(unCheckedImage, for: .normal)
                checkBoxDelegate?.didSelectCheckBox(value: false)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: #selector(buttonClicked), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }
    
    @objc func buttonClicked(sender:UIButton) {
        if(sender == self){
            if isChecked == true {
                isChecked = false
            } else {
                isChecked = true
            }
        }
    }
    
}
