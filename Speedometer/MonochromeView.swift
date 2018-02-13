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
    
    // CALayer Properties
    let outerCirclelineWidth: CGFloat = 20
    
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
    
    private func drawOutlineCircle() {
        let layer = CAShapeLayer()
        layer.path = self.createRectangle(startAngle: CGFloat(179.5), endAngle: CGFloat(0.5), radius: self.frame.size.height/2-(outerCirclelineWidth/2))
        layer.lineWidth = outerCirclelineWidth
        layer.strokeColor = UIColor.black.cgColor
        layer.fillColor = UIColor.clear.cgColor
        
        self.layer.addSublayer(layer)
    }
    
    private func drawInnerCircle() {
        let radius = self.frame.size.height/2-(outerCirclelineWidth/2)
        let layer = CAShapeLayer()
        layer.path = self.createRectangle(startAngle: CGFloat(180), endAngle: CGFloat(0.0), radius: radius)
        layer.lineWidth = outerCirclelineWidth-2
        layer.strokeColor = UIColor.yellow.cgColor
        layer.fillColor = UIColor.clear.cgColor
        
        self.layer.addSublayer(layer)
    }
    
    private func configureView() {
        drawOutlineCircle()
        drawInnerCircle()
        sectionDifference = totalSectionSize / numberOfSections
    }
    
    
    private func createRectangle(startAngle: CGFloat, endAngle: CGFloat, radius: CGFloat) -> CGPath {
        // Initialize the path.
        return UIBezierPath(arcCenter: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2), radius: radius, startAngle: startAngle.toRadians(), endAngle: endAngle.toRadians(), clockwise: true).cgPath
    }
    
}
