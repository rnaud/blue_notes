//
//  Theme
//  Blue Notes
//
//  Created by Arnaud Ferreri on 12/18/15.
//  Copyright © 2015 Arnaud Ferreri. All rights reserved.
//

import Foundation
import UIColor_Hex_Swift

class Theme : AnyObject {
    var selectedTheme : String = "material"
    
    let material: [String: [String: AnyObject]] = [
        "defaults": ["background": UIColor(rgba: "#263238"), "text" : [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "FiraCode-Regular", size: 16)!]],
        "header" : [NSForegroundColorAttributeName: UIColor(rgba: "#78CCEC")],
        "emphasis" : [NSForegroundColorAttributeName: UIColor(rgba: "#F5A731"), NSFontAttributeName: UIFont(name: "FiraCode-Bold", size: 16)!],
        "ul" : [NSForegroundColorAttributeName: UIColor(rgba: "#FF5370")],
        "link" : [NSForegroundColorAttributeName: UIColor(rgba: "#F5A731")],
        "keyword" : [NSForegroundColorAttributeName: UIColor(rgba: "#FF5370")],
        "comment" : [NSForegroundColorAttributeName: UIColor(rgba: "#78CCEC")],
        "number" : [NSForegroundColorAttributeName: UIColor(rgba: "#F5A731"), NSFontAttributeName: UIFont(name: "FiraCode-Bold", size: 16)!]
    ]
    
    init() {}
    
    init(theme: String) {
        self.selectedTheme = theme
    }
    
    func backgroundColor() -> UIColor {
        return getTheme()["defaults"]!["background"] as! UIColor
    }
    
    func defaultStrAttributes() -> [String: AnyObject] {
        return getTheme()["defaults"]!["text"] as! [String: AnyObject]
    }
    
    func getTheme() -> [String: [String: AnyObject]] {
        if self.selectedTheme == "material" {
            return material
        } else {
            return material
        }
    }
}