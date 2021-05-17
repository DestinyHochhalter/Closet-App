//
//  LoginVC.swift
//  CS175Project
//
//  Created by Destiny Hochhalter Ruiz on 5/5/21.
//

import Foundation
import UIKit
import FirebaseAuth

final class AuthVC: UIViewController {
    
    // prompt user to login, if not already signed up
    // then user can click on 'sign up' to create account
    
    // 'Log in'
    var loginLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Avenir-Heavy", size: 24)
        lbl.textColor = Color.darkText
        lbl.text = "Log In"
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
    
    var emailPromptLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Avenir-Heavy", size: 18)
        lbl.textColor = Color.mediumText
        lbl.text = "Enter your email"
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textAlignment = NSTextAlignment.left
        return lbl
    }()
    
    var passwordPromptLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Avenir-Heavy", size: 17)
        lbl.textColor = Color.mediumText
        lbl.text = "Enter your password"
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textAlignment = NSTextAlignment.left
        return lbl
    }()
    
    
    let seperatorView1: UIView = {
        let vw = UIView()
        vw.backgroundColor = Color.separator
        vw.isHidden = false
        return vw
    }()
    
    let seperatorView2: UIView = {
        let vw = UIView()
        vw.backgroundColor = Color.separator
        return vw
    }()
    
    let emailTextField: UITextField = {
        let field = UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 50))
        field.backgroundColor = .clear
        
        field.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedString.Key.foregroundColor: Color.lightText])
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
    
    let passwordTextField: UITextField = {
        let field = UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 50))
        field.backgroundColor = .clear
        
        field.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor: Color.lightText])
        field.font = UIFont(name: "Avenir-Medium", size: 17)
        field.borderStyle = UITextField.BorderStyle.none
        field.textColor = Color.darkText
        field.tintColor = Color.darkText
        field.isSecureTextEntry = true
        field.autocorrectionType = UITextAutocorrectionType.yes
        field.keyboardType = UIKeyboardType.default
        field.returnKeyType = UIReturnKeyType.done
        field.clearButtonMode = UITextField.ViewMode.whileEditing
        field.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        field.autocapitalizationType = UITextAutocapitalizationType.none
        return field
    }()
    
    let btnVwLogin: UIView = {
        let vw = UIView()
        // when input is valid, chnage color to black
        //vw.backgroundColor= Color.titleBlack
        vw.backgroundColor = Color.mediumText
        vw.layer.cornerRadius = 18
        vw.isUserInteractionEnabled = true
        return vw
    }()
    
    let btnVwSignup: UIView = {
        let vw = UIView()
        // when input is valid, chnage color to black
        //vw.backgroundColor= Color.titleBlack
        vw.backgroundColor = Color.lightText.withAlphaComponent(0.45)
        vw.layer.cornerRadius = 18
        vw.isUserInteractionEnabled = true
        return vw
    }()
    
    var loginVwLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Avenir-Medium", size: 17)
        lbl.textColor = .white
       // lbl.textColor = Color.darkGrey
        lbl.text = "Log In"
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textAlignment = NSTextAlignment.center
        return lbl
    }()
    
    var signupVwLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Avenir-Medium", size: 17)
        lbl.textColor = .white
       // lbl.textColor = Color.darkGrey
        lbl.text = "Sign up"
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
        emailTextField.becomeFirstResponder()
        
        emailTextField.delegate = self
        emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange), for: UIControl.Event.editingChanged)
        passwordTextField.delegate = self
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange), for: UIControl.Event.editingChanged)
        
        
    }
    
    @objc func loginTapped() {
        print("log in")
        addHapticFeedback(style: .light)
        login()
//        let tabbar = TabVC()
//        let navigationController = UINavigationController(rootViewController: tabbar)
//        navigationController.modalPresentationStyle = .fullScreen // cover full screen
//        navigationController.navigationBar.isHidden = true // hide top bar
//
//        // present tab bar that is embedded in navigation controller
//        self.present(navigationController, animated: false, completion: nil)
    }
    
    @objc func signupTapped() {
        // segue to sign-up page
        print("sign up")
        addHapticFeedback(style: .light)
        let vc = SignupEmailVC()
        vc.modalPresentationStyle = .overFullScreen
        vc.navigationItem.hidesBackButton = false
        vc.hidesBottomBarWhenPushed = true
        self.present(vc, animated: false)
        
        // FIXME: support error message for invalid password
        // offer 'reset password' option via Firebase Auth
    }
    
    @objc func backImgVwTapped() {
        print("back tapped")
        // pop off navigation contoller stack
        let vc = AuthVC()
        vc.modalPresentationStyle = .overFullScreen
        vc.navigationItem.hidesBackButton = false
        vc.hidesBottomBarWhenPushed = true
        self.present(vc, animated: false)
    }
    
    func addGestures() {
        let backTap = UITapGestureRecognizer(target: self, action: #selector(backImgVwTapped))
        backImgVw.addGestureRecognizer(backTap)
        
        let loginTap = UITapGestureRecognizer(target: self, action: #selector(loginTapped))
        btnVwLogin.addGestureRecognizer(loginTap)
        
        let signupTap = UITapGestureRecognizer(target: self, action: #selector(signupTapped))
        btnVwSignup.addGestureRecognizer(signupTap)
    }
    
    func addLayout() {
        loginLbl.addLayout(parentVw: view, top: (view.topAnchor, addPaddingForNotch(50)), horiz: view.centerXAnchor, width: Padding.lblWidth)
        backImgVw.addLayout(parentVw: view, leading: (view.leadingAnchor, 10),vert: loginLbl.centerYAnchor, height: Padding.backWidth, width: Padding.backWidth)
        
        emailPromptLbl.addLayout(parentVw: view, leading: (view.leadingAnchor, Padding.leadingSpace), top: (loginLbl.bottomAnchor, Padding.topSpacing))
        emailTextField.addLayout(parentVw: view, leading: (view.leadingAnchor, Padding.leadingSpace), trailing: (view.trailingAnchor, -Padding.leadingSpace), top: (emailPromptLbl.bottomAnchor, Padding.spacing), height: Padding.textFieldHeight)
        
        seperatorView1.addLayout(parentVw: view, leading: (view.leadingAnchor, Padding.leadingSpace), trailing: (view.trailingAnchor, -Padding.leadingSpace), top: (emailTextField.bottomAnchor, Padding.seperatorSpace), height: Padding.seperatorHeight)
        
        passwordPromptLbl.addLayout(parentVw: view, leading: (view.leadingAnchor, Padding.leadingSpace), trailing: (view.trailingAnchor, -Padding.leadingSpace), top: (seperatorView1.bottomAnchor, Padding.seperatorSpace))
        passwordTextField.addLayout(parentVw: view, leading: (view.leadingAnchor, Padding.leadingSpace), trailing: (view.trailingAnchor, -Padding.leadingSpace), top: (passwordPromptLbl.bottomAnchor, Padding.spacing), height: Padding.textFieldHeight)
        
        seperatorView2.addLayout(parentVw: view, leading: (view.leadingAnchor, Padding.leadingSpace), trailing: (view.trailingAnchor, -Padding.leadingSpace), top: (passwordTextField.bottomAnchor, Padding.seperatorSpace), height: Padding.seperatorHeight)
        
        btnVwLogin.addLayout(parentVw: view, leading: (view.leadingAnchor, Padding.leadingSpace), trailing: (view.trailingAnchor, -Padding.leadingSpace), top: (seperatorView2.bottomAnchor, Padding.topSpacing), height: Padding.btnHeight)
        signupVwLbl.fill(btnVwSignup)
        
        btnVwSignup.addLayout(parentVw: view, leading: (view.leadingAnchor, Padding.leadingSpace), trailing: (view.trailingAnchor, -Padding.leadingSpace), top: (btnVwLogin.bottomAnchor, Padding.topSpacing), height: Padding.btnHeight)
        loginVwLbl.fill(btnVwLogin)
        
        
    }
    
    
    func login() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        
        // get Auth instance, attempt to sign in
        Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            
            guard error == nil else {
                print("login failed")
                return
            }
            
            // login succesful
            
            print("login succesful")
         //   print("\(user.email!) logged in!")
            
            let tabbar = TabVC()
            let navigationController = UINavigationController(rootViewController: tabbar)
            navigationController.modalPresentationStyle = .fullScreen // cover full screen
            navigationController.navigationBar.isHidden = true // hide top bar
            
            // present tab bar that is embedded in navigation controller
            strongSelf.present(navigationController, animated: false, completion: nil)
            
        })
        }
}


extension AuthVC: UITextFieldDelegate {
    
    @objc func emailTextFieldDidChange() {
       // print(emailTextField.text)
    }
    
    @objc func passwordTextFieldDidChange() {
        //print(passwordTextField.text)
    }
}

