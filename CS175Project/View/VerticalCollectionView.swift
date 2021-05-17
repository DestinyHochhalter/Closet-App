//
//  FlowLayoutCollectionView.swift
//  CS175Project
//
//  Created by Destiny Hochhalter Ruiz on 5/8/21.
//

import UIKit

class VerticalCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = .zero
        super.init(frame: frame, collectionViewLayout: layout)
        
        backgroundColor = UIColor.clear
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
