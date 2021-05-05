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

func PAUSE(duration: TimeInterval, block: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration, execute: block)
}


func addHapticFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
    let generator = UIImpactFeedbackGenerator(style: style)
    generator.prepare()
    generator.impactOccurred()
}


//custom auto layout functions
extension UIView {

    private func prepareForConstraints(with parentFrame: CGRect, in parentVw: UIView) {
        self.frame = parentFrame
        parentVw.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addLayout(parentVw: UIView, leading: (anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, con: CGFloat)? = nil, trailing: (anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, con: CGFloat)? = nil, top: (anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, con: CGFloat)? = nil, bottom: (anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, con: CGFloat)? = nil, horiz: NSLayoutAnchor<NSLayoutXAxisAnchor>? = nil, vert: NSLayoutAnchor<NSLayoutYAxisAnchor>? = nil, height: CGFloat? = nil, width: CGFloat? = nil) {
        
        prepareForConstraints(with: parentVw.frame, in: parentVw)
        
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading.anchor, constant: leading.con).isActive = true
        }
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing.anchor, constant: trailing.con).isActive = true
        }
        if let top = top {
            self.topAnchor.constraint(equalTo: top.anchor, constant: top.con).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom.anchor, constant: bottom.con).isActive = true
        }
        if let horiz = horiz {
            self.centerXAnchor.constraint(equalTo: horiz).isActive = true
        }
        if let vert = vert {
            self.centerYAnchor.constraint(equalTo: vert).isActive = true
        }
        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
    
    func fill(_ parentVw: UIView, top: CGFloat = 0, bottom: CGFloat = 0, lead: CGFloat = 0, trail: CGFloat = 0) {
        
        self.frame = parentVw.frame
        parentVw.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.topAnchor.constraint(equalTo: parentVw.topAnchor, constant: top).isActive = true
        self.bottomAnchor.constraint(equalTo: parentVw.bottomAnchor, constant: bottom).isActive = true
        self.leadingAnchor.constraint(equalTo: parentVw.leadingAnchor, constant: lead).isActive = true
        self.trailingAnchor.constraint(equalTo: parentVw.trailingAnchor, constant: trail).isActive = true
    }
    
    func fillSuperview(_ parentVw: UIView, top: CGFloat = 0, bottom: CGFloat = 0, lead: CGFloat = 0, trail: CGFloat = 0) {
        
        self.frame = parentVw.frame
        parentVw.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.topAnchor.constraint(equalTo: parentVw.superview?.topAnchor ?? parentVw.topAnchor, constant: top).isActive = true
        self.bottomAnchor.constraint(equalTo: parentVw.superview?.bottomAnchor ?? parentVw.bottomAnchor, constant: bottom).isActive = true
        self.leadingAnchor.constraint(equalTo: parentVw.leadingAnchor, constant: lead).isActive = true
        self.trailingAnchor.constraint(equalTo: parentVw.trailingAnchor, constant: trail).isActive = true
    }
    
}

