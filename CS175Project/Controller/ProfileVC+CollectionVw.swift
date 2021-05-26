//
//  ProfileVC+CollectionVw.swift
//  CS175Project
//
//  Created by Destiny Hochhalter Ruiz on 5/8/21.
//

import Foundation
import UIKit

extension ProfileVC: ClothingItemCellDelegate {
    func clothingCellTapped(cell: ClothingItemCell) {
        if let indexPath = gridCollectionVw.indexPath(for: cell) {
            
            let clothingItem = Array(filteredClosetDict)[indexPath.item].value
            print(clothingItem.name)
            
        }
    }
}

enum GridCollectionVars {
    static let itemCount: CGFloat = 3
    static let minimumSpacing: CGFloat = 0
    static let heightScale: CGFloat = 1.3
}

extension ProfileVC:  UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredClosetDict.count //clothingArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // spacing between collection view cells
        let inset = UIEdgeInsets(top: GridCollectionVars.minimumSpacing,
                            left: GridCollectionVars.minimumSpacing,
                            bottom: GridCollectionVars.minimumSpacing,
                            right: GridCollectionVars.minimumSpacing)
        return inset
    }
    
    func getCollectionItemSize(with layout: UICollectionViewLayout) -> CGSize {

        if let flowLayout = layout as? UICollectionViewFlowLayout {
            let edgeInsetPadding: CGFloat = GridCollectionVars.minimumSpacing * 2
            let width = (gridCollectionVw.frame.width - (GridCollectionVars.itemCount - 1) * GridCollectionVars.minimumSpacing - edgeInsetPadding) / GridCollectionVars.itemCount
            
            let height: CGFloat = width * GridCollectionVars.heightScale
            return CGSize(width: width, height: height)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return GridCollectionVars.minimumSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return GridCollectionVars.minimumSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return getCollectionItemSize(with: layout)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClothingItemCell.id, for: indexPath) as? ClothingItemCell {
            
            let item = Array(self.filteredClosetDict)[indexPath.row].value
            cell.setup(clothingItem: item, index: indexPath.item, count: filteredClosetDict.count)
            cell.delegate = self
            return cell

        } else {
            return UICollectionViewCell()
        }
    }
}
