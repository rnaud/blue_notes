//
//  TabViewController.swift
//  Blue Notes
//
//  Created by Arnaud Ferreri on 11/24/15.
//  Copyright © 2015 Arnaud Ferreri. All rights reserved.
//

import UIKit
import SwiftyDropbox

class TabViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nav1 = UINavigationController()
        nav1.viewControllers = [BrowseFolderController()]
        
        let nav2 = UINavigationController()
        nav2.viewControllers = [SettingsViewController()]
        
        viewControllers = [nav1, nav2];
    }
    
    override func viewDidAppear(animated: Bool) {
        startLogin()
    }
    
    func startLogin() {
        if (Dropbox.authorizedClient == nil) {
            presentViewController(LoginViewController(), animated: true, completion: nil);
        }
    }
}
