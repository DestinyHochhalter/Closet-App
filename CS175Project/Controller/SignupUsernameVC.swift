//
//  SignupUsernameVC.swift
//  CS175Project
//
//  Created by Destiny Hochhalter Ruiz on 5/5/21.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

final class SignupUsernameVC: UIViewController {
    
    
    var email: String?
    var password: String?
    var username: String?
    var db: Firestore!
    
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
        vw.tintColor = Color.mediumText
        return vw
    }()
    
    var usernamePromptLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Avenir-Heavy", size: 18)
        lbl.textColor = Color.mediumText
        lbl.text = "Create your username"
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textAlignment = NSTextAlignment.left
        return lbl
    }()

    
    let seperatorView: UIView = {
        let vw = UIView()
        vw.backgroundColor = Color.separator
        vw.isHidden = false
        return vw
    }()
    

    
    let usernameTextField: UITextField = {
        let field = UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 50))
        field.backgroundColor = .clear
        
        field.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedString.Key.foregroundColor: Color.lightText])
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
        vw.backgroundColor = Color.mediumText
        vw.layer.cornerRadius = 18
        vw.isUserInteractionEnabled = true
        return vw
    }()
    
    var doneLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Avenir-Medium", size: 17)
       // lbl.textColor = Color.white
        lbl.textColor = .white
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
        usernameTextField.becomeFirstResponder()
        db = Firestore.firestore()
        
        usernameTextField.delegate = self
        usernameTextField.addTarget(self, action: #selector(passwordTextFieldDidChange), for: UIControl.Event.editingChanged)
        
        
    }
    
    @objc func doneTapped() {
        print("next tapped")
        addHapticFeedback(style: .light)
        if usernameTextField.text != "" {
        createAccount()
        }
    }
    
    @objc func backImgVwTapped() {
        print("back tapped")
        // pop off navigation contoller stack
        let vc = SignupPasswordVC()
        vc.modalPresentationStyle = .overFullScreen
        vc.navigationItem.hidesBackButton = false
        vc.hidesBottomBarWhenPushed = true
        self.present(vc, animated: false)
    }
    
    func addGestures() {
        let backTap = UITapGestureRecognizer(target: self, action: #selector(backImgVwTapped))
        backImgVw.addGestureRecognizer(backTap)
        
        let doneTap = UITapGestureRecognizer(target: self, action: #selector(doneTapped))
        btnVw.addGestureRecognizer(doneTap)
        
    }
    
    func addLayout() {
        signupLbl.addLayout(parentVw: view, top: (view.topAnchor, addPaddingForNotch(50)), horiz: view.centerXAnchor, width: Padding.lblWidth)
        backImgVw.addLayout(parentVw: view, leading: (view.leadingAnchor, 10),vert: signupLbl.centerYAnchor, height: Padding.backWidth, width: Padding.backWidth)
        
        usernamePromptLbl.addLayout(parentVw: view, leading: (view.leadingAnchor, Padding.leadingSpace), top: (signupLbl.bottomAnchor, Padding.topSpacing))
        usernameTextField.addLayout(parentVw: view, leading: (view.leadingAnchor, Padding.leadingSpace), trailing: (view.trailingAnchor, -Padding.leadingSpace), top: (usernamePromptLbl.bottomAnchor, Padding.spacing), height: Padding.textFieldHeight)
        
        seperatorView.addLayout(parentVw: view, leading: (view.leadingAnchor, Padding.leadingSpace), trailing: (view.trailingAnchor, -Padding.leadingSpace), top: (usernameTextField.bottomAnchor, Padding.seperatorSpace), height: Padding.seperatorHeight)
        
        btnVw.addLayout(parentVw: view, leading: (view.leadingAnchor, Padding.leadingSpace), trailing: (view.trailingAnchor, -Padding.leadingSpace), top: (seperatorView.bottomAnchor, Padding.topSpacing), height: Padding.btnHeight)
        doneLbl.fill(btnVw)
        
    }
    
    func createAccount() {
        
        print(self.email)
        print(self.password)
        print(self.username)
        
        guard let _email = self.email, let _password = self.password else {
            print("failed to create account with uesr info")
            return
        }
        Auth.auth().createUser(withEmail: _email, password: _password, completion: { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            
            guard let user = authResult?.user, error == nil else {
                print("failed to create account")
                print(error?.localizedDescription)
                
                if let errCode = AuthErrorCode(rawValue: error!._code) {
                    print(errCode.rawValue)
                }
                
                return
            }
            
            print("\(user.email!) created")
            print("account creation succesful")
            self?.addFirebaseProfile(email: _email, username: _password)
            
            
            let tabbar = TabVC()
            let navigationController = UINavigationController(rootViewController: tabbar)
            navigationController.modalPresentationStyle = .fullScreen // cover full screen
            navigationController.navigationBar.isHidden = true // hide top bar

            // present tab bar that is embedded in navigation controller
            strongSelf.present(navigationController, animated: false, completion: nil)
    })
}
    
    func addFirebaseProfile(email: String, username: String) {
        
        // generate random ID
        let id = NSUUID().uuidString
        
        let data = ["userId": id,
                    "username": username,
                    "email": email,
                    "profileImageUrl": "",
                    "followerCount": 0,
                    "followingCount": 0] as [String : Any]
        
        // each user has user path
        // add a 'profile' path for the user
        
        // make sure user has been added to FirestoreAuth
        if (Auth.auth().currentUser?.uid) != nil {
        // Firestore reference to profile document
        let userRef = self.db.collection("users").document(id).collection("profile").document()
           
        
        // add JSON formatted data to profile document
        userRef.setData(data)
        }
        

        }
        

    
}


extension SignupUsernameVC: UITextFieldDelegate {
    
    @objc func passwordTextFieldDidChange() {
        //print(usernameTextField.text)
        self.username = usernameTextField.text
    }
}

