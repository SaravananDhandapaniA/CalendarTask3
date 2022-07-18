//
//  CEEventsOrganizerViewController.swift
//  CalenderTask
//
//  Created by Tringapps on 03/07/22.
//

import UIKit
import Foundation

//protocol CETaskDetailDelegate : NSObjectProtocol {
//   func didPassData(data:CalendarEvent)
//}

class CEEventsOrganizerViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var isListView = Bool()
    
    var viewModel = CEEventsOrganizerViewModel()
    
   static var selectedEvent: CalendarEvent?
//    weak var TaskDetailDelegate: CETaskDetailDelegate?
   
    
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ListEvent"), style: .plain, target: self, action: #selector(viewButtonClicked(sender:)))
    }
    
    @objc func viewButtonClicked(sender: UIBarButtonItem){
        print("press")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "GridEvent"), style: .plain, target: self, action: .none)
        if !isListView {
        self.collectionView.startInteractiveTransition(to: isListView ? self.gridCVLayout : self.listCVLayout, completion: nil)
        self.collectionView.finishInteractiveTransition()
        }
        isListView = true
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

extension CEEventsOrganizerViewController : UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout , PinterestLayoutDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.eventsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CEEventOrganizerCell", for: indexPath) as? CEEventsOrganizerCollectionCell else{return UICollectionViewCell()}
        cell.configDataForOrganizerCell(data: viewModel.eventArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let item = collectionView.cellForItem(at: indexPath) as? CEEventsOrganizerCollectionCell else {return}
        
        
        if !isListView {
            let storyBoard = UIStoryboard(name: "CETaskDetailViewController", bundle: nil)
            guard let vc = storyBoard.instantiateViewController(withIdentifier: "CETaskDetailViewController") as? CETaskDetailViewController else{return}
            //            print(viewModel.eventArray[indexPath.row])
            //            vc.configDataForTaskDetail(data: viewModel.eventArray[indexPath.row])
            CEEventsOrganizerViewController.selectedEvent = viewModel.eventArray[indexPath.row]
            self.present(vc, animated: true, completion: nil)
        } else {
            UIView.animate(withDuration: 0.5) {
                self.view.bringSubviewToFront(collectionView)
                collectionView.bringSubviewToFront(item)
                item.frame.size.width = self.view.frame.width
                item.frame.size.height = 100
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let item = collectionView.cellForItem(at: indexPath) as? CEEventsOrganizerCollectionCell else {return}
        
        if isListView {
            UIView.animate(withDuration: 0.5) {
                self.view.bringSubviewToFront(collectionView)
                collectionView.bringSubviewToFront(item)
                item.frame.size.width = self.view.frame.width
                item.frame.size.height = 80
            }
        }
       
    }
        
        
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10 )) / 2
//        return CGSize(width: itemSize, height: itemSize)
//    }
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return CGFloat(viewModel.height[indexPath.row])
    }
}
