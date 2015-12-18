//
//  AppDelegate.swift
//  Blue Notes
//
//  Created by Arnaud Ferreri on 11/24/15.
//  Copyright © 2015 Arnaud Ferreri. All rights reserved.
//

import UIKit
import SwiftyDropbox

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        Dropbox.setupWithAppKey(NSBundle.mainBundle().objectForInfoDictionaryKey("DropboxAppKey") as! String)
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        if let window = window {
            window.backgroundColor = UIColor.whiteColor()
            window.rootViewController = TabViewController()
            window.makeKeyAndVisible()
        }
        
        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        
        if let authResult = Dropbox.handleRedirectURL(url) {
            switch authResult {
            case .Success(let token):
                print("Success! User is logged into Dropbox. \(token)")
                window?.rootViewController?.presentedViewController?.dismissViewControllerAnimated(true, completion: nil)
            case .Error(let error, let description):
                print("Error: \(error) \(description)")
            }
        }
        
        return false
    }


}

