//
//  ExploreVC.swift
//  CS175Project
//
//  Created by Destiny Hochhalter Ruiz on 5/4/21.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseAuth


class ExploreVC: UIViewController {
    
    // MARK: - Top Segmented Contol: Home and Shop
    
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
    // home icon for segmented control
    let homeIconImgVw: UIImageView = {
        let imgVw = UIImageView()
        imgVw.clipsToBounds = true
        imgVw.contentMode = .scaleAspectFit
        imgVw.tintColor = Color.darkText
        imgVw.image = Constants.Images.Home
        return imgVw
    }()
    
    // initially unselected
    // shop icon for segmented control
    let shopIconImgVw: UIImageView = {
        let imgVw = UIImageView()
        imgVw.clipsToBounds = true
        imgVw.contentMode = .scaleAspectFit
        imgVw.tintColor = Color.lightText
        imgVw.image = Constants.Images.Shop
        return imgVw
    }()
    
    // line to show what is selected (home or shop)
    var selectionLine: UIView = {
        let vw = UIView()
        vw.backgroundColor = Color.mediumText
        vw.layer.cornerRadius = 1
        return vw
    }()
    
    var selectionLineLeadingCon: NSLayoutConstraint?
    
    // custom segmeted control
    var homeVw: UIView = {
        let vw = UIView()
        vw.backgroundColor = .clear
        vw.isUserInteractionEnabled = true
        return vw
    }()
    
    var shopVw: UIView = {
        let vw = UIView()
        vw.backgroundColor = .clear
        vw.isUserInteractionEnabled = true
        return vw
    }()
    
    
    let separatorView1: UIView = {
        let vw = UIView()
        vw.backgroundColor = Color.separator
        return vw
    }()
    
    // MARK: - Search Text Field
    
    let searchFieldContainer: UIView = {
        let vw = UIView()
        vw.isUserInteractionEnabled = true
        vw.backgroundColor = .clear
        return vw
    }()
    let searchTextField: UITextField = {
        let width: CGFloat = UIScreen.main.bounds.width - 100
        let field = UITextField(frame: CGRect(x: 20, y: 100, width: width, height: 50))
        field.backgroundColor = .clear
        field.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: Color.lightText])
        field.font = UIFont(name: "Avenir-Medium", size: 17)
        field.textColor = Color.darkText
        field.tintColor = Color.mediumText
        field.autocorrectionType = UITextAutocorrectionType.yes
        field.keyboardType = UIKeyboardType.default
        field.returnKeyType = UIReturnKeyType.done
        field.clearButtonMode = UITextField.ViewMode.whileEditing
        field.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        field.autocapitalizationType = UITextAutocapitalizationType.none
        return field
    }()
    
    // search icon
    let searchImgVw: UIImageView = {
        let imgVw = UIImageView()
        imgVw.clipsToBounds = true
        imgVw.contentMode = .scaleAspectFit
        imgVw.isUserInteractionEnabled = true
        imgVw.tintColor = Color.lightText
        imgVw.image = Constants.Images.Search
        return imgVw
    }()
    
    let separatorView2: UIView = {
        let vw = UIView()
        vw.backgroundColor = Color.separator
        return vw
    }()
    
    // MARK: - Explore Collection View
    
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    var exploreCollectionVw: VerticalCollectionView = {
        let vw = VerticalCollectionView()
        vw.isPagingEnabled = true
        vw.backgroundColor = Color.bg
        vw.isScrollEnabled = true
        vw.isUserInteractionEnabled = true
        vw.showsVerticalScrollIndicator = false
        return vw
    }()
    
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
    
    // MARK:- Datasource for Explore Page
    
    var shopArr: [ClothingItem] = [ClothingItem(name: "Dickies '67 Slim Fit Straight Leg Work Pants, Dark Navy", brand: "Dickies", url: "https://www.dickies.com/pants/dickies-67-slim-fit-straight-leg-work-pants/WP894.html?dwvar_WP894_color=DN#start=1", photoUrl: "https://www.dickies.com/dw/image/v2/AAYI_PRD/on/demandware.static/-/Sites-master-catalog-dickies/default/dw95658a96/images/main/WP894_DN_FR.jpg?sw=1563&sh=2000&sm=fit", type: .bottoms), ClothingItem(name: "VANS SLIP-ON PRO SHOES", brand: "Vans", url: "https://www.tactics.com/vans/slip-on-pro-shoes/oatmeal-gum", photoUrl: "https://www.tactics.com/a/cl35/2/2.jpg", type: .footwear), ClothingItem(name: "VANS X PARKS PROJECT WAS HERE T-SHIRT", brand: "Vans", url: "https://www.vans.com/shop/mens-clothes/vans-x-parks-project-was-here-t-shirt-grape-leaf", photoUrl: "https://images.vans.com/is/image/Vans/OPDKCZ-HERO?$51x51$", type: .tops), ClothingItem(name: "CHECKERBOARD SLIP-ON", brand: "", url: "https://www.vans.com/shop/checkerboard-slip-on-black-off-white-check?recs=grid-vlp", photoUrl: "https://images.vans.com/is/image/Vans/EYEBWW-HERO?$51x51$", type: .footwear), ClothingItem(name: "AUTUMN FACES T-SHIRT", brand: "Autumn", url: "https://www.tactics.com/autumn/faces-t-shirt/white", photoUrl: "https://www.tactics.com/a/ctgo/9/autumn-faces-t-shirt-white.jpg", type: .tops), ClothingItem(name: "Dickies 874 Straight Pant", brand: "Dickies", url: "https://www.urbanoutfitters.com/shop/dickies-874-straight-pant?category=skate-clothes-shoes&color=044&type=REGULAR&quantity=1", photoUrl: "https://s7d5.scene7.com/is/image/UrbanOutfitters/47061072_044_b?$xlarge$&fit=constrain&qlt=80&wid=1314", type: .bottoms), ClothingItem(name: "UO Big Corduroy Work Shirt", brand: "Urban Outfitters", url: "https://www.urbanoutfitters.com/shop/uo-big-corduroy-work-shirt?category=mens-clothing&color=034&type=REGULAR&quantity=1", photoUrl: "https://s7d5.scene7.com/is/image/UrbanOutfitters/55150924_034_d?$xlarge$&fit=constrain&qlt=80&wid=1314", type: .tops), ClothingItem(name: "Converse Chuck 70 Low Top Sneaker", brand: "Converse", url: "https://www.urbanoutfitters.com/shop/converse-chuck-70-low-top-sneaker6?category=mens-clothing&color=012&type=REGULAR&quantity=1", photoUrl: "https://s7d5.scene7.com/is/image/UrbanOutfitters/60150950_012_b?$xlarge$&fit=constrain&qlt=80&wid=1314", type: .footwear), ClothingItem(name: "Nike World Tour Sweat Short", brand: "Nike", url: "https://www.urbanoutfitters.com/shop/nike-world-tour-sweat-short?category=mens-clothing&color=034&type=REGULAR&quantity=1", photoUrl: "https://s7d5.scene7.com/is/image/UrbanOutfitters/58981176_034_b?$xlarge$&fit=constrain&qlt=80&wid=1314", type: .bottoms)]
    
    var exploreArr: [ClothingItem] = [ClothingItem(name: "Pluto [Sand] Midweight Tee", brand: "Quasi", url: "https://quasiskateboards.com/collections/frontpage/products/pluto-sand", photoUrl: "https://cdn.shopify.com/s/files/1/0705/2433/products/PLUTOSAND_1024x1024.jpg?v=1618597043", type: .tops), ClothingItem(name: "Fatigue Pant [Charcoal]", brand: "Quasi", url: "https://quasiskateboards.com/collections/frontpage/products/fatigue-pant-charcoal", photoUrl: "https://cdn.shopify.com/s/files/1/0705/2433/products/FATIGUE_PANT_1024x1024.jpg?v=1571850660", type: .bottoms), ClothingItem(name: "Nike Air Force 1 '07", brand: "Nike", url: "https://www.nike.com/t/air-force-1-07-mens-shoe-5QFp5Z/CW2288-111", photoUrl: "https://static.nike.com/a/images/t_PDP_864_v1/f_auto,b_rgb:f5f5f5/4f37fca8-6bce-43e7-ad07-f57ae3c13142/air-force-1-07-mens-shoe-5QFp5Z.png", type: .footwear), ClothingItem(name: "Blaze [Black] Midweight Tee", brand: "Quasi", url: "https://quasiskateboards.com/collections/frontpage/products/blaze-black", photoUrl: "https://cdn.shopify.com/s/files/1/0705/2433/products/BLAZEBLACK_1024x1024.jpg?v=1606192734", type: .tops), ClothingItem(name: "Friend [Black] Midweight Tee", brand: "Quasi", url: "https://quasiskateboards.com/collections/frontpage/products/friend-black", photoUrl: "https://cdn.shopify.com/s/files/1/0705/2433/products/FRIEND_1024x1024.jpg?v=1618596939", type: .tops), ClothingItem(name: "Canvas Plain Pant Desert Camo", brand: "Palace", url: "https://shop-usa.palaceskateboards.com/products/knjspa2cu1x9", photoUrl: "https://cdn.shopify.com/s/files/1/0923/4190/products/palace_summer_chino_brn_camo_0999_640x@2x.jpg?v=1620374181", type: .bottoms), ClothingItem(name: "Classic Frog Logo Tee Forest Green", brand: "Frog", url: "https://frogskateboards.com/collections/clothing-2021/products/classic-frog-logo-tee-forest-green", photoUrl: "https://cdn.shopify.com/s/files/1/2134/2131/products/Frog.Flats.7_f172b572-b352-40d1-a468-65a447019b49_1080x.png?v=1618912511", type: .tops), ClothingItem(name: "Basically A Hood Yellow", brand: "Palace", url: "https://shop-usa.palaceskateboards.com/products/g4ugc4wqzgdw", photoUrl: "https://cdn.shopify.com/s/files/1/0923/4190/products/Palace-Spring-hood-basically-sand-0468_a11ddb9c-5844-45a0-a45b-2d14c97b981b_640x@2x.jpg?v=1620396146", type: .outwear), ClothingItem(name: "Stitch Up Bucket Hat Teal", brand: "Palace", url: "https://shop-usa.palaceskateboards.com/products/xvknirg213n9", photoUrl: "https://cdn.shopify.com/s/files/1/0923/4190/products/Palace_Spring_bucket_multi_green_2924_f5b7d457-39a3-47ce-8377-c5e622e5ca51_640x@2x.jpg?v=1620329274", type: .accessories), ClothingItem(name: "Corduroy Pant [Sage]", brand: "GX1000", url: "https://gx1000store.com/collections/products/products/corduroy-pant-sage", photoUrl: "https://cdn.shopify.com/s/files/1/0063/4358/9961/products/CORDPANTSAGE-FRONT_1024x1024.jpg?v=1621296507", type: .bottoms), ClothingItem(name: "OG Logo [Black]", brand: "GX1000", url: "https://gx1000store.com/collections/products/products/og-logo-black", photoUrl: "https://cdn.shopify.com/s/files/1/0063/4358/9961/products/OGLOGOBLACK_1024x1024.jpg?v=1621372835", type: .tops), ClothingItem(name: "Anorak [Pale Yellow]", brand: "GX1000", url: "https://gx1000store.com/collections/products/products/anorak-pale-yellow", photoUrl: "https://cdn.shopify.com/s/files/1/0063/4358/9961/products/ANORAKPALEYELLOW-FRONT_1024x1024.jpg?v=1621278155", type: .outwear)]
    
    var items: [ClothingItem] = [ClothingItem(name: "", url: "", photoUrl: "https://www.chanel.com/images//t_one/t_fashion//q_auto:good,f_jpg,fl_lossy,dpr_1.2/w_1680/boy-chanel-handbag-green-calfskin-silver-tone-metal-calfskin-silver-tone-metal-packshot-default-a67086b02856n6512-8824107859998.jpg"), ClothingItem(name: "", url: "", photoUrl: "https://aritzia.scene7.com/is/image/Aritzia/hi-res/s21_04_a08_84658_19631_on_a.jpg"), ClothingItem(name: "", url: "", photoUrl: "https://www.chanel.com/images//t_one/t_fashion//q_auto:good,f_jpg,fl_lossy,dpr_1.2/w_1680/boy-chanel-handbag-green-calfskin-silver-tone-metal-calfskin-silver-tone-metal-packshot-default-a67086b02856n6512-8824107859998.jpg"),ClothingItem(name: "", url: "", photoUrl: "https://www.chanel.com/images//t_one/t_fashion//q_auto:good,f_jpg,fl_lossy,dpr_1.2/w_1680/boy-chanel-handbag-green-calfskin-silver-tone-metal-calfskin-silver-tone-metal-packshot-default-a67086b02856n6512-8824107859998.jpg"), ClothingItem(name: "", url: "", photoUrl: "https://aritzia.scene7.com/is/image/Aritzia/hi-res/s21_04_a08_84658_19631_on_a.jpg"), ClothingItem(name: "", url: "", photoUrl: "https://www.chanel.com/images//t_one/t_fashion//q_auto:good,f_jpg,fl_lossy,dpr_1.2/w_1680/boy-chanel-handbag-green-calfskin-silver-tone-metal-calfskin-silver-tone-metal-packshot-default-a67086b02856n6512-8824107859998.jpg"), ClothingItem(name: "", url: "", photoUrl: "https://www.chanel.com/images//t_one/t_fashion//q_auto:good,f_jpg,fl_lossy,dpr_1.2/w_1680/boy-chanel-handbag-green-calfskin-silver-tone-metal-calfskin-silver-tone-metal-packshot-default-a67086b02856n6512-8824107859998.jpg"), ClothingItem(name: "", url: "", photoUrl: "https://www.chanel.com/images//t_one/t_fashion//q_auto:good,f_jpg,fl_lossy,dpr_1.2/w_1680/boy-chanel-handbag-green-calfskin-silver-tone-metal-calfskin-silver-tone-metal-packshot-default-a67086b02856n6512-8824107859998.jpg"), ClothingItem(name: "", url: "", photoUrl: "https://www.chanel.com/images//t_one/t_fashion//q_auto:good,f_jpg,fl_lossy,dpr_1.2/w_1680/boy-chanel-handbag-green-calfskin-silver-tone-metal-calfskin-silver-tone-metal-packshot-default-a67086b02856n6512-8824107859998.jpg"), ClothingItem(name: "", url: "", photoUrl: "https://aritzia.scene7.com/is/image/Aritzia/hi-res/s21_04_a08_84658_19631_on_a.jpg"), ClothingItem(name: "", url: "", photoUrl: "https://www.chanel.com/images//t_one/t_fashion//q_auto:good,f_jpg,fl_lossy,dpr_1.2/w_1680/boy-chanel-handbag-green-calfskin-silver-tone-metal-calfskin-silver-tone-metal-packshot-default-a67086b02856n6512-8824107859998.jpg"), ClothingItem(name: "", url: "", photoUrl: "https://aritzia.scene7.com/is/image/Aritzia/hi-res/s21_04_a08_84658_19631_on_a.jpg"), ClothingItem(name: "", url: "", photoUrl: "https://www.chanel.com/images//t_one/t_fashion//q_auto:good,f_jpg,fl_lossy,dpr_1.2/w_1680/boy-chanel-handbag-green-calfskin-silver-tone-metal-calfskin-silver-tone-metal-packshot-default-a67086b02856n6512-8824107859998.jpg"), ClothingItem(name: "", url: "", photoUrl: "https://aritzia.scene7.com/is/image/Aritzia/hi-res/s21_04_a08_84658_19631_on_a.jpg"), ClothingItem(name: "", url: "", photoUrl: "https://aritzia.scene7.com/is/image/Aritzia/hi-res/s21_04_a08_84658_19631_on_a.jpg")]
    
    
    var db: Firestore?
    var listener: CollectionReference?
    var exploreDict = [String: ClothingItem]()
    var shopDict = [String: ClothingItem]()
    
    
    enum TableType: String {
    case explore = "explore"
    case shop = "shop"
    }
    
    var tableType: TableType = .explore

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.bg
        
        db = Firestore.firestore()
        
        
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        addLayout()
        setupExploreCollectionVw()
        addGestures()
        
        setFirestoreExploreListener()
        setFirestoreShopListener()

    }
    
    func setupExploreCollectionVw() {
        exploreCollectionVw.register(ClothingItemCell.self, forCellWithReuseIdentifier: ClothingItemCell.id)
        exploreCollectionVw.delegate = self
        exploreCollectionVw.dataSource = self
        exploreCollectionVw.reloadData()
    }
    
}

extension ExploreVC: UITextFieldDelegate {
    
    // resign keyboard when scrolling
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if searchTextField.isFirstResponder {
            searchTextField.resignFirstResponder()
        }
    }
    
    @objc func textFieldDidChange() {
        print(searchTextField.text)
    }
}
