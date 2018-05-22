//
//  Helper.swift
//  JustDraw
//
//  Created by Bao on 5/16/18.
//  Copyright © 2018 TranQuocBao. All rights reserved.
//

import Foundation
import UIKit

class Helper {
    class func height(`for` text: String, `with` font: UIFont, width: CGFloat) -> CGFloat
    {
        let nsstring = NSString(string: text)
        let textAttributes = [NSAttributedStringKey.font : font]
        let boundingRect = nsstring.boundingRect(with: CGSize(width: width, height: .greatestFiniteMagnitude), options: [.usesLineFragmentOrigin], attributes: textAttributes, context: nil)
        return ceil(boundingRect.height)
    }
}
