//
//  Syntaxes.swift
//  Blue Notes
//
//  Created by Arnaud Ferreri on 12/18/15.
//  Copyright © 2015 Arnaud Ferreri. All rights reserved.
//

import Foundation

class Syntaxes : NSObject {
    let markdownSyntax: [String: String] = [
        "(#+)(.*)" : "header",
        "\\*\\*[A-z0-9]+\\*\\*" : "emphasis",
        "\\n\\*(.*)" : "ul",
        "\\r\\*(.*)" : "ul",
        "\\t\\*(.*)" : "ul",
        "\\[(.*?)\\]\\((\\S+)(\\s+(\"|\')(.*?)(\"|\'))?\\)": "link"
    ]
    
    let defaultSyntax: [String: String] = ["": ""]
    
    func getSyntax(syntaxName: String) -> [String: String] {
        if (syntaxName == "markdown") {
            return markdownSyntax
        } else {
            return defaultSyntax
        }
    }
    
    func getSyntaxForExtension(ext: String) -> [String: String] {
        if ext == "md" {
            return getSyntax("markdown")
        } else {
            return getSyntax("default")
        }
    }
}
