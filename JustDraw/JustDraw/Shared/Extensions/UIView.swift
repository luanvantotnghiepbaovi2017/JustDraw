//
//  UIView.swift
//  JustDraw
//
//  Created by Bao on 5/6/18.
//  Copyright © 2018 TranQuocBao. All rights reserved.
//

import UIKit

extension UIView {
    class var nibName: String {
        let name = "\(self)".components(separatedBy: ".").first ?? ""
        return name
    }
}
