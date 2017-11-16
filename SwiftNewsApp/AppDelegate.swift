//
//  AppDelegate.swift
//  SwiftNewsApp
//
//  Created by Maneesh Yadav on 25/06/2017.
//  Copyright © 2017 Maneesh Yadav. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    UIApplication.shared.statusBarStyle = .lightContent
    return true
  }
  
}

