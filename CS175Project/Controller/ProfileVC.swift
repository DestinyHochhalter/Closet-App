//
//  ViewController.swift
//  CS175Project
//
//  Created by Destiny Hochhalter Ruiz on 4/13/21.
//

import UIKit
import Foundation

class ProfileVC: UIViewController {

    // profile picture
    let profileImgVw: UIImageView = {
        let imgVw = UIImageView()
        imgVw.clipsToBounds = true
        imgVw.contentMode = .scaleAspectFit
        imgVw.layer.cornerRadius = 25//Padding.mediumIconSz/2 // make imgVw perfect circle
        imgVw.layer.borderColor = Color.darkText.cgColor
        imgVw.layer.borderWidth = 2
        imgVw.tintColor = Color.darkText
        imgVw.image = UIImage(named: "profile")
        imgVw.isUserInteractionEnabled = true
       // imgVw.image = 
        return imgVw
    }()
    
    // username label
    var userNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Avenir-Heavy", size: 18)
        lbl.textColor = Color.darkText
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textAlignment = NSTextAlignment.left
        lbl.minimumScaleFactor = 0.8
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    // plus icon
    let plusImgVw: UIImageView = {
        let imgVw = UIImageView()
        imgVw.clipsToBounds = true
        imgVw.contentMode = .scaleAspectFit
        imgVw.isUserInteractionEnabled = true
        imgVw.tintColor = Color.darkText
        imgVw.image = UIImage(named: "plus")?.pad(-20)
       // imgVw.backgroundColor = .red
        return imgVw
    }()
    
    // search icon
    let searchImgVw: UIImageView = {
        let imgVw = UIImageView()
        imgVw.clipsToBounds = true
        imgVw.contentMode = .scaleAspectFit
        imgVw.isUserInteractionEnabled = true
        imgVw.tintColor = Color.darkText
        imgVw.image = UIImage(named: "search")?.pad(-20)
       // imgVw.backgroundColor = .red
        return imgVw
    }()
    
    // more icon
    let moreImgVw: UIImageView = {
        let imgVw = UIImageView()
        imgVw.clipsToBounds = true
        imgVw.contentMode = .scaleAspectFit
        imgVw.isUserInteractionEnabled = true
        imgVw.tintColor = Color.darkText
        imgVw.image = UIImage(named: "more")?.pad(-20)
      //  imgVw.backgroundColor = .red
        return imgVw
    }()
    
    // seperator line under segmented control
    let seperatorView1: UIView = {
        let vw = UIView()
        vw.backgroundColor = Color.seperator
        return vw
    }()
    
    let seperatorView2: UIView = {
        let vw = UIView()
        vw.backgroundColor = Color.seperator
        return vw
    }()
    
    let seperatorView3: UIView = {
        let vw = UIView()
        vw.backgroundColor = Color.seperator
        return vw
    }()
    
    
    // line that denotes selected tab in segmented control
    let segmentedControlLine: UIView = {
        let vw = UIView()
        vw.backgroundColor = Color.darkText
        return vw
    }()
    
    // initially selected
    // closet icon for segmented control
    let closetIconImgVw: UIImageView = {
        let imgVw = UIImageView()
        imgVw.clipsToBounds = true
        imgVw.contentMode = .scaleAspectFit
       // imgVw.isUserInteractionEnabled = true
        imgVw.tintColor = Color.darkText
        imgVw.image = UIImage(named: "closet")
        return imgVw
    }()
    
    // initially unselected
    // collections icon for segmented control
    let collectionsIconImgVw: UIImageView = {
        let imgVw = UIImageView()
        imgVw.clipsToBounds = true
        imgVw.contentMode = .scaleAspectFit
       // imgVw.isUserInteractionEnabled = true
        imgVw.tintColor = Color.lightText
        imgVw.image = UIImage(named: "collections")
        return imgVw
    }()
    
    // line to show what is selected (closet or collections)
    var selectionLine: UIView = {
        let vw = UIView()
        vw.backgroundColor = Color.mediumText
        vw.layer.cornerRadius = 1
        return vw
    }()
    
    var selectionLineLeadingCon: NSLayoutConstraint?
    
    var followersVw: UIView = {
        let vw = UIView()
        vw.backgroundColor = .clear
        return vw
    }()
    
    var followingVw: UIView = {
        let vw = UIView()
        vw.backgroundColor = .clear
        return vw
    }()
    
     var followerCountLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Avenir-Heavy", size: 17)
        lbl.textColor = Color.darkText
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textAlignment = NSTextAlignment.center
        return lbl
    }()
    
    var followingCountLbl: UILabel = {
       let lbl = UILabel()
       lbl.font = UIFont(name: "Avenir-Heavy", size: 17)
       lbl.textColor = Color.darkText
       lbl.adjustsFontSizeToFitWidth = true
       lbl.textAlignment = NSTextAlignment.center
       return lbl
   }()
    
    var followingLbl: UILabel = {
       let lbl = UILabel()
       lbl.font = UIFont(name: "Avenir-Medium", size: 16)
       lbl.textColor = Color.mediumText
       lbl.adjustsFontSizeToFitWidth = true
        lbl.text = "following"
       lbl.textAlignment = NSTextAlignment.center
       return lbl
   }()
    
    var followersLbl: UILabel = {
       let lbl = UILabel()
       lbl.font = UIFont(name: "Avenir-Medium", size: 16)
       lbl.textColor = Color.mediumText
        lbl.text = "followers"
       lbl.adjustsFontSizeToFitWidth = true
       lbl.textAlignment = NSTextAlignment.center
       return lbl
   }()
    
    // custom segmeted control
    var closetVw: UIView = {
        let vw = UIView()
        vw.backgroundColor = .clear
        vw.isUserInteractionEnabled = true
        return vw
    }()
    
    var collectionsVw: UIView = {
        let vw = UIView()
        vw.backgroundColor = .clear
        vw.isUserInteractionEnabled = true
        return vw
    }()
    //
    
    
    // if viewing own profile, do not show 'follow'/'following' box
    // else show following status when viewing other profiles
    var isFollowing: Bool = false
    // FIXME
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.bg
        
        addLayout()
        setLabels()
        addGestures()
        
    }


}

