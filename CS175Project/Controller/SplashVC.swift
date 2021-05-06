//
//  SplashVC.swift
//  CS175Project
//
//  Created by Destiny Hochhalter Ruiz on 5/4/21.
//

import Foundation
import UIKit
import FirebaseAuth

class SplashVC: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle?
    
    func setup() {
        
        // if user is logged in
        if Auth.auth().currentUser != nil {
            // User is signed in.
            let tabbar = TabVC()
            let navigationController = UINavigationController(rootViewController: tabbar)
            navigationController.modalPresentationStyle = .fullScreen // cover full screen
            navigationController.navigationBar.isHidden = true // hide top bar
            // present tab bar that is embedded in navigation controller
            self.present(navigationController, animated: false, completion: nil)
        } else {
             // user in not signed in
            // present AuthVC to login or signup
            let vc = AuthVC()
            vc.modalPresentationStyle = .overFullScreen
            vc.navigationItem.hidesBackButton = false
            vc.hidesBottomBarWhenPushed = true
            self.present(vc, animated: false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // start auth_listener
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
          
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // remove auth_listener
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Color.bg
        
        PAUSE(duration: 0.5) {
            self.setup()
        }
        
    }
    
}
