//
//  AppDelegate.swift
//  CS175Project
//
//  Created by Destiny Hochhalter Ruiz on 4/13/21.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseCore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Firebase setup
        FirebaseApp.configure()
        let db = Firestore.firestore()
        Database.database().isPersistenceEnabled = true
        let user = Auth.auth().currentUser

        
        
      //  window = UIWindow(frame: UIScreen.main.bounds)
//
//        if let tabBarController = self.window!.rootViewController as? UITabBarController {
//            tabBarController.selectedIndex = 0
////        }
        
//        window = UIWindow(frame: UIScreen.main.bounds)
//        let vc = ProfileVC()
//        self.window?.rootViewController = UINavigationController(rootViewController: vc)
       
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = SplashVC() // make splash screen root view
//       // self.window = window
//        window?.makeKeyAndVisible()
        
//        if let tabBarController = self.window!.rootViewController as? UITabBarController {
//            tabBarController.selectedIndex = 0
//        }
//
        window = UIWindow()
        let nav = UINavigationController()
        nav.viewControllers = [SplashVC()]
        nav.navigationBar.isHidden = true
        nav.navigationItem.hidesBackButton = true
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }

    // MARK: UISceneSession Lifecycle

//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }


}

