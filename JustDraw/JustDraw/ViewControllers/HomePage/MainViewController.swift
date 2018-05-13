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
        _setUpCollectionViewLayout()
        _bindingDataToCollectionView()
    }
    
    private func _setUpCollectionViewLayout() {
        collectionViewProducts.dataSource = self
        //        collectionViewProducts.delegate = self
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

// MARK: Extension - PinterestLayoutDelegate
extension MainViewController: PinterestLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForPhotoAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        return 0.0
    }
    
    func collectionView(collectionView: UICollectionView, heightForCaptionAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        return 0.0
    }
}
