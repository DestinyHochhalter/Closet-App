//
//  TabVC.swift
//  CS175Project
//
//  Created by Destiny Hochhalter Ruiz on 4/30/21.
//

import Foundation
import UIKit

class TabVC: UITabBarController {
    
    enum ItemTag: Int {
        case profileVC = 0
        case exploreVC = 1
    }
    
    var profileImgVw: UIImageView!
    var exploreImgVw: UIImageView!


    override func viewDidAppear(_ animated: Bool) {
        addIconStyling()
    }
    
    override func viewDidLoad() {
        addIconStyling()
        setupIcons()
        handleImgVws()
    }
    
    func handleImgVws() {
        
        let profileVw = tabBar.subviews.first!
        profileImgVw = profileVw.subviews.first as? UIImageView
        profileImgVw.contentMode = .center
        
        let exploreVw = tabBar.subviews[1]
        exploreImgVw = exploreVw.subviews.first as? UIImageView
        exploreImgVw.contentMode = .center

    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let itemTag = ItemTag(rawValue: item.tag) else {
            return
        }
        switch itemTag {
        
        case .profileVC:
            profileImgVw.pulseImg(scale: 1.1, duration: 0.35, completion: nil)
            currentVC = .profile
            
        case .exploreVC:
            exploreImgVw.pulseImg(scale: 1.1, duration: 0.35, completion: nil)
            currentVC = .explore
        }
        addIconStyling()
    }
    
   
    
    
    public func addIconStyling() {
        if #available(iOS 10, *) {
            self.tabBar.isTranslucent = false
            UITabBar.appearance().layer.borderWidth = 0.0
            UITabBar.appearance().clipsToBounds = true
            tabBar.unselectedItemTintColor = Color.lightText // unselected item
            tabBar.barTintColor = Color.bg // bar color
            tabBar.tintColor = Color.darkText // selected

        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        addIconStyling()
    }
    
    
    func setupIcons() {
        let exploreVC = UINavigationController(rootViewController: ExploreVC())
        exploreVC.navigationBar.isHidden = true
        exploreVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named:"explore"), tag: 0)
        exploreVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -10, right: 0)

        
        let profileVC = UINavigationController(rootViewController: ProfileVC())
        profileVC.navigationBar.isHidden = true
        profileVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named:"profile"), tag: 1)
        profileVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -10, right: 0)
        
        
        let tabBarList = [exploreVC, profileVC]
        viewControllers = tabBarList
    }
}
