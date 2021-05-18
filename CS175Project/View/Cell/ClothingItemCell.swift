//
//  ClothingCell.swift
//  CS175Project
//
//  Created by Destiny Hochhalter Ruiz on 5/7/21.
//

import Foundation
import UIKit
import Kingfisher

protocol ClothingItemCellDelegate {
    func clothingCellTapped(cell: ClothingItemCell)
}

enum GridItemHorizAlignment: String {
    case left = "left"
    case right = "right"
    case middle = "middle"
}

enum GridItemVertAlignment: String {
    case top = "top"
    case bottom = "bottom"
    case topAndBottom = "top and bottom"
    case none = "none"
}

// Based on index, get alignment of cell
func getGridItemHorizAlignment(index: Int) -> GridItemHorizAlignment {
    let itemOrder = (index + 1) % 3
    if itemOrder == 0 {
        return GridItemHorizAlignment.right
    } else if itemOrder == 1 {
        return GridItemHorizAlignment.left
    } else { // 2
        return GridItemHorizAlignment.middle
    }
}

// Based on index and array count,
// determine if cell is at the top or botton of collection view (or both if only one row)
func getGridItemVertAlignment(index: Int, count: Int) -> GridItemVertAlignment {
    
    let isTopAndBottom = count < 4
    let isTopRow = ((count > 4) && (index < 3))
   // let remainder = count % 3 // how many items should be in last row
    let isBottomRow = ((count - (index + 1)) < 3)
    
    if isTopAndBottom {
        return .topAndBottom
    } else if isTopRow {
        return .top
    } else if isBottomRow {
        return .bottom
    } else {
        return .none
    }
}

class ClothingItemCell: UICollectionViewCell {
    
    static let id = "ClothingItemCell"
    
    var delegate: ClothingItemCellDelegate?
    
    let clothingImgVw: UIImageView = {
        let imgVw = UIImageView()
        imgVw.clipsToBounds = true
        imgVw.contentMode = .scaleAspectFill
        imgVw.isUserInteractionEnabled = true
        // imgVw.layer.borderWidth = 2
       // imgVw.layer.borderColor = Color.mediumText.cgColor
        return imgVw
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.backgroundColor = Color.mediumText.withAlphaComponent(0.85)
        addGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum ClothingCellPadding {
        static let padding: CGFloat = 1
        static let none: CGFloat = 0
    }
    
    
    private func layoutCell(index: Int, count: Int) {
        let horizAlignment = getGridItemHorizAlignment(index: index)
        let vertAlignment = getGridItemVertAlignment(index: index, count: count)
        switch horizAlignment {
        case .left:
            print("left cell! \(index)\n")
            // left padding, no right
            switch vertAlignment {
            // top and bottom padding
            case .none:
                print("left none\n")
                clothingImgVw.addLayout(parentVw: self.contentView, leading: (self.contentView.leadingAnchor, ClothingCellPadding.padding), trailing: (self.contentView.trailingAnchor, -ClothingCellPadding.none), top: (self.contentView.topAnchor, ClothingCellPadding.padding), bottom: (self.contentView.bottomAnchor, -ClothingCellPadding.none))
                break
            case .topAndBottom:
                print("left top bottom\n")
                clothingImgVw.addLayout(parentVw: self.contentView, leading: (self.contentView.leadingAnchor, ClothingCellPadding.padding), trailing: (self.contentView.trailingAnchor, -ClothingCellPadding.none), top: (self.contentView.topAnchor, ClothingCellPadding.padding), bottom: (self.contentView.bottomAnchor, -ClothingCellPadding.padding))
                break
            case .top:
                // no bottom padding
                print("left top\n")
                clothingImgVw.addLayout(parentVw: self.contentView, leading: (self.contentView.leadingAnchor, ClothingCellPadding.padding), trailing: (self.contentView.trailingAnchor, -ClothingCellPadding.none), top: (self.contentView.topAnchor, ClothingCellPadding.padding), bottom: (self.contentView.bottomAnchor, -ClothingCellPadding.none))
                
                break
                
            case .bottom:
                // no top padding
                print("left bottom\n")
                clothingImgVw.addLayout(parentVw: self.contentView, leading: (self.contentView.leadingAnchor, ClothingCellPadding.padding), trailing: (self.contentView.trailingAnchor, -ClothingCellPadding.none), top: (self.contentView.topAnchor, ClothingCellPadding.padding), bottom: (self.contentView.bottomAnchor, -ClothingCellPadding.padding))
                break
                
            }
            break
            
        case .right:
            print("right cell! \(index)\n")
            // right padding, no left
            switch vertAlignment {
            case .none:
                print("right none\n")
                clothingImgVw.addLayout(parentVw: self.contentView, leading: (self.contentView.leadingAnchor, ClothingCellPadding.none), trailing: (self.contentView.trailingAnchor, -ClothingCellPadding.padding), top: (self.contentView.topAnchor, ClothingCellPadding.padding), bottom: (self.contentView.bottomAnchor, -ClothingCellPadding.none))
                break
            case .topAndBottom:
                print("right top bottom\n")
                clothingImgVw.addLayout(parentVw: self.contentView, leading: (self.contentView.leadingAnchor, ClothingCellPadding.none), trailing: (self.contentView.trailingAnchor, -ClothingCellPadding.padding), top: (self.contentView.topAnchor, ClothingCellPadding.padding), bottom: (self.contentView.bottomAnchor, -ClothingCellPadding.padding))
                break
            case .top:
                // no bottom padding
                print("right top\n")
                clothingImgVw.addLayout(parentVw: self.contentView, leading: (self.contentView.leadingAnchor, ClothingCellPadding.none), trailing: (self.contentView.trailingAnchor, -ClothingCellPadding.padding), top: (self.contentView.topAnchor, ClothingCellPadding.padding), bottom: (self.contentView.bottomAnchor, -ClothingCellPadding.none))
                break
                
            case .bottom:
                // no top padding
                print("right bottom\n")
                clothingImgVw.addLayout(parentVw: self.contentView, leading: (self.contentView.leadingAnchor, ClothingCellPadding.none), trailing: (self.contentView.trailingAnchor, -ClothingCellPadding.padding), top: (self.contentView.topAnchor, ClothingCellPadding.none), bottom: (self.contentView.bottomAnchor, -ClothingCellPadding.padding))
                break
            }
            break
            
        case .middle:
            print("middle cell! \(index)\n")
            // middle cell gets left and right padding
            switch(vertAlignment) {
            case .none:
                print("middle none")
                // gets top and bottom padding
                // left and right padding
                clothingImgVw.addLayout(parentVw: self.contentView, leading: (self.contentView.leadingAnchor, ClothingCellPadding.padding), trailing: (self.contentView.trailingAnchor, -ClothingCellPadding.padding), top: (self.contentView.topAnchor, ClothingCellPadding.padding), bottom: (self.contentView.bottomAnchor, -ClothingCellPadding.none))
                break
                
            case .topAndBottom:
                // pad all sides
                print("middle top bottom")
                clothingImgVw.addLayout(parentVw: self.contentView, leading: (self.contentView.leadingAnchor, ClothingCellPadding.padding), trailing: (self.contentView.trailingAnchor, -ClothingCellPadding.none), top: (self.contentView.topAnchor, ClothingCellPadding.padding), bottom: (self.contentView.bottomAnchor, -ClothingCellPadding.padding))
                break
                
            case .top:
                print("middle top")
                // get top padding, no bottom padding
                // no left or right padding
                clothingImgVw.addLayout(parentVw: self.contentView, leading: (self.contentView.leadingAnchor, ClothingCellPadding.padding), trailing: (self.contentView.trailingAnchor, -ClothingCellPadding.padding), top: (self.contentView.topAnchor, ClothingCellPadding.padding), bottom: (self.contentView.bottomAnchor, -ClothingCellPadding.none))
                break
                
            case .bottom:
                print("middle bottom")
                // no top padding, only bottom
                // no left or right padding
                clothingImgVw.addLayout(parentVw: self.contentView, leading: (self.contentView.leadingAnchor, ClothingCellPadding.padding), trailing: (self.contentView.trailingAnchor, -ClothingCellPadding.padding), top: (self.contentView.topAnchor, ClothingCellPadding.padding), bottom: (self.contentView.bottomAnchor, -ClothingCellPadding.padding))
                break
            }
            
            break
        }
    }
    
    func addGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(clothingCellTapped))
        clothingImgVw.addGestureRecognizer(tap)
    }
    
    @objc func clothingCellTapped() {
        delegate?.clothingCellTapped(cell: self)
    }
    
    func setup(clothingItem: ClothingItem, index: Int, count: Int) {
        layoutCell(index: index, count: count)
        
        if let firstPhotoUrl = clothingItem.photoUrls.first,
           let url = URL(string: firstPhotoUrl){
            // self.clothingImgVw.kf.setImage(with: url, placeholder: nil, options: [.cacheOriginalImage])
            self.clothingImgVw.kf.setImage(with: url)
        }
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clothingImgVw.image = nil
        clothingImgVw.removeFromSuperview()
        
    }
    
    
}
