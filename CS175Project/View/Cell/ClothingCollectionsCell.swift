//
//  ClothingCollectionVw.swift
//  CS175Project
//
//  Created by Destiny Hochhalter Ruiz on 5/16/21.
//

import Foundation
import UIKit
import Kingfisher

protocol ClothingCollectionsCellDelegate {
    func clothingCollectionsCellItemTapped(cell: ClothingCollectionsCell)
    func optionsTapped(cell: ClothingCollectionsCell)
}


final class ClothingCollectionsCell: UITableViewCell {
    
    static let id = "ClothingCollectionsCell"
    var delegate: ClothingCollectionsCellDelegate?
    
    var collection: ClothingCollection?
    
    // has tile, 3 image views, and options
    
    let containerVw: UIView = {
        let vw = UIView()
        vw.backgroundColor = Color.collectionsBg
        vw.layer.cornerRadius = 8
        return vw
    }()
    
    // collection name label
    var collectionNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Avenir-Medium", size: 17)
        lbl.textColor = Color.mediumText
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textAlignment = NSTextAlignment.left
        lbl.minimumScaleFactor = 0.8
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    // more icon
    let moreImgVw: UIImageView = {
        let imgVw = UIImageView()
        imgVw.clipsToBounds = true
        imgVw.contentMode = .scaleAspectFit
        imgVw.isUserInteractionEnabled = true
        imgVw.tintColor = Color.lightText
        imgVw.image = UIImage(named: "more")?.pad(-5)
        return imgVw
    }()
    
    // image view for clothing piece
    let clothingImgVw1: UIImageView = {
        let imgVw = UIImageView()
        imgVw.clipsToBounds = true
        imgVw.contentMode = .scaleAspectFill
        imgVw.isUserInteractionEnabled = true
        imgVw.layer.cornerRadius = 6
        imgVw.isUserInteractionEnabled = true
        return imgVw
    }()
    
    let clothingImgVw2: UIImageView = {
        let imgVw = UIImageView()
        imgVw.clipsToBounds = true
        imgVw.contentMode = .scaleAspectFill
        imgVw.isUserInteractionEnabled = true
        imgVw.layer.cornerRadius = 6
        imgVw.isUserInteractionEnabled = true
        return imgVw
    }()
    let clothingImgVw3: UIImageView = {
        let imgVw = UIImageView()
        imgVw.clipsToBounds = true
        imgVw.contentMode = .scaleAspectFill
        imgVw.isUserInteractionEnabled = true
        imgVw.layer.cornerRadius = 6
        imgVw.isUserInteractionEnabled = true
        imgVw.backgroundColor = .red
        return imgVw
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        addGestures()
    }

    

    func setup(collection: ClothingCollection) {
        // set photos
        
        if let firstPhotoUrl = collection.items[0].photoUrls.first,
        let url = URL(string: firstPhotoUrl) {
            self.clothingImgVw1.kf.setImage(with: url)
        }
        
        if let secondPhotoUrl = collection.items[1].photoUrls.first,
        let url = URL(string: secondPhotoUrl) {
            self.clothingImgVw2.kf.setImage(with: url)
        }
        
        if let thirdPhotoUrl = collection.items[2].photoUrls.first,
        let url = URL(string: thirdPhotoUrl) {
            self.clothingImgVw3.kf.setImage(with: url)
        }
        
        // set collection label
        collectionNameLbl.text = collection.name
        
        layoutCell()
    }
    
    private func layoutCell() {
        containerVw.addLayout(parentVw: self.contentView, leading: (self.contentView.leadingAnchor, Constants.Sizes.ClothingCollectionCell.spacing), trailing: (self.contentView.trailingAnchor, -Constants.Sizes.ClothingCollectionCell.spacing), top: (self.contentView.topAnchor, Constants.Sizes.ClothingCollectionCell.spacing), bottom: (self.contentView.bottomAnchor, -Constants.Sizes.ClothingCollectionCell.spacing))
        collectionNameLbl.addLayout(parentVw: containerVw, leading: (containerVw.leadingAnchor, Constants.Sizes.ClothingCollectionCell.spacing), bottom: (containerVw.bottomAnchor, -Constants.Sizes.ClothingCollectionCell.padding), height: 25)
       
        moreImgVw.addLayout(parentVw: containerVw, trailing: (containerVw.trailingAnchor, -Constants.Sizes.ClothingCollectionCell.spacing), top: (containerVw.topAnchor, Constants.Sizes.ClothingCollectionCell.padding), height: Constants.Sizes.ClothingCollectionCell.iconSize, width: Constants.Sizes.ClothingCollectionCell.iconSize)
        
        let itemWidth = ((containerVw.bounds.width - (Constants.Sizes.ClothingCollectionCell.padding * 4)) / 3) - 10
        clothingImgVw1.addLayout(parentVw: containerVw, leading: (containerVw.leadingAnchor, Constants.Sizes.ClothingCollectionCell.spacing), top: (containerVw.topAnchor, Constants.Sizes.ClothingCollectionCell.topSpace), bottom: (collectionNameLbl.topAnchor, -Constants.Sizes.ClothingCollectionCell.padding), width: itemWidth)
        
        clothingImgVw2.addLayout(parentVw: containerVw, leading: (clothingImgVw1.trailingAnchor, Constants.Sizes.ClothingCollectionCell.padding), top: (clothingImgVw1.topAnchor, Padding.zero),bottom: (collectionNameLbl.topAnchor, -Constants.Sizes.ClothingCollectionCell.padding), width: itemWidth)
        
        clothingImgVw3.addLayout(parentVw: containerVw, leading: (clothingImgVw2.trailingAnchor, Constants.Sizes.ClothingCollectionCell.padding), top: (clothingImgVw1.topAnchor, Padding.zero), bottom: (collectionNameLbl.topAnchor, -Constants.Sizes.ClothingCollectionCell.padding), width: itemWidth)
        
    }
    
    func addGestures() {
        
        let firstTap = UITapGestureRecognizer(target: self, action: #selector(_clothingCollectionCellItemTapped))
        clothingImgVw1.addGestureRecognizer(firstTap)
        
        let secondTap = UITapGestureRecognizer(target: self, action: #selector(_clothingCollectionCellItemTapped))
        clothingImgVw2.addGestureRecognizer(secondTap)
        
        let thirdTap = UITapGestureRecognizer(target: self, action: #selector(_clothingCollectionCellItemTapped))
        clothingImgVw3.addGestureRecognizer(thirdTap)
        
        let optionsTap = UITapGestureRecognizer(target: self, action: #selector(_optionsTapped))
        clothingImgVw3.addGestureRecognizer(optionsTap)
    
    }
    
    @objc func _clothingCollectionCellItemTapped() {
        delegate?.clothingCollectionsCellItemTapped(cell: self)
    }
    
    @objc func _optionsTapped() {
        delegate?.optionsTapped(cell: self)
    }
}
