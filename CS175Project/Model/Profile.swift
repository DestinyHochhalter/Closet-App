//
//  Profile.swift
//  CS175Project
//
//  Created by Destiny Hochhalter Ruiz on 5/16/21.
//

import Foundation
import UIKit

final class Profile {
    var userID: String = ""
    var username: String = ""
    var profileImageUrl: String = ""
    var followerCount: Int = 0
    var followingCount: Int = 0
    
    convenience init(userID: String = "",
                     username: String = "",
                     profileImageUrl: String = "",
                     followerCount: Int = 0,
                     followingCount: Int = 0) {
        self.init()
        self.userID = userID
        self.username = username
        self.profileImageUrl = profileImageUrl
        self.followerCount = followerCount
        self.followingCount = followingCount
    }
    
}
