//
//  LoginViewController.swift
//  Blue Notes
//
//  Created by Arnaud Ferreri on 11/24/15.
//  Copyright © 2015 Arnaud Ferreri. All rights reserved.
//

import UIKit
import SwiftyDropbox

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = UIButton()
        loginButton.setTitle("Login with Dropbox", forState: .Normal)
        loginButton.addTarget(self, action: "linkButtonPressed:", forControlEvents: .TouchUpInside)
        loginButton.setTitleColor(UIColor(rgba: "#FF5370"), forState: UIControlState.Normal)
        loginButton.sizeToFit()
        loginButton.titleLabel?.font = UIFont(name: "Fire Coda", size: 20)
        loginButton.center = view.center
        
        self.view.backgroundColor = UIColor(rgba: "#263238")
        self.view.addSubview(loginButton)
        
    }
    
    func linkButtonPressed(sender: AnyObject) {
        if (Dropbox.authorizedClient == nil) {
            Dropbox.authorizeFromController(self)
        } else {
            print("User is already authorized!")
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        if (Dropbox.authorizedClient != nil) {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
}