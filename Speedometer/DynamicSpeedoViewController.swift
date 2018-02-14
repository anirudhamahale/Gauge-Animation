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
    
    var value: CGFloat = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "\(Int(slider.value))"
    }
    
    @IBAction func didSlide(_ sender: UISlider) {
        label.text = "\(Int(sender.value))"
        value = CGFloat(sender.value)
    }
    
    @IBAction func changedSwitch(_ sender: UISwitch) {
        if sender.isOn {
            spView.configureView(with: getValue(), isMonoChrome: true)
        } else {
            spView.configureView(with: getValue(), isMonoChrome: false)
        }
    }
    
    @IBAction func didTapAnimate(_ sender: UIButton) {
        spView.configureView(with: getValue(), isMonoChrome: monoSwitch.isOn ? true : false)
    }
    
    
    /// Round the decimal places to 2 points and return CGFloat
    ///
    /// - Returns: CGFloat with 2 decimal places
    func getValue() -> CGFloat {
        let dividedValue = value / 100
        let y =  Double(round(100*dividedValue)/100)
        print("point ", CGFloat(y))
        return CGFloat(y)
    }
}
