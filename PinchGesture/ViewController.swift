//
//  ViewController.swift
//  PinchGesture
//
//  Created by 임성현 on 2020/07/29.
//  Copyright © 2020 임성현. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imgPinch: UIImageView!
    
    // 핀치 제스처가 발생했을 때 현재 글자 크기 저장.
    var initialFontSize: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(ViewController.doPinch(_:)))
        self.view.addGestureRecognizer(pinch)
    }
    
    
    @objc func doPinch(_ pinch: UIPinchGestureRecognizer) {
        // pinch 제스처의 상태를 state 속성을 사용하여 확인.
        /*
        if pinch.state == UIGestureRecognizer.State.began {
            initialFontSize = txtPinch.font.pointSize
        } else {
            txtPinch.font = txtPinch.font.withSize(initialFontSize * pinch.scale)
        }
        */
        
        imgPinch.transform = imgPinch.transform.scaledBy(x: pinch.scale, y: pinch.scale)
        pinch.scale = 1
    }
    
}

