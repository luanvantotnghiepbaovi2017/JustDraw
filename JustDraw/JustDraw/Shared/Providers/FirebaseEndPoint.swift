//
//  FirebaseEndPoint.swift
//  JustDraw
//
//  Created by Bao on 5/1/18.
//  Copyright © 2018 TranQuocBao. All rights reserved.
//

import Foundation
import Firebase

enum FirebaseEndPoint: NRDatabaseTarget {
    case getProduct()
    
    var baseReference: DatabaseReference {
        return Database.database().reference()
    }
    
    var path: String {
        switch self {
        case .getProduct:
            return "Product"
        }
    }
    
    var task: NRDatabaseTask {
        switch self {
        case .getProduct:
            return .observeOnce(.value)
        }
    }
}
