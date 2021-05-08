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
    static let mediumText = UIColor(hexString: "#212934")!.withAlphaComponent(0.85)
    static let separator = UIColor(hexString: "#F4F4F1")!
    static let lightText = UIColor(hexString: "#C5C7C8")!
}

enum VC: String {
    case profile = "ProfileVC"
    case explore = "ExploreVC"
}

var currentVC: VC = .profile



enum Padding {
    // Padding for entire app - keep layout consistent
    static let leading: CGFloat = 16
    static let traling: CGFloat = 16
    static let zero: CGFloat = 0
    static let top: CGFloat = 50
    
    // selection line for segmented control
    static let selectionLineWidth: CGFloat = 70
    static let selectionLineHeight: CGFloat = 2
    
    static let separatorHeight: CGFloat = 1.5
    
    static let iconSpacing: CGFloat = 40
    
    static let separatorSpacing: CGFloat = 6//10
    
    static let followVwHeight: CGFloat = 60
    
    static let followSpacing: CGFloat = 0
    

}


enum iPhoneSizes {
    enum X_12_Pro {
        static let Size: CGSize = CGSize(width: 390, height: 844)
        static let StatusBar: CGFloat = 20.0
    }
    enum X_12_Pro_Max {
        static let Size: CGSize = CGSize(width: 428, height: 926)
        static let StatusBar: CGFloat = 20.0
    }
    enum XS_XR_MAX {
        static let Size: CGSize = CGSize(width: 414, height: 896)
        static let StatusBar: CGFloat = 20.0
    }
    enum X_XS {
        static let Size: CGSize = CGSize(width: 375, height: 812)
        static let StatusBar: CGFloat = 20.0
    }
    enum _678Plus {
        static let Size: CGSize = CGSize(width: 414, height: 736)
    }
    enum _678 {
        static let Size: CGSize = CGSize(width: 375, height: 667)
    }
    enum SE {
        static let Size: CGSize = CGSize(width: 320, height: 568)
    }
}

func isIphoneX() -> Bool {
    switch  UIScreen.main.bounds.size {
    case iPhoneSizes.X_XS.Size, iPhoneSizes.XS_XR_MAX.Size, iPhoneSizes.X_12_Pro.Size, iPhoneSizes.X_12_Pro_Max.Size:
        return true
    default:
        return false
    }
}


enum FilterOptionType: String {
    
    case recent = "Recent"
    case tops = "Tops"
    case bottoms = "Bottoms"
    case accessories = "Accessories"
    case outwear = "Outwear"
    case footwear = "Footwear"
    
}


class FilterOption {
    var type: FilterOptionType = .recent
    var order: Int = 0
    var isSelected: Bool = false
    
    init(type: FilterOptionType = .recent, order: Int = 0, isSelected: Bool = false) {
        self.type = type
        self.order = order
        self.isSelected = isSelected
    }
}

// define functions for arrays of type FilterOption
extension Array where Element == FilterOption {
    
    // make given type selected
    // unselect all other types
    func setSelected(type: FilterOptionType) {
        for x in self {
            if x.type == type {
                x.isSelected = true
            } else {
                x.isSelected = false
            }
        }
    }

    
    // unselected is the data set to populate table view (only show unselected)
    // selected will be used for top label (selected option)
    func getSelectedAndUnselectedOptions() -> (unselected: [FilterOption], selected: FilterOption?) {
        
        let unselectedOptions = self.filter{$0.isSelected == false}.compactMap{$0}
        let selectedOption = self.filter{$0.isSelected == true}.first ?? nil
        
        return (unselectedOptions, selectedOption)
    }
}
