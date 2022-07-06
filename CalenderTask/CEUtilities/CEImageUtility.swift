//
//  CEImageUtility.swift
//  CalenderTask
//
//  Created by Tringapps on 24/06/22.
//

import Foundation
import UIKit


extension UIButton {
    
    func circleButton() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.width / 2
      //  self.layer.cornerRadius = self.frame.height / 2
    }
    
}

extension UICollectionViewCell {
    
    func oval() {
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
    }
    
    func circle() {
        self.layer.masksToBounds = true
//        self.layer.cornerRadius = self.frame.width / 2
        self.layer.cornerRadius = 15
    }
}

extension UIView {
    
    func Viewoval() {
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
    }
}

extension Date {
    func timeStringWith(strFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = Calendar.current.timeZone
        dateFormatter.locale = Calendar.current.locale
        dateFormatter.dateFormat = strFormat
        return dateFormatter.string(from: self)
    }
}
