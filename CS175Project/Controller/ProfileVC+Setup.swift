//
//  ProfileVC+Setup.swift
//  CS175Project
//
//  Created by Destiny Hochhalter Ruiz on 5/5/21.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore


extension ProfileVC {
    
    
    func addLayout() {
        
        addFilterTable()
        addGridCollection()
        addclothingCollectionsTable()
        
        
        // MARK: - Header View
        
        headerVw.addLayout(parentVw: view, leading: (view.leadingAnchor, Padding.zero), trailing: (view.trailingAnchor, Padding.zero), top: (view.topAnchor, Padding.zero), height: Constants.Sizes.ProfileHeader.headerVwHeight)
        
        profileImgVw.addLayout(parentVw: headerVw, leading: (headerVw.leadingAnchor, Padding.leading), top: (headerVw.topAnchor, addPaddingForNotch(Padding.top)), height: Constants.Sizes.ImageSize.Profile.profileImgSize.height, width: Constants.Sizes.ImageSize.Profile.profileImgSize.width)
        
        moreImgVw.addLayout(parentVw: headerVw, trailing: (headerVw.trailingAnchor, -Padding.traling), vert: profileImgVw.centerYAnchor, height: Constants.Sizes.ImageSize.Profile.smallIconSize.height, width: Constants.Sizes.ImageSize.Profile.smallIconSize.width)
        
        searchImgVw.addLayout(parentVw: headerVw, leading: (moreImgVw.leadingAnchor, -Padding.iconSpacing), vert: profileImgVw.centerYAnchor, height: Constants.Sizes.ImageSize.Profile.smallIconSize.height, width: Constants.Sizes.ImageSize.Profile.smallIconSize.width)
        
        
        plusImgVw.addLayout(parentVw: headerVw, leading: (searchImgVw.leadingAnchor, -Padding.iconSpacing), vert: profileImgVw.centerYAnchor, height: Constants.Sizes.ImageSize.Profile.smallIconSize.height, width: Constants.Sizes.ImageSize.Profile.smallIconSize.width)
        
        userNameLbl.addLayout(parentVw: headerVw, leading: (profileImgVw.trailingAnchor, Padding.leading), trailing: (plusImgVw.leadingAnchor, Padding.iconSpacing), vert: profileImgVw.centerYAnchor)
        
        
        separatorView1.addLayout(parentVw: headerVw, leading: (headerVw.leadingAnchor, Padding.zero), trailing: (headerVw.trailingAnchor, Padding.zero), bottom: (headerVw.bottomAnchor, Padding.zero), height: Padding.separatorHeight)
        
        
        // -------------------------------------------------------------------------------------------------------------
        
        
        // MARK: - Follow View
        
        followVw.addLayout(parentVw: view, leading: (view.leadingAnchor, Padding.zero), trailing: (view.trailingAnchor, Padding.zero), top: (headerVw.bottomAnchor, Padding.zero), height: Constants.Sizes.FollowVw.height)
        
        let mid: CGFloat = UIScreen.main.bounds.width / 2
        followersVw.addLayout(parentVw: followVw, leading: (followVw.leadingAnchor, Padding.zero), trailing: (followVw.trailingAnchor, -mid), top: (separatorView1.bottomAnchor, Padding.zero), height: Constants.Sizes.FollowVw.height)
        
        
        followersCountLbl.addLayout(parentVw: followersVw, top: (followersVw.topAnchor, Padding.separatorSpacing), horiz: followersVw.centerXAnchor)
        followersLbl.addLayout(parentVw: followersVw, top: (followersCountLbl.bottomAnchor, Padding.followSpacing), horiz: followersVw.centerXAnchor)
        
        
        followingVw.addLayout(parentVw: followVw, leading: (view.leadingAnchor, mid), trailing: (view.trailingAnchor, Padding.zero), top: (separatorView1.bottomAnchor, Padding.zero), height: Padding.followVwHeight)
        followingCountLbl.addLayout(parentVw: followingVw, top: (followingVw.topAnchor, Padding.separatorSpacing), horiz: followingVw.centerXAnchor)
        followingLbl.addLayout(parentVw: followingVw, top: (followingCountLbl.bottomAnchor, Padding.followSpacing), horiz: followingVw.centerXAnchor)
        
        
        
        separatorView2.addLayout(parentVw: followVw, leading: (view.leadingAnchor, Padding.zero), trailing: (view.trailingAnchor, Padding.traling), top: (followersLbl.bottomAnchor, Padding.separatorSpacing), height: Padding.separatorHeight)
        

        
        // -------------------------------------------------------------------------------------------------------------
        
        // MARK: - Segmented Control
        
        segmentedControlVw.addLayout(parentVw: view, leading: (view.leadingAnchor, Padding.zero), trailing: (view.trailingAnchor, Padding.zero), top: (followVw.bottomAnchor, Padding.zero), height: Constants.Sizes.SegmentedContol.height)
        
        closetVw.addLayout(parentVw: segmentedControlVw, leading: (segmentedControlVw.leadingAnchor, Padding.zero), trailing: (segmentedControlVw.trailingAnchor, -mid), top: (segmentedControlVw.topAnchor, Padding.zero), height: Constants.Sizes.SegmentedContol.height)
        
        collectionsVw.addLayout(parentVw: segmentedControlVw, leading: (segmentedControlVw.leadingAnchor, mid), trailing: (segmentedControlVw.trailingAnchor, Padding.zero), top: (segmentedControlVw.topAnchor, Padding.zero), height: Constants.Sizes.SegmentedContol.height)
        
        closetIconImgVw.addLayout(parentVw: segmentedControlVw, horiz: closetVw.centerXAnchor, vert: closetVw.centerYAnchor, height: Constants.Sizes.SegmentedContol.iconSize.height, width: Constants.Sizes.SegmentedContol.iconSize.width)
        
        collectionsIconImgVw.addLayout(parentVw: segmentedControlVw, horiz: collectionsVw.centerXAnchor, vert: collectionsVw.centerYAnchor, height: Constants.Sizes.SegmentedContol.iconSize.height, width: Constants.Sizes.SegmentedContol.iconSize.width)
        
        separatorView3.addLayout(parentVw: segmentedControlVw, leading: (segmentedControlVw.leadingAnchor, Padding.zero), trailing: (segmentedControlVw.trailingAnchor, Padding.traling), top: (collectionsVw.bottomAnchor, Padding.zero), height: Padding.separatorHeight)
        
        selectionLine.addLayout(parentVw: segmentedControlVw, vert: separatorView3.centerYAnchor, height: Padding.selectionLineHeight, width: Padding.selectionLineWidth)
        
        let selectionLineLeading = (mid - Padding.selectionLineWidth) / 2
        selectionLineLeadingCon = NSLayoutConstraint(item: selectionLine, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 25)
            
        selectionLineLeadingCon?.isActive = true
        
        // changes leading constraint
        // use this to later animate constraint
        selectionLineLeadingCon?.constant = selectionLineLeading
        
        
        // -------------------------------------------------------------------------------------------------------------
        
        
        
        if isFollowing {
            // not user's own profile
            // show 'following/follow' option
        } else {
            
        }
        
       
    }
    
    private func addFilterTable() {
        
        // Selected Option View
        selectedFilterOptionVw.addLayout(parentVw: self.view, leading: (self.view.leadingAnchor, Padding.zero), trailing: (self.view.trailingAnchor, Padding.zero), top: (view.topAnchor, Constants.Sizes.Height.topHeight), height: Constants.Sizes.FilterOption.OptionHeight)
        selectedFilterOptionLbl.addLayout(parentVw: selectedFilterOptionVw, leading: (selectedFilterOptionVw.leadingAnchor, Padding.leading), top: (selectedFilterOptionVw.topAnchor, Constants.Sizes.FilterOption.topSpace))
        selectedFilterOptionArrow.addLayout(parentVw: selectedFilterOptionVw, trailing: (selectedFilterOptionVw.trailingAnchor, -Padding.traling), vert: selectedFilterOptionLbl.centerYAnchor, height: Constants.Sizes.FilterOption.Arrow.height, width: Constants.Sizes.FilterOption.Arrow.width)
        
        
        // Filter Option Table
        
        collectionLoadingView.addLayout(parentVw: self.view, leading: (self.view.leadingAnchor,0), trailing: (self.view.trailingAnchor,0), top: (selectedFilterOptionVw.bottomAnchor,0), bottom: (self.view.bottomAnchor,0))
        
        
        filterTable.addLayout(parentVw: self.view, leading: (self.view.leadingAnchor,0), trailing: (self.view.trailingAnchor,0), height: 300)
        filterTableTopCon = NSLayoutConstraint(item: filterTable, attribute: .top, relatedBy: .equal, toItem: selectedFilterOptionVw, attribute: .bottom, multiplier: 1.0, constant: 0)
        filterTableTopCon?.isActive = true
        
        hideFilterTable()
        
    }
    
    private func addGridCollection() {
        
        gridCollectionVw.addLayout(parentVw: self.view, leading: (self.view.leadingAnchor, Padding.zero), trailing: (self.view.trailingAnchor, -Padding.zero), bottom: (self.view.bottomAnchor, Padding.zero))
        gridCollectionTopCon = NSLayoutConstraint(item: gridCollectionVw, attribute: .top, relatedBy: .equal, toItem: selectedFilterOptionVw, attribute: .bottom, multiplier: 1.0, constant: 0)
        gridCollectionTopCon?.isActive = true
      //  gridCollectionTopCon?.constant = Constants.Sizes.GridCollection.gridCollectionHeight
        dropShadowTopVw.addLayout(parentVw: self.view, leading: (self.view.leadingAnchor, Padding.zero), trailing: (self.view.trailingAnchor, Padding.zero), top: (gridCollectionVw.topAnchor, -Constants.Sizes.DropShadow.spacing),height: Constants.Sizes.DropShadow.height)
        
        dropShadowBottomVw.addLayout(parentVw: self.view, leading: (self.view.leadingAnchor, Padding.zero), trailing: (self.view.trailingAnchor, Padding.zero), bottom: (gridCollectionVw.bottomAnchor, Constants.Sizes.DropShadow.spacing), height: Constants.Sizes.DropShadow.height)
    }
    
    private func addclothingCollectionsTable() {
        clothingCollectionsTable.addLayout(parentVw: self.view, leading: (self.view.leadingAnchor, Padding.zero), trailing: (self.view.trailingAnchor, Padding.zero), top: (self.view.topAnchor, Constants.Sizes.Height.topHeight + Constants.Sizes.ClothingCollectionCell.spacing), bottom: (self.view.bottomAnchor, -Constants.Sizes.ClothingCollectionCell.spacing))
    }
    
    // use profile document to set labels
    func setLabels(document: QueryDocumentSnapshot) {
        // set labels for username, follower count, following count
        // based on user info
        
        // username
        userNameLbl.text = document["username"] as! String
        
        // follow labels
        followersCountLbl.text = document["followerCount"] as! String
        followingCountLbl.text = document["followingCount"] as! String
        
        // profile picture
        if let profileURL = document["profileImageUrl"] as? String,
           let url = URL(string: profileURL){
            self.profileImgVw.kf.setImage(with: url)
        }
    
        selectedFilterOptionLbl.text = filterOptionArr.getSelectedAndUnselectedOptions().selected?.type.rawValue
        }
    }
    
    
    func setFirestoreProfileListener() {
        
        if let user = Auth.auth().currentUser?.uid {
            let userRef = db.collection("users").document(user).collection("profile")
                .addSnapshotListener { querySnapshot, error in
                    guard let snapshot = querySnapshot else {
                        print("Error fetching snapshots: \(error!)")
                        return
                    }
                    
                    snapshot.documentChanges.forEach { diff in

                        if (diff.type == .modified) {
                            print("Modified Document: \(diff.document.data())")
                            
                            self.setLabels(document: diff.document)
                            
                        }
                        
                    }
                }
        }
}
