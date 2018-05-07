//
//  Product.swift
//  JustDraw
//
//  Created by Bao on 5/6/18.
//  Copyright © 2018 TranQuocBao. All rights reserved.
//

import Foundation
import RxDataSources

struct ProductSectionModel {
    var items: [Product] = [Product]()
}

extension ProductSectionModel: SectionModelType {
    init(original: ProductSectionModel, items: [Product]) {
        self = original
        self.items = items
    }
}

class Product {
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
}
