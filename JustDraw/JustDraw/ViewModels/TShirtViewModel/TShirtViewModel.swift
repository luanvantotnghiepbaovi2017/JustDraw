//
//  TShirtViewModel.swift
//  JustDraw
//
//  Created by Bao on 5/1/18.
//  Copyright © 2018 TranQuocBao. All rights reserved.
//

import Foundation
import RxSwift

protocol TShirtViewModelType: class {
    var isLoading: Observable<Bool> { get }
    func getProducts() -> Variable<[TShirt]>
}

class TShirtViewModel: TShirtViewModelType {
    // MARK: Properties
    internal var isLoading: Observable<Bool>
    private var activityIndicator: ActivityIndicator!
    private var products: Variable<[TShirt]>!
    private let disposeBag: DisposeBag!
    
    // MARK: Methods
    /// Constructor
    init() {
        products = Variable<[TShirt]>([])
        activityIndicator = ActivityIndicator()
        isLoading = activityIndicator.asObservable()
        disposeBag = DisposeBag()
        fetchProducts()
    }
    
    /// Get Methods
    func getProducts() -> Variable<[TShirt]> {
        return products
    }
    private func fetchProducts() {
        RequestManager
            .shared
            .fetchProduct()
            .timeout(30, scheduler: MainScheduler.instance)
            .trackActivity(activityIndicator)
            .subscribe(onNext: { (products) in
                print(products)
            }, onError: { (error) in
                print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
}
