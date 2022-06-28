//
//  CEPresentDateHeader.swift
//  CalenderTask
//
//  Created by Tringapps on 28/06/22.
//

import UIKit

class CEPresentDateHeader: UIView {

    @IBOutlet weak var presentTitleView: CEPresentTitleSummary!
    @IBOutlet weak var presentButtonView: CECustomButtons!
    
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
        let nib = UINib(nibName: "CEPresentDateHeader", bundle: bundle)
        guard let view = nib.instantiate(withOwner: self , options: nil).first as? UIView else{return UIView()}
        return view
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
