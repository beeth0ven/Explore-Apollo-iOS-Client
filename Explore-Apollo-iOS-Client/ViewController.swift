//
//  ViewController.swift
//  Explore-Apollo-iOS-Client
//
//  Created by luojie on 2018/3/11.
//  Copyright © 2018年 luojie. All rights reserved.
//

import UIKit
import Apollo

class ViewController: UIViewController {

    let apollo = ApolloClient(url: URL(string: "https://home.beeth0ven.cf:3000/graphql")!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = apollo.watch(query: QueryQuery()) { (result, error) in
            guard error == nil else {
                print("error: \(error!)")
                return
            }
            print("result: \(result!)")
        }
    }
}

