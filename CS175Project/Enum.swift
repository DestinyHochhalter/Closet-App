//
//  Enum.swift
//  CS175Project
//
//  Created by Destiny Hochhalter Ruiz on 4/30/21.
//

import Foundation
import ChameleonFramework


enum Color {
    static let bg = UIColor(hexString: "#FCFCF9")!
    static let darkText = UIColor(hexString: "#212934")!
    static let seperator = UIColor(hexString: "#F4F4F1")!
    static let lightText = UIColor(hexString: "#C5C7C8")!
}

enum VC: String {
    case profile = "ProfileVC"
    case explore = "ExploreVC"
}

var currentVC: VC = .profile



enum Padding {
    static let leading: CGFloat = 10
    static let traling: CGFloat = 10
    static let zero: CGFloat = 0
    
    // profile image
    static let profileImgSz: CGFloat = 50
    
    // search, add, more icons
    static let iconSz: CGFloat = 15
    
    // closet and collections icons
    static let mediumIconSz: CGFloat = 30
    
    static let seperatorHeight: CGFloat = 1
    
    
    
    
}
