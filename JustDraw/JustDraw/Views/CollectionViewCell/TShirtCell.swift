//
//  TShirtCell.swift
//  JustDraw
//
//  Created by Bao on 5/6/18.
//  Copyright © 2018 TranQuocBao. All rights reserved.
//

import UIKit
import Kingfisher

class TShirtCell: UICollectionViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var imageViewProduct: UIImageView!
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelProductPrice: UILabel!
    @IBOutlet weak var labelProductDiscountPrice: UILabel!
    @IBOutlet weak var labelProductDiscountInfo: UILabel!
    @IBOutlet weak var imageViewProductStarReview: UIImageView!
    @IBOutlet weak var labelProductReviewCount: UILabel!
    @IBOutlet weak var labelProductStoreAddress: UILabel!
    // MARK: IBOutlets - NSLayoutConstraint
    @IBOutlet weak var heightConstraintImageViewProduct: NSLayoutConstraint!
    
    // MARK: IBActions
    
    // MARK: Properties
    var tshirtViewModel: TShirtViewModel! {
        didSet {
            _configureCell()
        }
    }
    
    // MARK: Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes)
    {
        super.apply(layoutAttributes)
        if let attributes = layoutAttributes as? PinterestLayoutAttributes {
            // - change the image height
            heightConstraintImageViewProduct.constant = attributes.photoHeight
        }
    }
    
    private func _configureCell() {
        labelProductName.text = tshirtViewModel.nameText
        labelProductPrice.text = tshirtViewModel.priceText
        labelProductDiscountPrice.text = tshirtViewModel.discountPriceText
        labelProductDiscountInfo.text = tshirtViewModel.discountInfoText
        labelProductReviewCount.text = tshirtViewModel.reviewText
        labelProductStoreAddress.text = tshirtViewModel.storeAddressText
        imageViewProduct.kf.indicatorType = .activity
        imageViewProduct.kf.setImage(with: tshirtViewModel.productImage)
    }
}
