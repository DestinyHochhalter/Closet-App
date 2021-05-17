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
            let clothingItem = clothingArr[indexPath.item]
            print(clothingItem.photoUrls.first ?? "none")
            
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
        return clothingArr.count
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
            
            cell.setup(clothingItem: clothingArr[indexPath.row], index: indexPath.item, count: clothingArr.count)
            cell.delegate = self
            return cell

        } else {
            return UICollectionViewCell()
        }
    }
}
