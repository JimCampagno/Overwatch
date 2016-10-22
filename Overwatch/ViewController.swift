//
//  ViewController.swift
//  Overwatch
//
//  Created by Jim Campagno on 10/21/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let test = Hero(name: .mcCree)
        print(test.realName)
        print(test.affiliations)
        print(test.baseOfOperations)
        print(test.occupation)
        print(test.age)
    }

}
