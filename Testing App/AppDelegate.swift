//
//  AppDelegate.swift
//  Testing App
//
//  Created by Hamza Ansari on 09/06/15.
//  Copyright (c) 2015 Thought Chimp. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    let parseApplicationID = "fGPY97cIdGwok87VPfgBUAw0txX1fJmp6pwUJAux"
    let parseClientKey = "zbH0Kxr9kI2qy0UQ3jK2rLc9hoVowaeBGPCXjM6I"
    Parse.setApplicationId(parseApplicationID, clientKey: parseClientKey)
    
    return true
  }


}

