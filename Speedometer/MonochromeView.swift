//
//  MonochromeView.swift
//  Speedometer
//
//  Created by Anirudha on 13/02/18.
//  Copyright © 2018 Anirudha Mahale. All rights reserved.
//

import UIKit

class MonochromeView: UIView {
    // MonoChromeArc Properties
    
    let data = [Angle(startAngle: 0, endAngle: 0.3, color: .green),
                Angle(startAngle: 0.30, endAngle: 0.35, color: .yellow),
                Angle(startAngle: 0.35, endAngle: 1.0, color: .red)]
    
    // User Properties
    private var pointToDraw: CGFloat = 0.5
    private var numberOfArcsToBeDrawn = 0
    private var isMonochromBar = false
    
    // CALayer Properties
    private let outerArclineWidth: CGFloat = 20
    private let animationDuration: Double = 3
    
    private var currentIndex = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        configureView()
    }
    
    private func drawOutlineArc() {
        let layer = CAShapeLayer()
        layer.path = self.createRectangle(startAngle: CGFloat(179.5), endAngle: CGFloat(0.5))
        layer.lineWidth = outerArclineWidth
        layer.strokeColor = UIColor.lightGray.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.name = "OutlineArc"
        self.layer.addSublayer(layer)
    }
    
    private func drawInnerArcTest() {
        let layer = CAShapeLayer()
        layer.path = self.createRectangle(startAngle: CGFloat(180), endAngle: CGFloat(0.0))
        layer.lineWidth = outerArclineWidth-2
        layer.strokeColor = UIColor.yellow.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.name = "InnerArcTest"
        self.layer.addSublayer(layer)
    }
    
    func calculateNumberOfArcsRequiredAndDraw() {
        for (index, value) in data.enumerated() {
            if pointToDraw > value.startAngle {
                numberOfArcsToBeDrawn = index+1
            }
        }
        print("numberOfArcsToBeDrawn", numberOfArcsToBeDrawn)
        drawCircles()
    }
    
    func drawCircles() {
        while currentIndex < numberOfArcsToBeDrawn {
            let layer = CAShapeLayer()
            
            if currentIndex == numberOfArcsToBeDrawn-1 {
                layer.path = self.createRectangle(startAngle: getRadians(data[currentIndex].startAngle), endAngle: getRadians(pointToDraw))
            } else {
                layer.path = self.createRectangle(startAngle: getRadians(data[currentIndex].startAngle), endAngle: getRadians(data[currentIndex].endAngle))
            }
            
            layer.lineWidth = outerArclineWidth-2
            if isMonochromBar {
                layer.strokeColor = data[numberOfArcsToBeDrawn-1].color.cgColor
            } else {
                layer.strokeColor = data[currentIndex].color.cgColor
            }
            
            layer.fillColor = UIColor.clear.cgColor
            layer.name = "innerCircle\(currentIndex)"
            self.layer.addSublayer(layer)
            
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0.0
            animation.toValue = 1.0
            animation.duration = getDuration()
            animation.delegate = self
            layer.add(animation, forKey: "end_\(currentIndex)")
            currentIndex = currentIndex + 1
            break
        }
    }
    
    private func getRadians(_ point: CGFloat) -> CGFloat {
        return (180*point)+180
    }
    
    private func getDuration() -> Double {
        if currentIndex == numberOfArcsToBeDrawn-1 {
            let difference = Double(pointToDraw - data[currentIndex].startAngle)
            print(difference*animationDuration)
            return difference * animationDuration
        } else {
            let difference = Double(data[currentIndex].endAngle - data[currentIndex].startAngle)
            print(difference*animationDuration)
            return difference * animationDuration
        }
    }
    
    private func configureView() {
        drawOutlineArc()
        // drawInnerArcTest()
        calculateNumberOfArcsRequiredAndDraw()
    }
    
    private func createRectangle(startAngle: CGFloat, endAngle: CGFloat) -> CGPath {
        // Initialize the path.
        return UIBezierPath(arcCenter: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2), radius: self.frame.size.height/2-(outerArclineWidth/2), startAngle: startAngle.toRadians(), endAngle: endAngle.toRadians(), clockwise: true).cgPath
    }
}

extension MonochromeView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        drawCircles()
    }
}
