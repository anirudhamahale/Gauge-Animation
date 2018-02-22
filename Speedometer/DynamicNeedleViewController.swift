//
//  DynamicNeedleViewController.swift
//  Speedometer
//
//  Created by Anirudha on 22/02/18.
//  Copyright © 2018 Anirudha Mahale. All rights reserved.
//

import UIKit

class DynamicNeedleViewController: UIViewController {

    @IBOutlet weak var needleImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = CGFloat(0).toRadians()
        animation.toValue = CGFloat(157).toRadians()
        animation.duration = 1
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        // animation.delegate = self
        needleImageView.layer.add(animation, forKey: nil)
    }
    
    @IBAction func didTapAnimate(_ sender: Any) {
        animate()
    }
    
    func animate() {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = CGFloat(157).toRadians()
        animation.toValue = CGFloat(382).toRadians()
        animation.duration = 1
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        // animation.delegate = self
        needleImageView.layer.add(animation, forKey: nil)
    }
}
