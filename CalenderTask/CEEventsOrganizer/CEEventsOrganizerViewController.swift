//
//  CEEventsOrganizerViewController.swift
//  CalenderTask
//
//  Created by Tringapps on 03/07/22.
//

import UIKit

class CEEventsOrganizerViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    var height = [300,200,200,300,300,200,200,300,300,200]
    var isListView = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareCollectionViewForEventOrganizer()
    }
    
    func prepareCollectionViewForEventOrganizer() {
        self.collectionView.register(UINib.init(nibName: "CEEventsOrganizerCollectionCell", bundle: .main), forCellWithReuseIdentifier: "CEEventOrganizerCell")
        collectionView.dataSource = self
        collectionView.delegate = self
//        collectionView?.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
        if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
          layout.delegate = self
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "GridEvent"), style: .plain, target: self, action: #selector(viewButtonClicked(sender:)))
    }
    
    @objc func viewButtonClicked(sender: UIBarButtonItem){
        print("press")
        self.collectionView.startInteractiveTransition(to: isListView ? self.listCVLayout : self.gridCVLayout, completion: nil)
          self.collectionView.finishInteractiveTransition()
    }


    
    private lazy var listCVLayout: UICollectionViewFlowLayout = {

        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        collectionFlowLayout.itemSize = CGSize(width: collectionView.frame.width, height: 80)
        collectionFlowLayout.minimumInteritemSpacing = 10
        collectionFlowLayout.minimumLineSpacing = 10
        collectionFlowLayout.scrollDirection = .vertical
        return collectionFlowLayout
    }()

    private lazy var gridCVLayout: UICollectionViewFlowLayout = {
        
        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.scrollDirection = .vertical
        collectionFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        collectionFlowLayout.itemSize = CGSize(width: (collectionView.frame.width) / 2 , height: collectionView.frame.height)
        collectionFlowLayout.minimumInteritemSpacing = 20
        collectionFlowLayout.minimumLineSpacing = 20
        return collectionFlowLayout
    }()
 
}

extension CEEventsOrganizerViewController : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , PinterestLayoutDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CEEventOrganizerCell", for: indexPath) as? CEEventsOrganizerCollectionCell else{return UICollectionViewCell()}
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10 )) / 2
//        return CGSize(width: itemSize, height: itemSize)
//    }
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return CGFloat(height[indexPath.row])
    }
}
