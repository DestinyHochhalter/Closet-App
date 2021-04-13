//
//  Funcs.swift
//  CS175Project
//
//  Created by Destiny Hochhalter Ruiz on 4/13/21.
//

import Foundation
import UIKit


// put task on main thread
func UI(_ block: @escaping () -> Void) {
    DispatchQueue.main.async(execute: block)
}

// put task on background thread
func BG(_ block: @escaping () -> Void) {
    DispatchQueue.global().async(execute: block)
}


func addHapticFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
    let generator = UIImpactFeedbackGenerator(style: style)
    generator.prepare()
    generator.impactOccurred()
}
