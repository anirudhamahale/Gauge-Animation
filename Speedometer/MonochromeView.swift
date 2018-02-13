//
//  MonochromeView.swift
//  Speedometer
//
//  Created by Anirudha on 13/02/18.
//  Copyright © 2018 Anirudha Mahale. All rights reserved.
//

import UIKit

class MonochromeView: UIView {
    let numberOfSections = 5
    let totalSectionSize = 180
    var sectionDifference = 0
    var isMonochromBar = true
    var layers = [CAShapeLayer]()
    let colors = [UIColor.blue, UIColor.purple, UIColor.green, UIColor.magenta, UIColor.yellow]
    var currentIndex = 0
    let duration = 0.3
    
    // MonoChromeArc Properties
    let monoChromeColor: [UIColor] = [.green, // percentage <= 30
                                      .yellow, // percentage between 31 - 35
                                      .red // percentage > 36
    ]
    
    // CALayer Properties
    let outerArclineWidth: CGFloat = 20
    
    
    
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
        layer.strokeColor = UIColor.black.cgColor
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
    
    func drawThreeCircles() {
        let startAngle: [CGFloat] = [180, 234, 243]
        let endAngle: [CGFloat] = [234, 243, 0.0]
        for i in 0...2 {
            let layer = CAShapeLayer()
            layer.path = self.createRectangle(startAngle: startAngle[i], endAngle: endAngle[i])
            layer.lineWidth = outerArclineWidth-2
            layer.strokeColor = monoChromeColor[i].cgColor
            layer.fillColor = UIColor.clear.cgColor
            layer.name = "innerCircle\(i)"
            self.layer.addSublayer(layer)
        }
    }
    
    private func configureView() {
        drawOutlineArc()
        // drawInnerArcTest()
        drawThreeCircles()
        sectionDifference = totalSectionSize / numberOfSections
    }
    
    private func createRectangle(startAngle: CGFloat, endAngle: CGFloat) -> CGPath {
        // Initialize the path.
        return UIBezierPath(arcCenter: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2), radius: self.frame.size.height/2-(outerArclineWidth/2), startAngle: startAngle.toRadians(), endAngle: endAngle.toRadians(), clockwise: true).cgPath
    }
    
}
