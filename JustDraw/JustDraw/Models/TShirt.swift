//
//  TShirt.swift
//  JustDraw
//
//  Created by Bao on 5/1/18.
//  Copyright © 2018 TranQuocBao. All rights reserved.
//

import UIKit

class TShirt: Product, Decodable {
    
    // MARK: Properties
    var totalItemsHeight: CGFloat = 0.0
    
    // MARK: CodingKeys
    enum CodingKeys: String, CodingKey {
        case sku = "SKU"
        case englishName = "EnglishName"
        case vietnamName = "VietNamName"
        case mainImage = "MainImage"
        case mainImageHeight = "MainImageHeight"
        case price = "Price"
        case quantity = "Quantity"
        case review = "Review"
        case sold = "Sold"
        case discount = "Discount"
    }
    
    // MARK: Constructor
    override init() {}
    
    required init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        sku = try container.decodeIfPresent(String.self, forKey: .sku) ?? ""
        englishName = try container.decodeIfPresent(String.self, forKey: .englishName) ?? ""
        vietnamName = try container.decodeIfPresent(String.self, forKey: .vietnamName) ?? ""
        mainImage = try container.decodeIfPresent(String.self, forKey: .mainImage) ?? ""
        mainImageHeight = try container.decodeIfPresent(CGFloat.self, forKey: .mainImageHeight) ?? 0.0
        price = try container.decodeIfPresent(Double.self, forKey: .price) ?? 0.0
        quantity = try container.decodeIfPresent(Int.self, forKey: .quantity) ?? 0
        review = try container.decodeIfPresent(Int.self, forKey: .review) ?? 0
        sold = try container.decodeIfPresent(Int.self, forKey: .sold) ?? 0
        discount = try container.decodeIfPresent(Int.self, forKey: .discount) ?? 0
    }
}
