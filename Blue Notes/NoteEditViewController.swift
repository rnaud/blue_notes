//
//  NoteEditViewController.swift
//  Blue Notes
//
//  Created by Arnaud Ferreri on 12/17/15.
//  Copyright © 2015 Arnaud Ferreri. All rights reserved.
//

import UIKit
import Foundation
import SwiftyDropbox
import UIColor_Hex_Swift

class NoteEditViewController: UIViewController {
    internal var path: String = ""
    internal var textView: UITextView = UITextView()
    
    override func viewDidLoad() {
        textView.frame = CGRectMake(0, 0, view.frame.width, view.frame.height)
        textView.textContainerInset = UIEdgeInsetsMake(20, 20, 20, 20);
        textView.textColor = UIColor(rgba: "#FF5370")
        textView.backgroundColor = UIColor(rgba: "#263238")
        textView.font = UIFont(name: "Fira Code", size: 16)
        view.addSubview(textView)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = true;
        downloadFile(path)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false;
    }
    
    func downloadFile(path: String) {
        if let client = Dropbox.authorizedClient {
        
            let destination : (NSURL, NSHTTPURLResponse) -> NSURL = { temporaryURL, response in
                let fileManager = NSFileManager.defaultManager()
                let directoryURL = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
                // generate a unique name for this file in case we've seen it before
                let UUID = NSUUID().UUIDString
                let pathComponent = "\(UUID)-\(response.suggestedFilename!)"
                return directoryURL.URLByAppendingPathComponent(pathComponent)
            }
            
            client.files.download(path: path, destination: destination).response { response, error in
                if let (_, url) = response {
                    let data = NSData(contentsOfURL: url)
                    let txt = String(data: data!, encoding:NSUTF8StringEncoding)
                    self.textView.text = txt
                } else {
                    print(error!)
                }
            }
        }
    }
}
