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
    func fetchProduct() -> Observable<[TShirt]> {
        return Observable.create { [weak self] observer in
            self?.database.request(.getProduct()) { result in
                switch result {
                case .success(let response):
                    guard let snapshot = response.snapshot else { return observer.onNext([]) }
                    guard let value = snapshot.value as? [String: Any] else { return observer.onNext([]) }
                    do {
                        var products: [TShirt] = [TShirt]()
                        for item in value {
                            let jsonData = try JSONSerialization.data(withJSONObject: item.value, options: [])
                            let product = try JSONDecoder().decode(TShirt.self, from: jsonData)
                            products.append(product)
                        }
                        observer.onNext(products)
                    } catch let error {
                        observer.onError(error)
                    }
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
