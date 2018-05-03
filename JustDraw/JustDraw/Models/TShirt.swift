//
//  TShirt.swift
//  JustDraw
//
//  Created by Bao on 5/1/18.
//  Copyright © 2018 TranQuocBao. All rights reserved.
//

import Foundation

class TShirt: Decodable {
    // MARK: Properties
    var sku: String = ""
    var englishName: String = ""
    var vietnamName: String = ""
    var mainImage: String = ""
    var price: String = ""
    var quantity: Int = 0
    var review: Int = 0
    var sold: Int = 0
    var discount: Int = 0
    
    // MARK: CodingKeys
    enum CodingKeys: String, CodingKey {
        case sku = "SKU"
        case englishName = "EnglishName"
        case vietnamName = "VietNamName"
        case mainImage = "MainImage"
        case price = "Price"
        case quantity = "Quantity"
        case review = "Review"
        case sold = "Sold"
        case discount = "Discount"
    }
    
    // MARK: Constructor
    init() {}
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        sku = try container.decodeIfPresent(String.self, forKey: .sku) ?? ""
        englishName = try container.decodeIfPresent(String.self, forKey: .englishName) ?? ""
        vietnamName = try container.decodeIfPresent(String.self, forKey: .vietnamName) ?? ""
        mainImage = try container.decodeIfPresent(String.self, forKey: .mainImage) ?? ""
        price = try container.decodeIfPresent(String.self, forKey: .price) ?? ""
        quantity = try container.decodeIfPresent(Int.self, forKey: .quantity) ?? 0
        review = try container.decodeIfPresent(Int.self, forKey: .review) ?? 0
        sold = try container.decodeIfPresent(Int.self, forKey: .sold) ?? 0
        discount = try container.decodeIfPresent(Int.self, forKey: .discount) ?? 0
    }
}
