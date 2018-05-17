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
import PKHUD
import WaterfallLayout

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
        _bindingDataToCollectionView()
    }
    
    private func _registerCell() {
        let layout = WaterfallLayout()
        layout.delegate = self
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        collectionViewProducts.collectionViewLayout = layout
        let tshirtCell = UINib(nibName: TShirtCell.nibName, bundle: nil)
        collectionViewProducts.register(tshirtCell, forCellWithReuseIdentifier: TShirtCell.nibName)
        collectionViewProducts.dataSource = self
    }
    
    private func _bindingDataToCollectionView() {
        viewModel
            .isLoading
            .subscribe (onNext: { [weak self] visible in
                guard let strongSelf = self else { return }
                PKHUD.sharedHUD.contentView = PKHUDSystemActivityIndicatorView()
                visible ? PKHUD.sharedHUD.show() : PKHUD.sharedHUD.hide()
                if !visible {
                    strongSelf.collectionViewProducts.reloadData()
                }
            })
            .disposed(by: disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("didReceiveMemoryWarning - MainViewController")
    }
}

// MARK: Extension - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getCountOfProducts()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if let tshirt = viewModel.getProduct(at: indexPath) as? TShirt {
            let tshirtCell = collectionView.dequeueReusableCell(withReuseIdentifier: TShirtCell.nibName, for: indexPath) as! TShirtCell
            tshirtCell.tshirtViewModel = TShirtViewModel(tshirt: tshirt)
            return tshirtCell
        }
        return UICollectionViewCell()
    }
}

// MARK: Extension - WaterfallLayoutDelegate
extension MainViewController: WaterfallLayoutDelegate {
    func collectionViewLayout(for section: Int) -> WaterfallLayout.Layout {
        return .waterfall(column: 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: WaterfallLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let tshirt = viewModel.getProduct(at: indexPath) as? TShirt else { return CGSize(width: 0, height: 0) }
        let tshirtViewModel = TShirtViewModel(tshirt: tshirt)
        let itemHeight = tshirtViewModel.productMainImageHeight + tshirtViewModel.textHeight
        let itemWidth = (collectionView.bounds.width - (5.0 * 2)) / 2.0
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
