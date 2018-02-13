//
//  SpeedoNeedleView.swift
//  Speedometer
//
//  Created by Anirudha on 13/02/18.
//  Copyright © 2018 Anirudha Mahale. All rights reserved.
//

import UIKit

class SpeedoNeedleView: UIView {

    let numberOfSections = 5
    let totalSectionSize = 180
    var sectionDifference = 0
    var layers = [CAShapeLayer]()
    let colors = [UIColor.blue, UIColor.purple, UIColor.green, UIColor.magenta, UIColor.yellow]
    var index = 0
    var reverseAnimation = false
    let duration = 1.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    lazy var needleImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Needle"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    func configureView() {
        self.addSubview(needleImageView)
        
        needleImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        needleImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        needleImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7, constant: 0).isActive = true
        needleImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7, constant: 0).isActive = true
        
        sectionDifference = totalSectionSize / numberOfSections
        animateSpeedometerEntry()
        animateNeedle()
    }
    
    func animateNeedle() {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.fromValue = 0
        animation.toValue = Double.pi
        animation.duration = duration * Double(numberOfSections)
        animation.isRemovedOnCompletion = false
        needleImageView.layer.add(animation, forKey: "end_\(index)")
    }
    
    func animateSpeedometerEntry() {
        while index < numberOfSections {
            let layer = CAShapeLayer()
            layer.path = self.createRectangle(startAngle: CGFloat(180+(index*self.sectionDifference)), endAngle: CGFloat(180+((index+1)*self.sectionDifference))).cgPath
            layer.lineWidth = 10
            layer.strokeColor = self.colors[index].cgColor
            layer.fillColor = UIColor.white.cgColor
            
            self.layer.addSublayer(layer)
            self.layers.append(layer)
            
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0.0
            animation.toValue = 1.0
            animation.duration = duration
            animation.delegate = self
            layer.add(animation, forKey: "end_\(index)")
            index = index + 1
            break
        }
    }
    
    func reverseTheAnimation() {
        index = index - 1
        reverseAnimation = true
        animateSpeedometerExit()
    }
    
    func animateSpeedometerExit() {
        while index > -1 {
            let layer = layers[index]
            
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            if index == sectionDifference {
                animation.beginTime = CACurrentMediaTime() + 2
            }
            animation.fromValue = 1.0
            animation.toValue = 0.0
            animation.duration = duration
            animation.delegate = self
            animation.isRemovedOnCompletion = true
            layer.add(animation, forKey: "end_\(index)")
            index = index - 1
            break
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        configureView()
    }
    
    func createRectangle(startAngle: CGFloat, endAngle: CGFloat) -> UIBezierPath {
        // Initialize the path.
        return UIBezierPath(arcCenter: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2), radius: self.frame.size.height/2-2, startAngle: startAngle.toRadians(), endAngle: endAngle.toRadians(), clockwise: true)
    }
}

extension SpeedoNeedleView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if reverseAnimation {
            animateSpeedometerExit()
        } else {
            animateSpeedometerEntry()
        }
    }
}
