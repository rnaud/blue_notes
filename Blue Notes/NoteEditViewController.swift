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

class NoteEditViewController: UIViewController, UITextViewDelegate {
    internal var path: String = ""
    internal var textView: UITextView = UITextView()
    internal var textViewString: NSMutableAttributedString = NSMutableAttributedString()
    internal var themeStr: String = "material"
    internal var theme: Theme = Theme()
    
    override func viewDidLoad() {
        textView.frame = CGRectMake(0, 0, view.frame.width, view.frame.height)
        textView.textContainerInset = UIEdgeInsetsMake(20, 20, 20, 20);
        textView.backgroundColor = self.theme.backgroundColor()
        textView.delegate = self
        textView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
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
                    if txt == nil {
                        return
                    }
                    self.textViewString = NSMutableAttributedString(string: txt!, attributes: self.theme.defaultStrAttributes())
//                    self.textView.attributedText = self.stringToAttributedString(txt!)
                    self.highlightSyntax()
                    self.textView.attributedText = self.textViewString
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
    
    func highlightSyntax() {
        self.textViewString.setAttributes(self.theme.defaultStrAttributes(), range: NSMakeRange(0, self.textViewString.string.characters.count))
        let syntax = Syntaxes().getSyntaxForExtension(self.pathExtension())
        
        for (styleType, pattern) in syntax {
            print(pattern)
            print(styleType)
            let expression = try! NSRegularExpression(pattern: pattern, options: [.AnchorsMatchLines])
            let matches = expression.matchesInString(self.textViewString.string, options: [], range:NSMakeRange(0, self.textViewString.string.characters.count))
            for match in matches {
                let styleObj = self.theme.getTheme()[styleType]
                if styleObj != nil {
                    self.textViewString.addAttributes(styleObj!, range: match.range)
                }
                
            }
        }
    }
    
    func textViewDidChange(textView: UITextView) {
        let currentRange = self.textView.selectedRange
        self.textViewString = self.textView.attributedText.mutableCopy() as! NSMutableAttributedString
        self.highlightSyntax()
        self.textView.attributedText = self.textViewString
        self.textView.selectedRange = currentRange
    }
}
