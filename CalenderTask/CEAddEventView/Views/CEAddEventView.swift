//
//  CEAddEventView.swift
//  CalenderTask
//
//  Created by Tringapps on 02/07/22.
//

import UIKit

class CEAddEventView: UIView {
    
    
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var titleTextField: UITextField!
        
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var repeatModeTextField: UITextField!
    
    @IBOutlet weak var resuableCollectionView: CEReusableCollectionView!
    
    
    var view : UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        view = loadViewFromNib()
        view.frame = self.bounds
        addSubview(view)
    }
    
    func loadViewFromNib() ->UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CEAddEventView", bundle: bundle)
        guard let view = nib.instantiate(withOwner: self , options: nil).first as? UIView else{return UIView()}
        return view
    }

}
