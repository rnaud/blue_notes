//
//  UIImage_Resize.swift
//  Blue Notes
//
//  Created by Arnaud Ferreri on 12/20/15.
//  Copyright © 2015 Arnaud Ferreri. All rights reserved.
//

import UIKit
import Foundation


/*
Image Resizing Techniques: http://bit.ly/1Hv0T6i
*/
public extension UIImage {
    func resize(let size: CGSize) -> UIImage {
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        self.drawInRect(CGRect(origin: CGPointZero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
}