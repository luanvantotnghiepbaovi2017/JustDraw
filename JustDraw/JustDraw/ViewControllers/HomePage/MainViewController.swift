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

class MainViewController: UIViewController {

    // MARK: IBOutlets
    
    // MARK: IBActions
    
    // MARK: Properties
    private var viewModel: TShirtViewModel!
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = TShirtViewModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("didReceiveMemoryWarning - MainViewController")
    }
}
