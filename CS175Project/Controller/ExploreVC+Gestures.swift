//
//  ExploreVC+Gestures.swift
//  CS175Project
//
//  Created by Destiny Hochhalter Ruiz on 5/16/21.
//

import Foundation
import UIKit

extension ExploreVC {
    
    @objc func homeTapped() {
        // animate constraint to move under home icon
        let mid: CGFloat = UIScreen.main.bounds.width / 2
        let selectionLineLeading = (mid - Padding.selectionLineWidth) / 2
        UIView.animate(withDuration: 0.15, delay: 0, options: .curveLinear) {
            self.selectionLineLeadingCon?.constant = selectionLineLeading
            self.view.layoutIfNeeded()
        } completion: { (_) in
            // change color to reflect selected item
            self.shopIconImgVw.tintColor = Color.lightText
            self.homeIconImgVw.tintColor = Color.mediumText
            self.tableType = .explore
            self.exploreCollectionVw.reloadData()
            
            // show explore collection view for home tab
            //self.exploreCollectionVw.isHidden = false
        }
    }
    
    @objc func shopTapped() {
        // move constaint to collections icon
        let mid: CGFloat = UIScreen.main.bounds.width / 2
        let selectionLineLeading = ((mid - Padding.selectionLineWidth) / 2) + mid
        UIView.animate(withDuration: 0.15, delay: 0, options: .curveLinear) {
            self.selectionLineLeadingCon?.constant = selectionLineLeading
            self.view.layoutIfNeeded()
        } completion: { (_) in
            // change colors of icons
            self.homeIconImgVw.tintColor = Color.lightText
            self.shopIconImgVw.tintColor = Color.mediumText
            self.tableType = .shop
            self.exploreCollectionVw.reloadData()
            // hide explore collection view for shop tab
          //  self.exploreCollectionVw.isHidden = true
        }

    }
    
    func addGestures() {
        
        let homeTap = UITapGestureRecognizer(target: self, action: #selector(homeTapped))
        homeVw.addGestureRecognizer(homeTap)
        
        let shopTap = UITapGestureRecognizer(target: self, action: #selector(shopTapped))
        shopVw.addGestureRecognizer(shopTap)

        
    }
    
}
