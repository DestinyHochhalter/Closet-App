//
//  Constants.swift
//  CS175Project
//
//  Created by Destiny Hochhalter Ruiz on 5/6/21.
//

import UIKit

enum Constants {
    enum Sizes {
        
        enum Height {
            static let topHeight: CGFloat = Constants.Sizes.ProfileHeader.headerVwHeight + Constants.Sizes.FollowVw.height + Constants.Sizes.SegmentedContol.height 
        }
        
        enum ProfileHeader {
            static let headerVwHeight: CGFloat = addPaddingForNotch(Padding.top) + Constants.Sizes.ImageSize.Profile.profileImgSize.height + Padding.separatorSpacing
        }
        
        enum FollowVw {
            static let height: CGFloat = 60//40
        }
        
        enum SegmentedContol {
            static let height: CGFloat = 40
            static let iconSize: CGSize = CGSize(width: 28, height: 28)
        }
        
        enum ImageSize {
            enum Profile {
                static let profileImgSize: CGSize = CGSize(width: 50, height: 50)
                static let smallIconSize: CGSize = CGSize(width: 60, height: 60) // search, add, more icons
            }
            
        }
        enum FilterOption {
            static let OptionHeight: CGFloat = 40
            static let Arrow: CGSize = CGSize(width: 50, height: 50)
            static let topSpace: CGFloat = 12
        }
    }
    enum Images {
        static let UpArrow = UIImage(named: "upArrow")!.pad(-16)
        static let Plus = UIImage(named: "plus")?.pad(-20)
        static let Search = UIImage(named: "search")?.pad(-20)
        static let More = UIImage(named: "more")?.pad(-20)
        static let Closet = UIImage(named: "closet")
        static let Collections = UIImage(named: "collections")
        
    }
}
