//
//  CEOnBoardSummary.swift
//  CalenderTask
//
//  Created by Tringapps on 23/06/22.
//

import UIKit

 class CEOnBoardSummary: UIView {

    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var titileSummaryView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    
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
        let nib = UINib(nibName: "CEOnBoardSummary", bundle: bundle)
        guard let view = nib.instantiate(withOwner: self , options: nil).first as? UIView else{return UIView()}
        return view
    }

}
