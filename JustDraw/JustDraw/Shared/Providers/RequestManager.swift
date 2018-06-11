//
//  RequestManager.swift
//  JustDraw
//
//  Created by Bao on 5/1/18.
//  Copyright © 2018 TranQuocBao. All rights reserved.
//

import Foundation
import RxSwift

class RequestManager {
    static let shared: RequestManager = RequestManager()
    let database = NRDatabaseProvider<FirebaseEndPoint>()
}

extension RequestManager {
    func fetchProduct() -> Observable<[Product]> {
        return Observable.create { [weak self] observer in
            self?.database.request(.getProduct()) { result in
                switch result {
                case .success(let response):
                    if let snapshot = response.snapshot {
                        if let value = snapshot.value as? [String: Any] {
                            do {
                                var products: [Product] = [Product]()
                                for item in value {
                                    let jsonData = try JSONSerialization.data(withJSONObject: item.value, options: [])
                                    let tshirt = try JSONDecoder().decode(TShirt.self, from: jsonData)
                                    products.append(tshirt)
                                }
                                observer.onNext(products)
                            } catch let error {
                                observer.onError(error)
                            }
                        } else {
                            observer.onNext([])
                        }
                    } else {
                        observer.onNext([])
                    }
                case .failure(let error):
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}
