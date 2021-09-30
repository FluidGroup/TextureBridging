//
//  AppDelegate.swift
//  TextureBridgingDemo
//
//  Created by muukii on 2019/05/15.
//  Copyright © 2019 muukii. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    let newWindow = UIWindow()
    newWindow.rootViewController = RootContainerViewController()
    newWindow.makeKeyAndVisible()
    self.window = newWindow
    return true
  }
}

