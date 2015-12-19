//
//  Themes
//  Blue Notes
//
//  Created by Arnaud Ferreri on 12/18/15.
//  Copyright © 2015 Arnaud Ferreri. All rights reserved.
//

import Foundation
import UIColor_Hex_Swift

class Themes : NSObject {
    let material: [String: [String: AnyObject]] = [
        "header" : [NSForegroundColorAttributeName: UIColor(rgba: "#78CCEC")],
        "emphasis" : [NSForegroundColorAttributeName: UIColor(rgba: "#F5A731"), NSFontAttributeName: UIFont(name: "FiraCode-Bold", size: 16)!],
        "ul" : [NSForegroundColorAttributeName: UIColor(rgba: "#FF5370")],
        "link" : [NSForegroundColorAttributeName: UIColor(rgba: "#F5A731")],
    ]
    
    func getTheme(themeName: String) -> [String: [String: AnyObject]] {
        if themeName == "material" {
            return material
        } else {
            return material
        }
    }
    
    func defaultAttributedStringAttributes() -> [String: AnyObject] {
     return [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "FiraCode-Regular", size: 16)!]
    }
}