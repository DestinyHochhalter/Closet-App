//
//  ClothingCell.swift
//  CS175Project
//
//  Created by Destiny Hochhalter Ruiz on 5/7/21.
//

import Foundation
import UIKit
import Kingfisher

protocol ClothingCellDelegate {
    func cellTapped(cell: ClothingCell)
}


class ClothingCell: UICollectionViewCell, UICollectionViewDelegate {
    
    static let id = "FilterOptionCell"
    var delegate: ClothingCellDelegate?
    
    
    let clothingImgVw: UIImageView = {
        let imgVw = UIImageView()
        imgVw.clipsToBounds = true
        imgVw.contentMode = .scaleAspectFit
        imgVw.layer.borderWidth = 2
        imgVw.layer.borderColor = Color.mediumText.cgColor
        return imgVw
    }()
    
    
        override func awakeFromNib() {
            super.awakeFromNib()
            
            self.contentView.backgroundColor = Color.bg
            layoutCell()
            addGestures()
    
        }
    
    private func layoutCell() {
        clothingImgVw.fill(self.contentView)
    }
    
    func addGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        clothingImgVw.addGestureRecognizer(tap)
    }
    
    @objc func cellTapped() {
        delegate?.cellTapped(cell: self)
    }
    
    func setup(image: Clothing) {
        if let url = URL(string: image.photos.first!) {
        self.clothingImgVw.kf.setImage(with: url, placeholder: self.clothingImgVw.image, options: [.cacheOriginalImage])
        }

    }
    
    
}
