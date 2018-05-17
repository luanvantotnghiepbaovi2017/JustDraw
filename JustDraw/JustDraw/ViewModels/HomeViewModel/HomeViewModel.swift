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
    private struct CollectionViewSettings {
        static let padding8: CGFloat = 8.0
        static let padding16: CGFloat = 16.0
    }
    
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
    
    /// Set Methods
    func setProducts(products: [Product]) {
        self.products.value = products
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
            .subscribe(onNext: { [weak self] (tempProducts) in
                guard let strongSelf = self else { return }
                var products: [Product] = [Product]()
                let cellPadding: CGFloat  = 5.0
                let columnWidth = Constant.CollectionView.Home.contentWidth / Constant.CollectionView.Home.numberOfColumns
                let width = columnWidth - cellPadding * 2
                let productPriceHeight: CGFloat = 25.0
                let productReviewImageHeight: CGFloat = 20.0
                let productStoreAddressheight: CGFloat = 18.0
                for product in tempProducts {
                    if let tshirt = product as? TShirt {
                        let tshirtViewModel = TShirtViewModel(tshirt: tshirt)
                        let productTitleHeight = Helper.height(for: tshirtViewModel.nameText, with: Constant.Font.AvenirNextMedium15, width: width)
                        var productDiscountedPriceHeight: CGFloat = 0.0
                        if !tshirtViewModel.productIsNotDiscounted() {
                            productDiscountedPriceHeight = 18.0
                        }
                        tshirt.textHeight = CollectionViewSettings.padding8 + productTitleHeight + CollectionViewSettings.padding8 + productPriceHeight + CollectionViewSettings.padding8 + productDiscountedPriceHeight + CollectionViewSettings.padding16 + productReviewImageHeight + CollectionViewSettings.padding8 + productStoreAddressheight
                        products.append(tshirt)
                    }
                }
                strongSelf.setProducts(products: products)
                }, onError: { (error) in
                    print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
}
