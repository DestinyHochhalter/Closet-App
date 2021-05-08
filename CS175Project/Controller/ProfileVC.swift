//
//  ViewController.swift
//  CS175Project
//
//  Created by Destiny Hochhalter Ruiz on 4/13/21.
//

import UIKit
import Foundation

class ProfileVC: UIViewController {
    
    
    // MARK: - Header View
    //--------------------
    
    // container view for profile image, username, icons
    let headerVw: UIView = {
        let vw = UIView()
        vw.backgroundColor = Color.bg
        vw.isUserInteractionEnabled = true
        return vw
    }()
    
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
        imgVw.image = Constants.Images.Plus
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
        imgVw.image = Constants.Images.Search
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
        imgVw.image = Constants.Images.More
      //  imgVw.backgroundColor = .red
        return imgVw
    }()
    
    // separator line under segmented control
    let separatorView1: UIView = {
        let vw = UIView()
        vw.backgroundColor = Color.separator
        return vw
    }()
    
    
    
    // MARK: - Followers View
    //-----------------------
    
    // container vw
    let followVw: UIView = {
        let vw = UIView()
        vw.backgroundColor = Color.bg
        vw.isUserInteractionEnabled = true
        return vw
    }()
    
    // container view for followers label and count
    var followersVw: UIView = {
        let vw = UIView()
        vw.backgroundColor = .clear
        return vw
    }()
    
    var followersCountLbl: UILabel = {
       let lbl = UILabel()
       lbl.font = UIFont(name: "Avenir-Heavy", size: 17)
       lbl.textColor = Color.darkText
       lbl.adjustsFontSizeToFitWidth = true
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
    
    
    var followingVw: UIView = {
        let vw = UIView()
        vw.backgroundColor = .clear
        return vw
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
    

    let separatorView2: UIView = {
        let vw = UIView()
        vw.backgroundColor = Color.separator
        return vw
    }()
    
    
    
    // MARK: - Segmented Control View
    //-------------------------------
    
    let segmentedControlVw: UIView = {
        let vw = UIView()
        vw.backgroundColor = Color.bg
        vw.isUserInteractionEnabled = true
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
        imgVw.image = Constants.Images.Closet
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
        imgVw.image = Constants.Images.Collections
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
    
    
    let separatorView3: UIView = {
        let vw = UIView()
        vw.backgroundColor = Color.separator
        return vw
    }()
    
    
    // MARK: - Filter View
    //--------------------
    // list options: Recent, Tops, Bottoms, Accessories, Outwear, Footwear
    let filterOptionArr: [FilterOption] = [FilterOption(type: FilterOptionType.recent, order: 0, isSelected: true),
                                     FilterOption(type: FilterOptionType.tops, order: 1, isSelected: false),
                                     FilterOption(type: FilterOptionType.bottoms, order: 2, isSelected: false),
                                     FilterOption(type: FilterOptionType.accessories, order: 3, isSelected: false),
                                     FilterOption(type: FilterOptionType.outwear, order: 4, isSelected: false),
                                     FilterOption(type: FilterOptionType.footwear, order: 5, isSelected: false)]
    
    
    let filterTable: UITableView = {
        let vw = UITableView()
        vw.allowsSelection = false
        vw.separatorStyle = .none//.singleLine
      //  vw.separatorInset = .zero
       // vw.separatorColor = Color.separator
        vw.backgroundColor = Color.bg//UIColor.blue.withAlphaComponent(0.1)
        return vw
    }()
    
    // goes over the collection view, under the filterTable
    let collectionLoadingView: UIView = {
        let vw = UIView()
        vw.backgroundColor = Color.bg//UIColor.red.withAlphaComponent(0.1)
        return vw
    }()
    
    // Holds selected filter option
    let selectedFilterOptionVw: UIView = {
        let vw = UIView()
        vw.backgroundColor = Color.bg
        return vw
    }()
    
    let selectedFilterOptionLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Avenir-Medium", size: 17)
        lbl.textColor = Color.mediumText
        lbl.numberOfLines = 1
        lbl.textAlignment = NSTextAlignment.left
        return lbl
    }()
    
    let selectedFilterOptionArrow: UIImageView = {
        let vw = UIImageView()
        vw.tintColor = .black
        vw.image = Constants.Images.UpArrow
        vw.tintColor = Color.mediumText
        vw.isUserInteractionEnabled = true
        vw.contentMode = .scaleAspectFit
        return vw
    }()
    
    var filterTableTopCon: NSLayoutConstraint?
    //--------------------

    
    
    
    // if viewing own profile, do not show 'follow'/'following' box
    // else show following status when viewing other profiles
    var isFollowing: Bool = false
    // FIXME
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.bg
        
        setLabels()
        addGestures()
        
        addLayout()
        setupFilterTable()
    }
    
    func setupFilterTable() {
        filterTable.register(FilterOptionCell.self, forCellReuseIdentifier: FilterOptionCell.id)
        filterTable.delegate = self
        filterTable.dataSource = self
        // hide line on bottom of table view
        filterTable.tableFooterView = UIView()
    }


}

