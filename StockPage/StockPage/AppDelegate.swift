//
//  AppDelegate.swift
//  StockPage
//
//  Created by Utkarsh Raj on 17/11/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setUpWindowViewController()
        return true
    }

    private func setUpWindowViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let rootViewController = RootTabBarController()
        window?.rootViewController = rootViewController
        
    }


}

