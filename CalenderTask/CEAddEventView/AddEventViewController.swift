//
//  AddEventViewController.swift
//  CalenderTask
//
//  Created by Tringapps on 01/07/22.
//

import UIKit

class AddEventViewController: UIViewController , UISheetPresentationControllerDelegate {
    
    @IBOutlet weak var addEventView: CEAddEventView!
    
    var backgroundColorArray:[UIColor] = [.red,.brown,.blue,.darkGray,.green]
    
    override var sheetPresentationController: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       
        prepareSheet()
        prepareCollectionViewForAddEvents()
    }

    func prepareCollectionViewForAddEvents(){
        self.addEventView.resuableCollectionView.collectionView.register(UINib.init(nibName: "CEAddEventCollectionCell", bundle: .main), forCellWithReuseIdentifier: "CEAddEventCell")
        addEventView.resuableCollectionView.collectionView.delegate = self
        addEventView.resuableCollectionView.collectionView.dataSource = self
        if let layout = addEventView.resuableCollectionView.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
    
    func prepareSheet() {
        sheetPresentationController.delegate = self
        sheetPresentationController.selectedDetentIdentifier = .medium
        sheetPresentationController.prefersGrabberVisible = true
        sheetPresentationController.detents = [.medium()]
    }
}

extension AddEventViewController: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = addEventView.resuableCollectionView.collectionView.dequeueReusableCell(withReuseIdentifier: "CEAddEventCell", for: indexPath) as? CEAddEventCollectionCell else {return UICollectionViewCell()}
        cell.backgroundColor = backgroundColorArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    
}
