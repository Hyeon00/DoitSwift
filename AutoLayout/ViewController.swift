//
//  ViewController.swift
//  AutoLayout
//
//  Created by 임성현 on 2020/06/16.
//  Copyright © 2020 임성현. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imgView: UIImageView!
    
    let img = UIImage(named: "01.png")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imgView.image = img
    }


}

