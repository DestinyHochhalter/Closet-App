//
//  Extensions.swift
//  CS175Project
//
//  Created by Destiny Hochhalter Ruiz on 5/4/21.
//

import Foundation
import UIKit

extension UIImageView {

        func pulseImg(scale: CGFloat, duration: TimeInterval, completion: ((Bool) -> Void)?) {
            UIView.animate(withDuration: duration/2, delay: 0, options: .curveLinear, animations: {
                self.transform = CGAffineTransform(scaleX: scale, y: scale)
            }) { (_) in
                UIView.animate(withDuration: duration/2, delay: 0, options: .curveLinear, animations: {
                    self.transform = CGAffineTransform.identity
                }, completion:  completion)
            }
        }
    }

extension UIImage {
    
    func inset(t: CGFloat = 0, b: CGFloat = 0, l: CGFloat = 0, r: CGFloat = 0) -> UIImage {
        return self.withAlignmentRectInsets(UIEdgeInsets(top: t, left: l, bottom: b, right: r))
    }
    
    // add padding to image within view
    // so that tap targets reamin large while icon is smaller
    func pad(_ val: CGFloat) -> UIImage {
        return self.withAlignmentRectInsets(UIEdgeInsets(top: val, left: val, bottom: val, right: val))
    }
}
