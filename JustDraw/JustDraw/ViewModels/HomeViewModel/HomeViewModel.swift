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
    func getProducts() -> Variable<[ProductSectionModel]>
    func setProducts(products: [ProductSectionModel])
    func getProduct(at indexPath: IndexPath) -> Product?
}

class HomeViewModel: HomeViewModelType {
    // MARK: Properties
    internal var isLoading: Observable<Bool>
    private var activityIndicator: ActivityIndicator!
    private var products: Variable<[ProductSectionModel]>!
    private let disposeBag: DisposeBag!
    
    // MARK: Methods
    /// Constructor
    init() {
        products = Variable<[ProductSectionModel]>([])
        activityIndicator = ActivityIndicator()
        isLoading = activityIndicator.asObservable()
        disposeBag = DisposeBag()
        fetchProductsFromFirebase()
    }
    
    /// Get Methods
    func getProducts() -> Variable<[ProductSectionModel]> {
        return products
    }
    
    func getProduct(at indexPath: IndexPath) -> Product? {
        if self.products.value.isEmpty {
            return nil
        }
        if self.products.value[indexPath.section].items.isEmpty {
            return nil
        }
        return self.products.value[indexPath.section].items[indexPath.item]
    }
    
    private func fetchProductsFromFirebase() {
        RequestManager
            .shared
            .fetchProduct()
            .timeout(30, scheduler: MainScheduler.instance)
            .trackActivity(activityIndicator)
            .subscribe(onNext: { [weak self] (products) in
                guard let strongSelf = self else { return }
                let productSectionModel = ProductSectionModel(items: products)
                strongSelf.setProducts(products: [productSectionModel])
                }, onError: { (error) in
                    print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
    
    /// Set Methods
    func setProducts(products: [ProductSectionModel]) {
        self.products.value = products
    }
}
