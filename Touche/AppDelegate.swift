//
//  AppDelegate.swift
//  Touche-VIPER
//
//  Created by weyhan.
//  Copyright © 2020 eccentricdeveloper. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let mapWireFrame = MapWireFrame.createMapModule()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = mapWireFrame
        window?.makeKeyAndVisible()
        return true
    }
}

