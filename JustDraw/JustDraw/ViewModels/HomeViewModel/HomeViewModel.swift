//
//  TShirtViewModel.swift
//  JustDraw
//
//  Created by Bao on 5/1/18.
//  Copyright © 2018 TranQuocBao. All rights reserved.
//

import Foundation
import RxSwift

protocol HomeViewModelType: class {
    var isLoading: Observable<Bool> { get }
    func getProducts() -> Variable<[Product]>
    func getCountOfProducts() -> Int
    func setProducts(products: [Product])
    func getProduct(at indexPath: IndexPath) -> Product?
}

class HomeViewModel: HomeViewModelType {
    // MARK: Properties
    internal var isLoading: Observable<Bool>
    private var activityIndicator: ActivityIndicator!
    private var products: Variable<[Product]>!
    private let disposeBag: DisposeBag!
    
    // MARK: Methods
    /// Constructor
    init() {
        products = Variable<[Product]>([])
        activityIndicator = ActivityIndicator()
        isLoading = activityIndicator.asObservable()
        disposeBag = DisposeBag()
        fetchProductsFromFirebase()
    }
    
    /// Get Methods
    func getProducts() -> Variable<[Product]> {
        return products
    }
    
    func getProduct(at indexPath: IndexPath) -> Product? {
        if _isProductsEmpty() {
            return nil
        }
        return self.products.value[indexPath.item]
    }
    
    func getCountOfProducts() -> Int {
        if _isProductsEmpty() {
            return 0
        }
        return self.products.value.count
    }
    
    private func _isProductsEmpty() -> Bool {
        return self.products.value.isEmpty
    }
    
    private func fetchProductsFromFirebase() {
        RequestManager
            .shared
            .fetchProduct()
            .timeout(30, scheduler: MainScheduler.instance)
            .trackActivity(activityIndicator)
            .subscribe(onNext: { [weak self] (products) in
                guard let strongSelf = self else { return }
                strongSelf.setProducts(products: products)
                }, onError: { (error) in
                    print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
    
    /// Set Methods
    func setProducts(products: [Product]) {
        self.products.value = products
    }
}
