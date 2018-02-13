//
//  NeedleSpeedoViewController.swift
//  Speedometer
//
//  Created by Anirudha on 13/02/18.
//  Copyright © 2018 Anirudha Mahale. All rights reserved.
//

import UIKit

class NeedleSpeedoViewController: UIViewController {

    @IBOutlet weak var speedoView: SpeedoNeedleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func didTapReverse(_ sender: Any) {
        speedoView.reverseTheAnimation()
    }
    
    @IBAction func didTapStart(_ sender: Any) {
        speedoView.startTheAnimation()
    }
}
