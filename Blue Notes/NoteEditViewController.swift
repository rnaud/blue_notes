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
import SyntaxKit

class NoteEditViewController: UIViewController {
    internal var path: String = ""
    internal var textView: UITextView = UITextView()
    
    override func viewDidLoad() {
        textView.frame = CGRectMake(0, 0, view.frame.width, view.frame.height)
        textView.textContainerInset = UIEdgeInsetsMake(20, 20, 20, 20);
        textView.backgroundColor = UIColor(rgba: "#263238")
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
                    self.textView.attributedText = self.stringToAttributedString(txt!)
                } else {
                    print(error!)
                }
            }
        }
    }
        
    func pathExtension() -> String! {
        let extensionArr = self.path.characters.split{$0 == "."}.map(String.init)
        return extensionArr.last
    }
    
    func stringToAttributedString(txt: String) -> NSAttributedString! {
        let str : NSMutableAttributedString = NSMutableAttributedString(string: txt, attributes: Themes().defaultAttributedStringAttributes())
        let syntax = Syntaxes().getSyntaxForExtension(self.pathExtension())
        let theme = Themes().getTheme("material")
        
        for (pattern, styleType) in syntax {
            let expression = try! NSRegularExpression(pattern: pattern, options: [.AnchorsMatchLines])
            let matches = expression.matchesInString(txt, options: [], range:NSMakeRange(0, txt.characters.count))
            for match in matches {
                let styleObj = theme[styleType]
                if styleObj != nil {
                    str.addAttributes(styleObj!, range: match.range)
                }
                
            }
        }
        
        return str
    }
}
