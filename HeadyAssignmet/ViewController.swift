//
//  ViewController.swift
//  HeadyAssignmet
//
//  Created by Sandeep on 8/12/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        DispatchQueue.global(qos: .utility).async {
            APIClient.sharedInstance.performAPIRequest(Contants.Url.categories, methodType: .GET, parameters: nil) { (response:Result<CategoryAndRank, Error>) in
                switch response {
                case .success (let value):
                    DispatchQueue.main.async {
                        print(value)
                    }
                    break
                case .failure (let error):
                    DispatchQueue.main.async {
                        print(error)
                    }
                    break
                }
            }
        }
        
    }


}

