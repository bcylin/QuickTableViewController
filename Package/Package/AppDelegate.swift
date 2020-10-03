//
//  AppDelegate.swift
//  Package
//
//  Created by Ben on 03/10/2020.
//  Copyright © 2020 bcylin. All rights reserved.
//

import UIKit
import QuickTableViewController

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.backgroundColor = UIColor.white
    window?.rootViewController = UINavigationController(rootViewController: QuickTableViewController())
    window?.makeKeyAndVisible()
    return true
  }

}
