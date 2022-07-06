//
//  CECustomButtons.swift
//  CalenderTask
//
//  Created by Tringapps on 28/06/22.
//

import UIKit

protocol StoreButtonDelegate: NSObject {
    func didLeftsButtonPress(sender:UIViewController)
    func didRightButtonPress(sender:UIViewController)
}


class CECustomButtons: UIView  {
    

    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    var view : UIView!
    
    weak var buttonDelegate :StoreButtonDelegate?
    
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
        let nib = UINib(nibName: "CECustomButtons", bundle: bundle)
        guard let view = nib.instantiate(withOwner: self , options: nil).first as? UIView else{return UIView()}
        return view
    }

    @IBAction func leftButtonTapped(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "AddEventViewController", bundle: nil)
        let addScreen = storyBoard.instantiateViewController(withIdentifier: "AddEventViewController")
        buttonDelegate?.didLeftsButtonPress(sender: addScreen)

    }
    
    @IBAction func rightButtonTapped(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "CEEventsOrganizerViewController", bundle: nil)
        let eventOrganizerScreen = storyBoard.instantiateViewController(withIdentifier: "CEEventsOrganizerViewController")
        buttonDelegate?.didRightButtonPress(sender: eventOrganizerScreen)
    }
    
}
