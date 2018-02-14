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
    
    var data = [Angle(startAngle: 0.0, endAngle: 0.30, color: .green, duration: 1.0),
                Angle(startAngle: 0.31, endAngle: 0.35, color: .yellow, duration: 1.0),
                Angle(startAngle: 0.36, endAngle: 1.0, color: .red, duration: 1.0)]
    
    // User Properties
    private var pointToDraw: CGFloat = 0.5
    private var numberOfArcsToBeDrawn = 0
    private var isMonochromBar = false
    
    // CALayer Properties
    private let outerArclineWidth: CGFloat = 20
    private let animationDuration: Double = 1
    private var previousStartAngle: CGFloat = 0.0
    
    private var currentIndex = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        configureView(with: 0.5, isMonoChrome: false)
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
    
    private func calculateNumberOfArcsRequiredAndDraw() {
        for (index, value) in data.enumerated() {
            if pointToDraw > value.startAngle {
                // Since the index is starting from 0, doing +1
                numberOfArcsToBeDrawn = index+1
            }
        }
        
        print("numberOfArcsToBeDrawn", numberOfArcsToBeDrawn)
        calculateDurationSlots()
        drawCircles()
    }
    
    private func calculateDurationSlots() {
        let percentage = animationDuration/Double(pointToDraw*100)
        for index in 0...numberOfArcsToBeDrawn-1 {
            if pointToDraw < data[index].endAngle && pointToDraw > data[index].startAngle {
                let difference = pointToDraw*100-data[index].startAngle*100
                let duration = Double(difference) * percentage
                data[index].duration = duration
            } else {
                let difference = data[index].endAngle*100 - data[index].startAngle*100
                let duration = Double(difference) * percentage
                data[index].duration = duration
            }
        }
    }
    
    private func drawCircles() {
        while currentIndex < numberOfArcsToBeDrawn {
            let layer = CAShapeLayer()
            let currentData = data[currentIndex]
            if currentIndex == numberOfArcsToBeDrawn-1 {
                layer.path = self.createRectangle(startAngle: getRadians(previousStartAngle), endAngle: getRadians(pointToDraw))
            } else {
                layer.path = self.createRectangle(startAngle: getRadians(previousStartAngle), endAngle: getRadians(currentData.endAngle))
            }
            previousStartAngle = data[currentIndex].endAngle
            layer.lineWidth = outerArclineWidth-2
            if isMonochromBar {
                layer.strokeColor = data[numberOfArcsToBeDrawn-1].color.cgColor
            } else {
                layer.strokeColor = currentData.color.cgColor
            }
            
            layer.fillColor = UIColor.clear.cgColor
            layer.name = "innerCircle\(currentIndex)"
            self.layer.addSublayer(layer)
            
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0.0
            animation.toValue = 1.0
            animation.duration = currentData.duration
            animation.delegate = self
            layer.add(animation, forKey: "end_\(currentIndex)")
            currentIndex = currentIndex + 1
            break
        }
    }
    
    private func getRadians(_ point: CGFloat) -> CGFloat {
        return (180*point)+180
    }
    
    public func configureView(with point: CGFloat, isMonoChrome: Bool) {
        self.layer.sublayers?.removeAll()
        resetViews()
        pointToDraw = point
        isMonochromBar = isMonoChrome
        drawOutlineArc()
        calculateNumberOfArcsRequiredAndDraw()
    }
    
    private func createRectangle(startAngle: CGFloat, endAngle: CGFloat) -> CGPath {
        // Initialize the path.
        return UIBezierPath(arcCenter: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2), radius: self.frame.size.height/2-(outerArclineWidth/2), startAngle: startAngle.toRadians(), endAngle: endAngle.toRadians(), clockwise: true).cgPath
    }
    
    private func resetViews() {
        pointToDraw = 0.5
        numberOfArcsToBeDrawn = 0
        isMonochromBar = false
        currentIndex = 0
        previousStartAngle = 0.0
    }
}

extension MonochromeView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        drawCircles()
    }
}
