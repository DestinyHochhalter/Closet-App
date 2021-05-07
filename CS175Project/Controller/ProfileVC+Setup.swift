//
//  ProfileVC+Setup.swift
//  CS175Project
//
//  Created by Destiny Hochhalter Ruiz on 5/5/21.
//

import Foundation
import UIKit

extension ProfileVC {
    
    func addLayout() {
        
        profileImgVw.addLayout(parentVw: view, leading: (view.leadingAnchor, Padding.leading), top: (view.topAnchor, addPaddingForNotch(Padding.top)), height: Padding.profileImgSz, width: Padding.profileImgSz)
        
            
        moreImgVw.addLayout(parentVw: view, trailing: (view.trailingAnchor, -Padding.traling), vert: profileImgVw.centerYAnchor, height: Padding.iconSz, width: Padding.iconSz)
        
        searchImgVw.addLayout(parentVw: view, leading: (moreImgVw.leadingAnchor, -Padding.iconSpacing), vert: profileImgVw.centerYAnchor, height: Padding.iconSz, width: Padding.iconSz)
        
        
        plusImgVw.addLayout(parentVw: view, leading: (searchImgVw.leadingAnchor, -Padding.iconSpacing), vert: profileImgVw.centerYAnchor, height: Padding.iconSz, width: Padding.iconSz)
        
        userNameLbl.addLayout(parentVw: view, leading: (profileImgVw.trailingAnchor, Padding.leading), trailing: (plusImgVw.leadingAnchor, Padding.iconSpacing), vert: profileImgVw.centerYAnchor)
        
        
        seperatorView1.addLayout(parentVw: view, leading: (view.leadingAnchor, Padding.zero), trailing: (view.trailingAnchor, Padding.zero), top: (profileImgVw.bottomAnchor, Padding.seperatorSpacing), height: Padding.seperatorHeight)
        
        let mid: CGFloat = UIScreen.main.bounds.width / 2
        followersVw.addLayout(parentVw: view, leading: (view.leadingAnchor, Padding.zero), trailing: (view.trailingAnchor, -mid), top: (seperatorView1.bottomAnchor, Padding.zero), height: Padding.followVwHeight)
        
        
        followerCountLbl.addLayout(parentVw: view, top: (followersVw.topAnchor, Padding.seperatorSpacing), horiz: followersVw.centerXAnchor)
        followersLbl.addLayout(parentVw: view, top: (followerCountLbl.bottomAnchor, Padding.followSpacing), horiz: followersVw.centerXAnchor)
        
        
        followingVw.addLayout(parentVw: view, leading: (view.leadingAnchor, mid), trailing: (view.trailingAnchor, Padding.zero), top: (seperatorView1.bottomAnchor, Padding.zero), height: Padding.followVwHeight)
        followingCountLbl.addLayout(parentVw: view, top: (followingVw.topAnchor, Padding.seperatorSpacing), horiz: followingVw.centerXAnchor)
        followingLbl.addLayout(parentVw: view, top: (followingCountLbl.bottomAnchor, Padding.followSpacing), horiz: followingVw.centerXAnchor)
        
        
        
        seperatorView2.addLayout(parentVw: view, leading: (view.leadingAnchor, Padding.zero), trailing: (view.trailingAnchor, Padding.traling), top: (followersLbl.bottomAnchor, Padding.seperatorSpacing), height: Padding.seperatorHeight)
        
        closetVw.addLayout(parentVw: view, leading: (view.leadingAnchor, Padding.zero), trailing: (view.trailingAnchor, -mid), top: (seperatorView2.bottomAnchor, Padding.zero), height: Padding.profileVwHeight)
        
        collectionsVw.addLayout(parentVw: view, leading: (view.leadingAnchor, mid), trailing: (view.trailingAnchor, Padding.zero), top: (seperatorView2.bottomAnchor, Padding.zero), height: Padding.profileVwHeight)
        
        closetIconImgVw.addLayout(parentVw: view, horiz: closetVw.centerXAnchor, vert: closetVw.centerYAnchor, height: Padding.mediumIconSz, width: Padding.mediumIconSz)
        
        collectionsIconImgVw.addLayout(parentVw: view, horiz: collectionsVw.centerXAnchor, vert: collectionsVw.centerYAnchor, height: Padding.mediumIconSz, width: Padding.mediumIconSz)
        
        seperatorView3.addLayout(parentVw: view, leading: (view.leadingAnchor, Padding.zero), trailing: (view.trailingAnchor, Padding.traling), top: (collectionsVw.bottomAnchor, Padding.zero), height: Padding.seperatorHeight)
        
        selectionLine.addLayout(parentVw: view, vert: seperatorView3.centerYAnchor, height: Padding.selectionLineHeight, width: Padding.selectionLineWidth)
        
        let selectionLineLeading = (mid - Padding.selectionLineWidth) / 2
        selectionLineLeadingCon = NSLayoutConstraint(item: selectionLine, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 25)
            
          //  NSLayoutConstraint(item: selectionLine, attribute: .leading, relatedBy: .equal, toItem: nil, attribute: .leading, multiplier: 1.0, constant: 25)
        selectionLineLeadingCon?.isActive = true
        
        // changes leading constraint
        // use this to later animate constraint
        selectionLineLeadingCon?.constant = selectionLineLeading
        
        
        if isFollowing {
            // not user's own profile
            // show 'following/follow' option
        } else {
            
        }
    }
    
    
    
    func setLabels() {
        // set labels for username, follower count, following count
        // based on user info
        // FIXME: set labels accoridng to user info
        
        userNameLbl.text = "Destinyhoch"
        followerCountLbl.text = "300"
        followingCountLbl.text = "450"
        
    }
}
