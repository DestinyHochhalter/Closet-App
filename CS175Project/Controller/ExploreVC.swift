//
//  ExploreVC.swift
//  CS175Project
//
//  Created by Destiny Hochhalter Ruiz on 5/4/21.
//

import Foundation
import UIKit


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
    
    var items: [ClothingItem] = [ClothingItem(name: "", url: "", photoUrls: ["https://www.chanel.com/images//t_one/t_fashion//q_auto:good,f_jpg,fl_lossy,dpr_1.2/w_1680/boy-chanel-handbag-green-calfskin-silver-tone-metal-calfskin-silver-tone-metal-packshot-default-a67086b02856n6512-8824107859998.jpg"]), ClothingItem(name: "", url: "", photoUrls: ["https://aritzia.scene7.com/is/image/Aritzia/hi-res/s21_04_a08_84658_19631_on_a.jpg"]), ClothingItem(name: "", url: "", photoUrls: ["https://www.chanel.com/images//t_one/t_fashion//q_auto:good,f_jpg,fl_lossy,dpr_1.2/w_1680/boy-chanel-handbag-green-calfskin-silver-tone-metal-calfskin-silver-tone-metal-packshot-default-a67086b02856n6512-8824107859998.jpg"]),ClothingItem(name: "", url: "", photoUrls: ["https://www.chanel.com/images//t_one/t_fashion//q_auto:good,f_jpg,fl_lossy,dpr_1.2/w_1680/boy-chanel-handbag-green-calfskin-silver-tone-metal-calfskin-silver-tone-metal-packshot-default-a67086b02856n6512-8824107859998.jpg"]), ClothingItem(name: "", url: "", photoUrls: ["https://aritzia.scene7.com/is/image/Aritzia/hi-res/s21_04_a08_84658_19631_on_a.jpg"]), ClothingItem(name: "", url: "", photoUrls: ["https://www.chanel.com/images//t_one/t_fashion//q_auto:good,f_jpg,fl_lossy,dpr_1.2/w_1680/boy-chanel-handbag-green-calfskin-silver-tone-metal-calfskin-silver-tone-metal-packshot-default-a67086b02856n6512-8824107859998.jpg"]), ClothingItem(name: "", url: "", photoUrls: ["https://www.chanel.com/images//t_one/t_fashion//q_auto:good,f_jpg,fl_lossy,dpr_1.2/w_1680/boy-chanel-handbag-green-calfskin-silver-tone-metal-calfskin-silver-tone-metal-packshot-default-a67086b02856n6512-8824107859998.jpg"]), ClothingItem(name: "", url: "", photoUrls: ["https://www.chanel.com/images//t_one/t_fashion//q_auto:good,f_jpg,fl_lossy,dpr_1.2/w_1680/boy-chanel-handbag-green-calfskin-silver-tone-metal-calfskin-silver-tone-metal-packshot-default-a67086b02856n6512-8824107859998.jpg"]), ClothingItem(name: "", url: "", photoUrls: ["https://www.chanel.com/images//t_one/t_fashion//q_auto:good,f_jpg,fl_lossy,dpr_1.2/w_1680/boy-chanel-handbag-green-calfskin-silver-tone-metal-calfskin-silver-tone-metal-packshot-default-a67086b02856n6512-8824107859998.jpg"]), ClothingItem(name: "", url: "", photoUrls: ["https://aritzia.scene7.com/is/image/Aritzia/hi-res/s21_04_a08_84658_19631_on_a.jpg"]), ClothingItem(name: "", url: "", photoUrls: ["https://www.chanel.com/images//t_one/t_fashion//q_auto:good,f_jpg,fl_lossy,dpr_1.2/w_1680/boy-chanel-handbag-green-calfskin-silver-tone-metal-calfskin-silver-tone-metal-packshot-default-a67086b02856n6512-8824107859998.jpg"]), ClothingItem(name: "", url: "", photoUrls: ["https://aritzia.scene7.com/is/image/Aritzia/hi-res/s21_04_a08_84658_19631_on_a.jpg"]), ClothingItem(name: "", url: "", photoUrls: ["https://www.chanel.com/images//t_one/t_fashion//q_auto:good,f_jpg,fl_lossy,dpr_1.2/w_1680/boy-chanel-handbag-green-calfskin-silver-tone-metal-calfskin-silver-tone-metal-packshot-default-a67086b02856n6512-8824107859998.jpg"]), ClothingItem(name: "", url: "", photoUrls: ["https://aritzia.scene7.com/is/image/Aritzia/hi-res/s21_04_a08_84658_19631_on_a.jpg"]), ClothingItem(name: "", url: "", photoUrls: ["https://aritzia.scene7.com/is/image/Aritzia/hi-res/s21_04_a08_84658_19631_on_a.jpg"])]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.bg
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        addLayout()
        setupExploreCollectionVw()
        addGestures()
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
