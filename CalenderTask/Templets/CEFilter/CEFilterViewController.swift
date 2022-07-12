//
//  CEFilterViewController.swift
//  CalenderTask
//
//  Created by Tringapps on 07/07/22.
//

import UIKit

class CEFilterViewController: UIViewController , UISheetPresentationControllerDelegate , CECheckBoxDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var selectAllCheckBox: CECheckBox!
    
    var selectionIndex = [-1]
    
    var isCheckboxState : Bool?
    
    var viewModel = CEFilterViewModel()

    override var sheetPresentationController: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareSheet()
        registerCellForfilter()
        selectAllCheckBox.checkBoxDelegate = self
    }

    func prepareSheet() {
        sheetPresentationController.delegate = self
        sheetPresentationController.selectedDetentIdentifier = .medium
        sheetPresentationController.prefersGrabberVisible = true
        sheetPresentationController.detents = [.medium()]
    }
    
    func registerCellForfilter() {
        collectionView.dataSource = self
        collectionView.delegate = self
        self.collectionView.register(UINib.init(nibName: "CEFilterCollectionCell", bundle: .main), forCellWithReuseIdentifier: "CEFilterCell")
    }
    
    func didSelectCheckBox(value: Bool) {
        isCheckboxState = value
        collectionView.reloadData()
    }
    
}

extension CEFilterViewController : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.filters.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CEFilterCell", for: indexPath) as? CEFilterCollectionCell else {return UICollectionViewCell()}
        cell.configDataForFilterCell(name: viewModel.filters[indexPath.row], color: viewModel.filterColorArray[indexPath.row])
        if selectionIndex.contains(indexPath.item) {
            cell.selectedCellSetup()
        } else {
            cell.initialCellSetup(color: viewModel.filterColorArray[indexPath.row])
        }
        
        if isCheckboxState == true {
            cell.selectAllCellSetup()
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectionIndex.contains(indexPath.item) {
            if let index = selectionIndex.firstIndex(of: indexPath.item) {
                selectionIndex.remove(at: index)
            }
        }else {
            selectionIndex.append(indexPath.item)
        }
        collectionView.reloadData()
    }
}
