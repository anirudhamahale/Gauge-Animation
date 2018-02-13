//
//  DynamicSpeedoViewController.swift
//  Speedometer
//
//  Created by Anirudha on 13/02/18.
//  Copyright © 2018 Anirudha Mahale. All rights reserved.
//

import UIKit

class DynamicSpeedoViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var spView: MonochromeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = "50"
    }
    
    @IBAction func changedSwitch(_ sender: UISwitch) {
        let value = Float(textField.text!)!/100
        print(value)
        if sender.isOn {
            spView.configureView(with: CGFloat(value), isMonoChrome: true)
        } else {
            spView.configureView(with: CGFloat(value), isMonoChrome: false)
        }
    }
}
