//
//  Syntaxes.swift
//  Blue Notes
//
//  Created by Arnaud Ferreri on 12/18/15.
//  Copyright © 2015 Arnaud Ferreri. All rights reserved.
//

import Foundation

class Syntaxes : NSObject {    
    func getSyntax(syntaxName: String) -> [String: String] {
        let path = NSBundle.mainBundle().pathForResource(syntaxName, ofType: "plist")
        if path != nil {
            return NSDictionary(contentsOfFile: path!) as! [String: String]
        } else {
            return Dictionary()
        }
    }
    
    func getSyntaxForExtension(ext: String) -> [String: String] {
        if ext == "md" {
            return getSyntax("markdown")
        } else if ext == "rb" {
            return getSyntax("ruby")
        } else {
            return getSyntax("default")
        }
    }
}
