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

class Clothing {
    var name: String = "" // name of item from url
    var url: String  = "" // url item was purchsed from
    var photos: [String] = [] // all avaliable photos from url
    var type: [FilterOptionType] = []// clothing type, ex: 'tops', can be more than one type, ex: 'recent' & 'tops'
    var timestamp: TimeInterval = 0.0 // date item was uploaded
    
    convenience init(name: String = "",
                     url: String = "",
                     photos: [String] = [],
                     type: [FilterOptionType] = [.recent],
                     timestamp: TimeInterval = 0.0) {
        self.init()
        self.name = name
        self.url = url
        self.photos = photos
        self.type = type
        self.timestamp = timestamp
    }

}
