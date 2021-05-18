//
//  ClothingCollection.swift
//  CS175Project
//
//  Created by Destiny Hochhalter Ruiz on 5/16/21.
//

import Foundation
import UIKit

class ClothingCollection {
    var name: String = "" // name of collection
    var items: [ClothingItem] = [] // array of clothing items
    var timestamp: TimeInterval = 0.0 // date collection was made
    
    convenience init(name: String = "",
                     items: [ClothingItem] = [],
                     timestamp: TimeInterval = 0.0) {
        self.init()
        self.name = name
        self.items = items
        self.timestamp = timestamp
    }
    
}
