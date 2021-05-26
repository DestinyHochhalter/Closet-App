//
//  ExploreVC+Setup.swift
//  CS175Project
//
//  Created by Destiny Hochhalter Ruiz on 5/16/21.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore

extension ExploreVC {
    
    func addLayout() {
        
        addSegmentedControl()
        addSearchField()
        
        // layout for explore collection view
        exploreCollectionVw.addLayout(parentVw: self.view, leading: (self.view.leadingAnchor, Padding.zero), trailing: (self.view.trailingAnchor, -Padding.zero), top: (separatorView2.bottomAnchor, Padding.zero), bottom: (self.view.bottomAnchor, Padding.zero))
        dropShadowTopVw.addLayout(parentVw: self.view, leading: (self.view.leadingAnchor, Padding.zero), trailing: (self.view.trailingAnchor, Padding.zero), top: (exploreCollectionVw.topAnchor, -Constants.Sizes.DropShadow.spacing),height: Constants.Sizes.DropShadow.height)
        
        dropShadowBottomVw.addLayout(parentVw: self.view, leading: (self.view.leadingAnchor, Padding.zero), trailing: (self.view.trailingAnchor, Padding.zero), bottom: (exploreCollectionVw.bottomAnchor, Constants.Sizes.DropShadow.spacing), height: Constants.Sizes.DropShadow.height)
    }
    
    
    // MARK:- Layout for Segmented Control
    private func addSegmentedControl() {
        
        
        segmentedControlVw.addLayout(parentVw: view, leading: (view.leadingAnchor, Padding.zero), trailing: (view.trailingAnchor, Padding.zero), top: (view.topAnchor, Padding.zero), height: Constants.Sizes.ProfileHeader.headerVwHeight)
        
        separatorView1.addLayout(parentVw: segmentedControlVw, leading: (segmentedControlVw.leadingAnchor, Padding.zero), trailing: (segmentedControlVw.trailingAnchor, Padding.zero), bottom: (segmentedControlVw.bottomAnchor, Padding.zero), height: Padding.separatorHeight)
        
        let mid: CGFloat = UIScreen.main.bounds.width / 2
        
        homeVw.addLayout(parentVw: segmentedControlVw, leading: (segmentedControlVw.leadingAnchor, Padding.zero), trailing: (segmentedControlVw.trailingAnchor, -mid), top: (segmentedControlVw.topAnchor, addPaddingForNotch(Padding.top)), height: Constants.Sizes.SegmentedContol.height)
        
        shopVw.addLayout(parentVw: segmentedControlVw, leading: (segmentedControlVw.leadingAnchor, mid), trailing: (segmentedControlVw.trailingAnchor, Padding.zero), top: (segmentedControlVw.topAnchor, addPaddingForNotch(Padding.top)), height: Constants.Sizes.SegmentedContol.height)
        
        homeIconImgVw.addLayout(parentVw: segmentedControlVw, bottom: (shopVw.bottomAnchor, Padding.separatorSpacing),horiz: homeVw.centerXAnchor, height: Constants.Sizes.SegmentedContol.iconSize.height+2, width: Constants.Sizes.SegmentedContol.iconSize.width+2)
        
        shopIconImgVw.addLayout(parentVw: segmentedControlVw,  bottom: (shopVw.bottomAnchor, Padding.separatorSpacing), horiz: shopVw.centerXAnchor, height: Constants.Sizes.SegmentedContol.iconSize.height, width: Constants.Sizes.SegmentedContol.iconSize.width)

        selectionLine.addLayout(parentVw: segmentedControlVw, vert: separatorView1.centerYAnchor, height: Padding.selectionLineHeight, width: Padding.selectionLineWidth)
        
        let selectionLineLeading = (mid - Padding.selectionLineWidth) / 2
        selectionLineLeadingCon = NSLayoutConstraint(item: selectionLine, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 25)
            
        selectionLineLeadingCon?.isActive = true
        
        // changes leading constraint
        // use this to later animate constraint
        selectionLineLeadingCon?.constant = selectionLineLeading
    }
    
    // MARK:- Auto layout for serach textfield
    private func addSearchField() {
        searchFieldContainer.addLayout(parentVw: view, leading: (view.leadingAnchor, Padding.zero), trailing: (view.trailingAnchor, Padding.zero), top: (segmentedControlVw.bottomAnchor, Padding.separatorSpacing), horiz: view.centerXAnchor, height: Constants.Sizes.SearchField.height)
        searchImgVw.addLayout(parentVw: searchFieldContainer, leading: (searchFieldContainer.leadingAnchor, Padding.zero), vert: searchFieldContainer.centerYAnchor, height: Constants.Sizes.ImageSize.Profile.smallIconSize.height, width: Constants.Sizes.ImageSize.Profile.smallIconSize.width)
        searchTextField.addLayout(parentVw: searchFieldContainer, leading: (searchImgVw.trailingAnchor, 5),trailing: (searchFieldContainer.trailingAnchor, -10), top: (searchFieldContainer.topAnchor, 5), vert: searchFieldContainer.centerYAnchor)
        separatorView2.addLayout(parentVw: searchFieldContainer, leading: (searchFieldContainer.leadingAnchor, Padding.zero), trailing: (searchFieldContainer.trailingAnchor, Padding.zero), bottom: (searchFieldContainer.bottomAnchor, Padding.zero), height: Padding.separatorHeight)
    }
    
    
    // MARK: - Add Firestore listeners
    
    func addFirestoreExploreData(document: QueryDocumentSnapshot) {
        
        let itemId = document["id"] as! String
        let brand = document["brand"] as! String
        let name = document["name"] as! String
        let photoUrl = document["photoUrl"] as! String
        let type = document["type"] as! String
        let url = document["url"] as! String
        
        let _type = getFilterOptionType(type)
        
        
        let closetItem = ClothingItem(name: name, brand: brand, url: url, photoUrl: photoUrl, type: _type)
        
        // copy objects to two arrays, one filter array and one non-filtered array
        self.exploreDict[itemId] = closetItem
        self.exploreCollectionVw.reloadData()
    }
    
    func setFirestoreExploreListener() {
        if let user = Auth.auth().currentUser?.uid {
            
            db?.collection("users").document(user).collection("explore")
                .addSnapshotListener { querySnapshot, error in
                    guard let snapshot = querySnapshot else {
                        print("Error fetching snapshots: \(error!)")
                        return
                    }
                    
                    // no changes
                    snapshot.documents.forEach { doc in
                        self.addFirestoreExploreData(document: doc)
                        
                    }
                    
                    // observe changes since ViewDidLoad is called
                    snapshot.documentChanges.forEach { diff in
                        
                        if (diff.type == .modified) {
                            self.addFirestoreExploreData(document: diff.document)
                            
                        }
                        
                        if (diff.type == .removed) {
                            // handle UI
                            let ref = diff.document.data()
                            self.exploreDict[ref["id"] as! String] = nil
                            
                        }
                        
                    }
                }
            
        }
    }
    
    func addFirestoreShopData(document: QueryDocumentSnapshot) {
        
        let itemId = document["id"] as! String
        let brand = document["brand"] as! String
        let name = document["name"] as! String
        let photoUrl = document["photoUrl"] as! String
        let type = document["type"] as! String
        let url = document["url"] as! String
        
        let _type = getFilterOptionType(type)
        
        
        let shopItem = ClothingItem(name: name, brand: brand, url: url, photoUrl: photoUrl, type: _type)
        
        // copy objects to two arrays, one filter array and one non-filtered array
        self.shopDict[itemId] = shopItem
        self.exploreCollectionVw.reloadData()
    }
    
    func setFirestoreShopListener() {
        if let user = Auth.auth().currentUser?.uid {
            
            db?.collection("users").document(user).collection("shop")
                .addSnapshotListener { querySnapshot, error in
                    guard let snapshot = querySnapshot else {
                        print("Error fetching snapshots: \(error!)")
                        return
                    }
                    
                    // no changes
                    snapshot.documents.forEach { doc in
                        self.addFirestoreShopData(document: doc)
                        
                    }
                    
                    // observe changes since ViewDidLoad is called
                    snapshot.documentChanges.forEach { diff in
                        
                        if (diff.type == .modified) {
                            self.addFirestoreShopData(document: diff.document)
                            
                        }
                        
                        if (diff.type == .removed) {
                            // handle UI
                            let ref = diff.document.data()
                            self.shopDict[ref["id"] as! String] = nil
                            
                        }
                        
                    }
                }
            
        }
    }
    
    
    // MARK: - Add fake data to Firebase
    
    func addExploreItems(_ arr: [ClothingItem]) {
        for item in 0..<arr.count {
            
            addExploreRef(arr[item])
            
        }
    }
    
    func addExploreRef(_ item: ClothingItem) {
        if let user = Auth.auth().currentUser?.uid {
            if let usersRef = db?.collection("users") {
                let id = NSUUID().uuidString
            
                
                
                let exploreRef = usersRef.document(user).collection("explore")
                let clothingRef = exploreRef.document(id)
                
                let data = ["id": id,
                            "name": item.name,
                            "brand": item.brand,
                            "url": item.url,
                            "photoUrl": item.photoUrl,
                            "type": item.type.rawValue,
                            "timestamp": item.timestamp] as [String : Any]
                print("data \(data)")
                
                clothingRef.setData(data)
                
                
            }
        }
    }
    
    func addShopItems(_ arr: [ClothingItem]) {
        for item in 0..<arr.count {
            
            addShopRef(arr[item])
            
        }
    }
    
    func addShopRef(_ item: ClothingItem) {
        if let user = Auth.auth().currentUser?.uid {
            if let usersRef = db?.collection("users") {
                let id = NSUUID().uuidString
            
                
                
                let shopRef = usersRef.document(user).collection("shop")
                let clothingRef = shopRef.document(id)
                
                let data = ["id": id,
                            "name": item.name,
                            "brand": item.brand,
                            "url": item.url,
                            "photoUrl": item.photoUrl,
                            "type": item.type.rawValue,
                            "timestamp": item.timestamp] as [String : Any]
                print("data \(data)")
                
                clothingRef.setData(data)
                
                
            }
        }
    }
}
