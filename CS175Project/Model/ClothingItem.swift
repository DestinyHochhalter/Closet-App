//
//  Clothing.swift
//  CS175Project
//
//  Created by Destiny Hochhalter Ruiz on 5/7/21.
//

import Foundation
import UIKit

// Class for a Clothing Object
// ex: Chanel Clutch
//     https:chanel.com
//     [photos]
//     accessories
//     0123456789 (timestamp)

class ClothingItem {
    var name: String = "" // name of item from url
    var brand: String = "" // brand name
    var url: String  = "" // url item was purchsed from
    var photoUrl: String = "" // all avaliable photos from url
    var type: FilterOptionType = .recent// clothing type, ex: 'tops', can be more than one type, ex: 'recent' & 'tops'
    var timestamp: TimeInterval = 0.0 // date item was uploaded
    
    convenience init(name: String = "",
                     brand: String = "",
                     url: String = "",
                     photoUrl: String = "",
                     type: FilterOptionType = .recent,
                     timestamp: TimeInterval = 0.0) {
        self.init()
        self.name = name
        self.brand = brand
        self.url = url
        self.photoUrl = photoUrl
        self.type = type
        self.timestamp = timestamp
    }

}
