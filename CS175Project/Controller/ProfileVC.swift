//
//  ViewController.swift
//  CS175Project
//
//  Created by Destiny Hochhalter Ruiz on 4/13/21.
//

import UIKit

class ProfileVC: UIViewController {

    // profile picture
    let profileImgVw: UIImageView = {
        let imgVw = UIImageView()
        imgVw.clipsToBounds = true
        imgVw.contentMode = .scaleAspectFit
        imgVw.isUserInteractionEnabled = true
       // imgVw.image = 
        return imgVw
    }()
    
    // plus icon
    let plusImgVw: UIImageView = {
        let imgVw = UIImageView()
        imgVw.clipsToBounds = true
        imgVw.contentMode = .scaleAspectFit
        imgVw.isUserInteractionEnabled = true
        imgVw.tintColor = Color.darkText
        imgVw.image = UIImage(named: "plus")
        return imgVw
    }()
    
    // search icon
    let searchImgVw: UIImageView = {
        let imgVw = UIImageView()
        imgVw.clipsToBounds = true
        imgVw.contentMode = .scaleAspectFit
        imgVw.isUserInteractionEnabled = true
        imgVw.tintColor = Color.darkText
        imgVw.image = UIImage(named: "search")
        return imgVw
    }()
    
    // more icon
    let moreImgVw: UIImageView = {
        let imgVw = UIImageView()
        imgVw.clipsToBounds = true
        imgVw.contentMode = .scaleAspectFit
        imgVw.isUserInteractionEnabled = true
        imgVw.tintColor = Color.darkText
        imgVw.image = UIImage(named: "more")
        return imgVw
    }()
    
    // seperator line under segmented control
    let seperatorView: UIView = {
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
        imgVw.isUserInteractionEnabled = true
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
        imgVw.isUserInteractionEnabled = true
        imgVw.tintColor = Color.lightText
        imgVw.image = UIImage(named: "collections")
        return imgVw
    }()
    
    
    
    
    
    
    private var usernameLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Avenir-Medium", size: 17)
        lbl.textColor = Color.darkText
        //lbl.text = ""
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textAlignment = NSTextAlignment.center
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.bg
        
    }


}

