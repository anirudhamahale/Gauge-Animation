//
//  ViewController.swift
//  Speedometer
//
//  Created by Anirudha on 12/02/18.
//  Copyright © 2018 Anirudha Mahale. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var circleView: SpeedoMeterView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func didTapReverse(_ sender: Any) {
        circleView.reverseTheAnimation()
    }
    
}

