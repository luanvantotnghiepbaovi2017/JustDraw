//
//  MainViewController.swift
//  JustDraw
//
//  Created by Bao on 5/1/18.
//  Copyright © 2018 TranQuocBao. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class MainViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var collectionViewProducts: UICollectionView!
    
    // MARK: IBActions
    
    // MARK: Properties
    private var viewModel: HomeViewModel!
    private var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel()
        _registerCell()
       // _setUpCollectionViewLayout()
        _bindingDataToCollectionView()
    }
    
    private func _setUpCollectionViewLayout() {
        collectionViewProducts.contentInset = UIEdgeInsetsMake(12, 4, 12, 4)
        if let layout = collectionViewProducts.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
    }
    
    private func _registerCell() {
        let tshirtCell = UINib(nibName: TShirtCell.nibName, bundle: nil)
        collectionViewProducts.register(tshirtCell, forCellWithReuseIdentifier: TShirtCell.nibName)
    }
    
    private func _bindingDataToCollectionView() {
        let dataSource = RxCollectionViewSectionedReloadDataSource<ProductSectionModel>(
            configureCell: {(dataSource, collectionView, indexPath, element) in
                let tshirtCell = collectionView.dequeueReusableCell(withReuseIdentifier: TShirtCell.nibName, for: indexPath) as! TShirtCell
                return tshirtCell
        })
        
        viewModel
            .getProducts()
            .asObservable()
            .debug()
            .asDriver(onErrorJustReturn: [])
            .drive(collectionViewProducts
                .rx
                .items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("didReceiveMemoryWarning - MainViewController")
    }
}

// MARK: Extension - PinterestLayoutDelegate
extension MainViewController: PinterestLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForPhotoAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        return 0.0
    }
    
    func collectionView(collectionView: UICollectionView, heightForCaptionAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        return 0.0
    }
}
