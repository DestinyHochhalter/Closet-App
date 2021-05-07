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
    
    @objc func moreTapped() {
        // Show settings
        // option to log out
        showSettingsPopup()
    }
    
    @objc func closetTapped() {
        // animate constraint to move under closet icone
        let mid: CGFloat = UIScreen.main.bounds.width / 2
        let selectionLineLeading = (mid - Padding.selectionLineWidth) / 2
        selectionLineLeadingCon?.constant = selectionLineLeading
        // change color to reflect selected item
        collectionsIconImgVw.tintColor = Color.lightText
        closetIconImgVw.tintColor = Color.mediumText
    }
    
    @objc func collectionsTapped() {
        // move constaint to collections icon
        let mid: CGFloat = UIScreen.main.bounds.width / 2
        let selectionLineLeading = ((mid - Padding.selectionLineWidth) / 2) + mid
        selectionLineLeadingCon?.constant = selectionLineLeading
        // change colors of icons
        closetIconImgVw.tintColor = Color.lightText
        collectionsIconImgVw.tintColor = Color.mediumText

    }
    
    func showSettingsPopup() {
        let alert = UIAlertController(title: nil, message: "Settings", preferredStyle: .actionSheet)
        let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        
        let logoutAction = UIAlertAction(title: "Log out", style: .destructive) { (action) in
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
        
    }
}
