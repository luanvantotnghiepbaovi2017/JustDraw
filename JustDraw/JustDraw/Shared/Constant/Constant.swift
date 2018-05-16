//
//  Constant.swift
//  JustDraw
//
//  Created by Bao on 5/1/18.
//  Copyright © 2018 TranQuocBao. All rights reserved.
//

import Foundation
import UIKit

struct Constant {
    struct Font {
        static let AvenirNextMedium15: UIFont = UIFont(name: "AvenirNext-Medium", size: 15) ?? UIFont.systemFont(ofSize: 15)
    }
    struct CollectionView {
        struct Home {
            static let numberOfColumns: CGFloat = 2.0
            static var contentWidth: CGFloat = 0.0
        }
    }
}
