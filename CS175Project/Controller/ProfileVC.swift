//
//  ViewController.swift
//  CS175Project
//
//  Created by Destiny Hochhalter Ruiz on 4/13/21.
//

import UIKit
import Foundation
import FirebaseFirestore
import FirebaseAuth

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
        imgVw.contentMode = .scaleAspectFill
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

    // MARK: - Grid Collection View
    
    // animate top constraint of grid vw to move up and down
    var gridCollectionTopCon: NSLayoutConstraint?
    
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    let dropShadowTopVw: UIImageView = {
        let vw = UIImageView()
        vw.image = Constants.Images.DropShadowTop
        vw.contentMode = .scaleAspectFit
        vw.tintColor = Color.mediumText
        return vw
    }()
    
    let dropShadowBottomVw: UIView = {
        let vw = UIImageView()
        vw.image = Constants.Images.DropShadowBottom
        vw.contentMode = .scaleAspectFit
        vw.tintColor = Color.mediumText
        return vw
    }()
    
    var gridCollectionVw: VerticalCollectionView = {
        let vw = VerticalCollectionView()
        vw.isPagingEnabled = true
        vw.backgroundColor = Color.bg
        vw.isScrollEnabled = true
        vw.isUserInteractionEnabled = true
        vw.showsVerticalScrollIndicator = false
        return vw
    }()
    
    // FIXME
    
    var clothingArr: [ClothingItem] = [ClothingItem(name: "Mesh Pocket Shell Jacket Blue", brand: "PALACE", url: "https://shop-usa.palaceskateboards.com/products/s2ghxxjwfla7", photoUrl: "https://cdn.shopify.com/s/files/1/0923/4190/products/Palace_Spring_jacket_mesh_blue_2994-1_2e8d7b0b-fbef-46c0-833d-54e4f249a474_640x@2x.jpg?v=1620913942", type: .outwear), ClothingItem(name: "Engineer T-Shirt", brand: "Palace", url: "https://shop-usa.palaceskateboards.com/products/1c6f4l153k15", photoUrl: "https://cdn.shopify.com/s/files/1/0923/4190/products/Palace-T-shirt-stripe-blue-0873_39395d63-1424-4d58-92a3-1012ac228f0a_640x@2x.jpg?v=1618824563", type: .tops), ClothingItem(name: "Sofar Shell Shorts Lilac", brand: "Palace", url: "https://shop-usa.palaceskateboards.com/products/mkeobt1lqby8", photoUrl: "https://cdn.shopify.com/s/files/1/0923/4190/products/Palace_Spring_short_sofar_lilac_2746_640x@2x.jpg?v=1621589685", type: .bottoms), ClothingItem(name: "Basically A 6-Panel Lilac", brand: "Palace", url: "https://shop-usa.palaceskateboards.com/products/y8fcve9e1w75", photoUrl: "https://cdn.shopify.com/s/files/1/0923/4190/products/palace_ss_21_cap_6_panel_basically_purple_1946_640x@2x.jpg?v=1620376973", type: .accessories), ClothingItem(name: "Palace Crocs Camo", brand: "Palace", url: "https://shop-usa.palaceskateboards.com/products/bo7w6ijpbzuu", photoUrl: "https://cdn.shopify.com/s/files/1/0923/4190/products/palace_summer_21_amg_jkt_1180_640x@2x.jpg?v=1620312885", type: .footwear), ClothingItem(name: "SYSTEM LOGO TEE GREY", brand: "momformal", url: "https://shop.momformal.com/product/system-logo-tee-grey", photoUrl: "https://assets.bigcartel.com/product_images/297187221/3E7A8E8D-1692-451A-98D2-B8CD6191D8F7.jpeg?auto=format&fit=max&w=2000", type: .tops), ClothingItem(name: "Stitch Up Shell Shorts Green/Blue", brand: "Palace", url: "https://shop-usa.palaceskateboards.com/products/ec2cl30nrixg", photoUrl: "https://cdn.shopify.com/s/files/1/0923/4190/products/Palace_Spring_short_stitch_up_grn_navy_2756_2b0c0065-5ec4-48d7-83a4-e1acd07174e2_640x@2x.jpg?v=1620330061", type: .bottoms), ClothingItem(name: "Square Patch Joggers Black", brand: "Palace", url: "https://shop-usa.palaceskateboards.com/products/y8lzxgsjelgd", photoUrl: "https://cdn.shopify.com/s/files/1/0923/4190/products/palace-ss-21-jogger-blk-0381_641a8ec0-f5fd-4c4c-b18d-3d4356b45513_640x@2x.jpg?v=1620395896", type: .bottoms), ClothingItem(name: "S/S Pocket Tee", brand: "Supreme", url: "https://www.supremenewyork.com/shop/tops-sweaters/s8zjgpsq6/gpmuxrlte", photoUrl: "https://assets.supremenewyork.com/206461/ma/nzMmaOPXIp4.jpg", type: .tops), ClothingItem(name: "Waist bag", brand: "Supreme", url: "https://www.supremenewyork.com/shop/bags/g6iqufywr/uxb0tlhki", photoUrl: "https://assets.supremenewyork.com/207190/ma/q4VjvpOgyH8.jpg", type: .accessories), ClothingItem(name: "OG Puffer Jacket", brand: "Girl", url: "https://crailstore.com/products/w41-d1-girl-og-puffer-jacket/#filter:brand=girl", photoUrl: "https://cdn.shopify.com/s/files/1/0208/0114/products/og-puffer-jacket_1_001_1024x1024.jpg?v=1616661820", type: .outwear), ClothingItem(name: "Tangled Tee", brand: "Girl", url: "https://crailstore.com/products/w40-d3-girl-tangled-tee/#filter:brand=girl", photoUrl: "https://cdn.shopify.com/s/files/1/0208/0114/products/tangled-tee_2_007_1024x1024.jpg?v=1611736170", type: .tops)]
    
    var collectionsArr: [ClothingItem] = [ClothingItem(name: "Engineer T-Shirt", brand: "Palace", url: "https://shop-usa.palaceskateboards.com/products/1c6f4l153k15", photoUrl: "https://cdn.shopify.com/s/files/1/0923/4190/products/Palace-T-shirt-stripe-blue-0873_39395d63-1424-4d58-92a3-1012ac228f0a_640x@2x.jpg?v=1618824563", type: .tops), ClothingItem(name: "Stitch Up Shell Shorts Green/Blue", brand: "Palace", url: "https://shop-usa.palaceskateboards.com/products/ec2cl30nrixg", photoUrl: "https://cdn.shopify.com/s/files/1/0923/4190/products/Palace_Spring_short_stitch_up_grn_navy_2756_2b0c0065-5ec4-48d7-83a4-e1acd07174e2_640x@2x.jpg?v=1620330061", type: .bottoms), ClothingItem(name: "Palace Crocs Camo", brand: "Palace", url: "https://shop-usa.palaceskateboards.com/products/bo7w6ijpbzuu", photoUrl: "https://cdn.shopify.com/s/files/1/0923/4190/products/palace_summer_21_amg_jkt_1180_640x@2x.jpg?v=1620312885", type: .footwear)]
    
    // MARK: - Clothing Collections
    let clothingCollectionsTable: UITableView = {
        let vw = UITableView()
        vw.allowsSelection = false
        vw.separatorStyle = .none
        vw.backgroundColor = Color.bg
        vw.isHidden = true
        return vw
    }()
    
    // MARK: - Datasources for ProfileVC
    var closetDict = [String: ClothingItem]() // id : Object
    var filteredClosetDict = [String: ClothingItem]()
    var collection = ClothingCollection(name: "Spring Fashion")
    
  //  var collections: [ClothingCollection] = []

    
    // if viewing own profile, do not show 'follow'/'following' box
    // else show following status when viewing other profiles
    var isFollowing: Bool = false
    // FIXME
    var db: Firestore?
    var listener: CollectionReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.bg
        
        db = Firestore.firestore()
        addGestures()
        
        addLayout()
        setupFilterTable()
        setupGridCollection()
        setupClothingCollectionsTable()
        
        
        // Add Firestore Listeners
        setFirestoreProfileListener()
        setFirestoreClosetListener()
        setFirestoreCollectionsListener()
        
       // addCollectionsItems(collectionsArr)
       // addCollectionsRef(collectionsArr)
       // addClosetItems(arr: clothingArr)
    }
    
    func setupFilterTable() {
        filterTable.register(FilterOptionCell.self, forCellReuseIdentifier: FilterOptionCell.id)
        filterTable.delegate = self
        filterTable.dataSource = self
        // hide line on bottom of table view
        filterTable.tableFooterView = UIView()
    }

    func setupGridCollection() {
        //layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        //gridCollectionVw.setCollectionViewLayout(layout, animated: true)
        gridCollectionVw.register(ClothingItemCell.self, forCellWithReuseIdentifier: ClothingItemCell.id)
        gridCollectionVw.delegate = self
        gridCollectionVw.dataSource = self
        gridCollectionVw.reloadData()
    }
    
    func setupClothingCollectionsTable() {
        clothingCollectionsTable.register(ClothingCollectionsCell.self,forCellReuseIdentifier: ClothingCollectionsCell.id)
        clothingCollectionsTable.delegate = self
        clothingCollectionsTable.dataSource = self
       //collection.append(ClothingCollection(name: "Favorites", items: clothingArr, timestamp: 0.0))
        clothingCollectionsTable.reloadData()
        
        
    }

}

