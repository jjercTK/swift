//
//  AppDelegate.swift
//  Facebook
//
//  Created by Juan José Ramírez on 7/20/17.
//  Copyright © 2017 Juan José Ramírez. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let feedViewController = FeedViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let navigationViewController = UINavigationController(rootViewController: feedViewController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = navigationViewController
        
        UINavigationBar.appearance().barTintColor = UIColor.rgb(red: 51, green: 90, blue: 149)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        application.statusBarStyle = .lightContent
        
        return true
    }


}

