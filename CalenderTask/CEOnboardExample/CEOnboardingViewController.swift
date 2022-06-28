//
//  CEOnboardingViewController.swift
//  CalenderTask
//
//  Created by Tringapps on 23/06/22.
//

import UIKit

class CEOnboardingViewController: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
   
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        regitserCellXib()
        setupCollectionView()
//        viewModel.configData()
        collectionView.reloadData()
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
    }
    
    func regitserCellXib(){
        self.collectionView.register(UINib.init(nibName: "CEOnboardingCalendarCell", bundle: .main), forCellWithReuseIdentifier: "CEOnboardCalendar")
        self.collectionView.register(UINib.init(nibName: "CEOnboardingEventsCell", bundle: .main), forCellWithReuseIdentifier: "CEOnboardEvent")
        self.collectionView.register(UINib.init(nibName: "CEOnboardingFilterCell", bundle: .main), forCellWithReuseIdentifier: "CEOnboardFilter")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
          guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CEOnboardCalendar" , for: indexPath) as? CEOnboardingCalendarCell else {return UICollectionViewCell()}
            return cell
        } else  if  indexPath.row == 3 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CEOnboardFilter", for: indexPath) as? CEOnboardingFilterCell else {return UICollectionViewCell()}
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CEOnboardEvent", for: indexPath) as? CEOnboardingEventsCell else {return UICollectionViewCell()}
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = collectionView.bounds.height
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}
