//
//  TShirtViewModel.swift
//  JustDraw
//
//  Created by Bao on 5/12/18.
//  Copyright © 2018 TranQuocBao. All rights reserved.
//

import Foundation
import iso4217

class TShirtViewModel: Product {
    
    // MARK: Properties
    private var tshirt: TShirt
    
    var nameText: String {
        return tshirt.vietnamName
    }
    
    var priceText: String {
        let price = Price(value: tshirt.price, currency: .vnd)
        return "\(price)"
    }
    
    var discountPriceText: String {
        if productIsNotDiscounted() {
            return ""
        }
        let discountPrice = Price(value: tshirt.price * (1 - (Double(tshirt.discount) / 100.0)), currency: .vnd)
        return "\(discountPrice)"
    }
    
    var discountInfoText: String {
        if productIsNotDiscounted() {
            return ""
        }
        return "-\(tshirt.discount)%"
    }
    
    var reviewText: String {
        return "(\(tshirt.review))"
    }
    
    var storeAddressText: String {
        return tshirt.storeAddress
    }
    
    var productImage: URL? {
        guard let imageURL = URL(string: tshirt.mainImage) else { return nil }
        return imageURL
    }
    
    var productMainImageHeight: CGFloat {
        return tshirt.mainImageHeight
    }
    
    // MARK: Constructor
    init(tshirt: TShirt) {
        self.tshirt = tshirt
    }
    
    // MARK: Methods
    func productIsNotDiscounted() -> Bool {
        return tshirt.discount == 0 ? true : false
    }
}
