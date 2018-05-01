//
//  MainViewController.swift
//  JustDraw
//
//  Created by Bao on 5/1/18.
//  Copyright © 2018 TranQuocBao. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController {

    // MARK: IBOutlets
    
    // MARK: IBActions
    
    // MARK: Properties
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProduct()
    }
    
    func fetchProduct() {
        let database = NRDatabaseProvider<FirebaseEndPoint>()
        database.request(.getProduct()) { result in
            switch result {
            case .success(let response):
                let snapshot = response.snapshot
                print(snapshot ?? "Failed to load data")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("didReceiveMemoryWarning - MainViewController")
    }
}
