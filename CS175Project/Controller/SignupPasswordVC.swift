//
//  SignupPasswordVC.swift
//  CS175Project
//
//  Created by Destiny Hochhalter Ruiz on 5/5/21.
//

import Foundation
import UIKit


final class SignupPasswordVC: UIViewController {
    
    var email: String?
    var password: String?
    
    // 'Sign up'
    var signupLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Avenir-Heavy", size: 24)
        lbl.textColor = Color.darkText
        lbl.text = "Sign up"
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textAlignment = NSTextAlignment.center
        return lbl
    }()
    
    // back btn
    var backImgVw: UIImageView = {
        let vw = UIImageView()
        vw.contentMode = .scaleAspectFit
        vw.clipsToBounds = true
        vw.isHidden = false
        vw.isUserInteractionEnabled = true
        vw.image = UIImage(named: "back")?.pad(-14)
        vw.tintColor = Color.darkText
        return vw
    }()
    
    var passwordPromptLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Avenir-Heavy", size: 18)
        lbl.textColor = Color.darkText
        lbl.text = "Create your password"
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textAlignment = NSTextAlignment.left
        return lbl
    }()

    
    let seperatorView: UIView = {
        let vw = UIView()
        vw.backgroundColor = Color.seperator
        vw.isHidden = false
        return vw
    }()
    

    
    let passwordTextField: UITextField = {
        let field = UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 50))
        field.backgroundColor = .clear
        
        field.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor: Color.lightText])
        field.font = UIFont(name: "Avenir-Medium", size: 17)
        field.borderStyle = UITextField.BorderStyle.none
        field.textColor = Color.mediumText
        field.tintColor = Color.mediumText
        field.autocorrectionType = UITextAutocorrectionType.yes
        field.keyboardType = UIKeyboardType.default
        field.returnKeyType = UIReturnKeyType.done
        field.clearButtonMode = UITextField.ViewMode.whileEditing
        field.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        field.autocapitalizationType = UITextAutocapitalizationType.none
        return field
    }()

    
    let btnVw: UIView = {
        let vw = UIView()
        // when input is valid, chnage color to black
        //vw.backgroundColor= Color.titleBlack
        vw.backgroundColor = Color.darkText
        vw.layer.cornerRadius = 18
        vw.isUserInteractionEnabled = true
        return vw
    }()
    
    var nextLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Avenir-Medium", size: 17)
        //lbl.textColor = Color.white
        lbl.textColor = .white
        lbl.text = "Next"
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textAlignment = NSTextAlignment.center
        return lbl
    }()
    
    enum Padding {
        static let lblWidth: CGFloat = 65
        static let backWidth: CGFloat = 45
        static let keyboardHeight: CGFloat = 300 // FIXME w keyboard height listener
        static let topSpacing: CGFloat = 25
        static let lblHeight: CGFloat = 10
        static let leadingSpace: CGFloat = 15
        static let spacing: CGFloat = 10
        static let textFieldHeight: CGFloat = 45
        static let seperatorHeight: CGFloat = 1
        static let seperatorSpace: CGFloat = 10
        static let btnHeight: CGFloat = 45
    }
    
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        addLayout()
        addGestures()
        passwordTextField.becomeFirstResponder()
        
        passwordTextField.delegate = self
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange), for: UIControl.Event.editingChanged)
        
        
    }
    
    @objc func nextTapped() {
        print("next tapped")
        let vc = SignupUsernameVC()
        vc.modalPresentationStyle = .overFullScreen
        vc.navigationItem.hidesBackButton = false
        vc.hidesBottomBarWhenPushed = true
        vc.email = self.email
        vc.password = self.password
        self.present(vc, animated: false)
        
    }
    
    @objc func backImgVwTapped() {
        print("back tapped")
        // pop off navigation contoller stack
        let vc = SignupEmailVC()
        vc.modalPresentationStyle = .overFullScreen
        vc.navigationItem.hidesBackButton = false
        vc.hidesBottomBarWhenPushed = true
        self.present(vc, animated: false)
    }
    
    func addGestures() {
        let backTap = UITapGestureRecognizer(target: self, action: #selector(backImgVwTapped))
        backImgVw.addGestureRecognizer(backTap)
        
        let nextTap = UITapGestureRecognizer(target: self, action: #selector(nextTapped))
        btnVw.addGestureRecognizer(nextTap)
        
    }
    
    func addLayout() {
        signupLbl.addLayout(parentVw: view, top: (view.topAnchor, addPaddingForNotch(50)), horiz: view.centerXAnchor, width: Padding.lblWidth)
        backImgVw.addLayout(parentVw: view, leading: (view.leadingAnchor, 10),vert: signupLbl.centerYAnchor, height: Padding.backWidth, width: Padding.backWidth)
        
        passwordPromptLbl.addLayout(parentVw: view, leading: (view.leadingAnchor, Padding.leadingSpace), top: (signupLbl.bottomAnchor, Padding.topSpacing))
        passwordTextField.addLayout(parentVw: view, leading: (view.leadingAnchor, Padding.leadingSpace), trailing: (view.trailingAnchor, -Padding.leadingSpace), top: (passwordPromptLbl.bottomAnchor, Padding.spacing), height: Padding.textFieldHeight)
        
        seperatorView.addLayout(parentVw: view, leading: (view.leadingAnchor, Padding.leadingSpace), trailing: (view.trailingAnchor, -Padding.leadingSpace), top: (passwordTextField.bottomAnchor, Padding.seperatorSpace), height: Padding.seperatorHeight)
        
        btnVw.addLayout(parentVw: view, leading: (view.leadingAnchor, Padding.leadingSpace), trailing: (view.trailingAnchor, -Padding.leadingSpace), top: (seperatorView.bottomAnchor, Padding.topSpacing), height: Padding.btnHeight)
        nextLbl.fill(btnVw)
        
    }
}


extension SignupPasswordVC: UITextFieldDelegate {
    
    @objc func passwordTextFieldDidChange() {
        print(passwordTextField.text)
        self.password = passwordTextField.text
    }
}


