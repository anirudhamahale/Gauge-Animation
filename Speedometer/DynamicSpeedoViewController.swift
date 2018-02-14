//
//  DynamicSpeedoViewController.swift
//  Speedometer
//
//  Created by Anirudha on 13/02/18.
//  Copyright © 2018 Anirudha Mahale. All rights reserved.
//

import UIKit

class DynamicSpeedoViewController: UIViewController {

    @IBOutlet weak var spView: MonochromeView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var monoSwitch: UISwitch!
    
    var value: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        value = CGFloat(slider.value)
        label.text = "\(Int(slider.value))"
    }
    
    @IBAction func didSlide(_ sender: UISlider) {
        label.text = "\(Int(sender.value))"
        value = CGFloat(sender.value)
    }
    
    @IBAction func changedSwitch(_ sender: UISwitch) {
        let newValue = value/100
        if sender.isOn {
            spView.configureView(with: newValue, isMonoChrome: true)
        } else {
            spView.configureView(with: newValue, isMonoChrome: false)
        }
    }
    
    @IBAction func didTapAnimate(_ sender: UIButton) {
        let newValue = value/100
        spView.configureView(with: newValue, isMonoChrome: monoSwitch.isOn ? true : false)
    }
}
