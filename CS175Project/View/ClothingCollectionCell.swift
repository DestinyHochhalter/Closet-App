//
//  ClothingCollectionVw.swift
//  CS175Project
//
//  Created by Destiny Hochhalter Ruiz on 5/16/21.
//

import Foundation
import UIKit
import Kingfisher

protocol ClothingCollectionCellDelegate {
    func clothingCollectionCellItemTapped(cell: ClothingCollectionCell)
    func optionsTapped(cell: ClothingCollectionCell)
}


final class ClothingCollectionCell: UITableViewCell {
    
    var delegate: ClothingCollectionCellDelegate?
    
    // has tile, 3 image views, and options
    
    let containerVw: UIView = {
        let vw = UIView()
        vw.backgroundColor = Color.lightText
        vw.layer.cornerRadius = 7
        return vw
    }()
    
    // collection name label
    var collectionNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Avenir-Heavy", size: 17)
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
        imgVw.tintColor = Color.mediumText
        imgVw.image = Constants.Images.More
        return imgVw
    }()
    
    // image view for clothing piece
    let clothingImgVw1: UIImageView = {
        let imgVw = UIImageView()
        imgVw.clipsToBounds = true
        imgVw.contentMode = .scaleAspectFill
        imgVw.isUserInteractionEnabled = true
        imgVw.layer.cornerRadius = 3
        imgVw.isUserInteractionEnabled = true
        return imgVw
    }()
    
    let clothingImgVw2: UIImageView = {
        let imgVw = UIImageView()
        imgVw.clipsToBounds = true
        imgVw.contentMode = .scaleAspectFill
        imgVw.isUserInteractionEnabled = true
        imgVw.layer.cornerRadius = 3
        imgVw.isUserInteractionEnabled = true
        return imgVw
    }()
    let clothingImgVw3: UIImageView = {
        let imgVw = UIImageView()
        imgVw.clipsToBounds = true
        imgVw.contentMode = .scaleAspectFill
        imgVw.isUserInteractionEnabled = true
        imgVw.layer.cornerRadius = 3
        imgVw.isUserInteractionEnabled = true
        return imgVw
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        addGestures()
    }
    
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    func setup(collection: [ClothingItem]) {
        // set photos
        
        let firstPhotoUrl = collection[0].photoUrls[0]
        if let url = URL(string: firstPhotoUrl) {
            self.clothingImgVw1.kf.setImage(with: url)
        }
        
        let secondPhotoUrl = collection[1].photoUrls[0]
        if let url = URL(string: secondPhotoUrl) {
            self.clothingImgVw2.kf.setImage(with: url)
        }
        
        let thirdPhotoUrl = collection[2].photoUrls[0]
        if let url = URL(string: thirdPhotoUrl) {
            self.clothingImgVw1.kf.setImage(with: url)
        }
        

    }
    
    private func layoutCell() {
        containerVw.fill(self.contentView)
        
    }
    
    func addGestures() {
        
    }
}
