//
//  ProfileVC+Gestures.swift
//  CS175Project
//
//  Created by Destiny Hochhalter Ruiz on 5/5/21.
//

import Foundation
import UIKit
import FirebaseAuth

extension ProfileVC {
    
    @objc func selectedFilterOptionVwTapped() {
        toggleFilterTable()
    }
    
    @objc func moreTapped() {
        // Show settings
        // option to log out
        showSettingsPopup()
    }
    
    @objc func closetTapped() {
        // animate constraint to move under closet icone
        let mid: CGFloat = UIScreen.main.bounds.width / 2
        let selectionLineLeading = (mid - Padding.selectionLineWidth) / 2
        UIView.animate(withDuration: 0.15, delay: 0, options: .curveLinear) {
            self.selectionLineLeadingCon?.constant = selectionLineLeading
            self.view.layoutIfNeeded()
        } completion: { (_) in
            // change color to reflect selected item
            self.collectionsIconImgVw.tintColor = Color.lightText
            self.closetIconImgVw.tintColor = Color.mediumText
            
            
            // show table view and collection view for closet tab
            self.selectedFilterOptionVw.isHidden = false
            self.gridCollectionVw.isHidden = false
            self.clothingCollectionsTable.isHidden = true
        }
      //  self.filterTable.isHidden = false
    }
    
    @objc func collectionsTapped() {
        // move constaint to collections icon
        let mid: CGFloat = UIScreen.main.bounds.width / 2
        let selectionLineLeading = ((mid - Padding.selectionLineWidth) / 2) + mid
        UIView.animate(withDuration: 0.15, delay: 0, options: .curveLinear) {
            self.selectionLineLeadingCon?.constant = selectionLineLeading
            self.view.layoutIfNeeded()
        } completion: { (_) in
            // change colors of icons
            self.closetIconImgVw.tintColor = Color.lightText
            self.collectionsIconImgVw.tintColor = Color.mediumText
            
            // hide table view and collection view for closet tab
            self.selectedFilterOptionVw.isHidden = true
            self.gridCollectionVw.isHidden = true
            self.clothingCollectionsTable.isHidden = false
       //     self.filterTable.isHidden = true
        }

    }
    
    func showSettingsPopup() {
        let alert = UIAlertController(title: nil, message: "Settings", preferredStyle: .actionSheet)
        let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        
        let logoutAction = UIAlertAction(title: "Sign out", style: .destructive) { (action) in
            // sign out
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                print("signed out!")
                let vc = AuthVC()
                vc.modalPresentationStyle = .overFullScreen
                vc.navigationItem.hidesBackButton = false
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: false)
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        }
            
        alert.addAction(logoutAction)
        alert.addAction(closeAction)
        self.present(alert, animated: true, completion: nil)
    }
    

    
    func addGestures() {
        let moreTap = UITapGestureRecognizer(target: self, action: #selector(moreTapped))
        moreImgVw.addGestureRecognizer(moreTap)
        
        let closetTap = UITapGestureRecognizer(target: self, action: #selector(closetTapped))
        closetVw.addGestureRecognizer(closetTap)
        
        let collectionsTap = UITapGestureRecognizer(target: self, action: #selector(collectionsTapped))
        collectionsVw.addGestureRecognizer(collectionsTap)
        
        let selectedFilterOptionVwTap = UITapGestureRecognizer(target: self, action: #selector(selectedFilterOptionVwTapped))
        selectedFilterOptionVw.addGestureRecognizer(selectedFilterOptionVwTap)
        
    }
}
