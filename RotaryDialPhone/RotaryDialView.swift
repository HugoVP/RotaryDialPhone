//
//  DiskImageView2.swift
//  RotaryDialPhone
//
//  Created by Hugo on 15/09/17.
//
//

import UIKit

class RotaryDialView: UIImageView, RotaryDialModel {
    var path: UIBezierPath!
    var numberFontSize: CGFloat!
    
    var holesRadius: CGFloat!
    var distanceFromHolesToCenter: CGFloat!
    var holesSeparationAngle: CGFloat!
    var firstHoleAngle: CGFloat!
}

extension RotaryDialView: CirclePath {
    func drawNumpad() {
        /* Set path */
        path = UIBezierPath()
        
        /* Numpad Circle */
        drawCircle(
            center: CGPoint(
                x: bounds.midX,
                y: bounds.midY
            ),
            radius: bounds.width > bounds.height ? bounds.midY : bounds.midX
        )
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        
        
        if let backgroundColor = backgroundColor?.cgColor {
            shapeLayer.fillColor = backgroundColor
        } else {
            shapeLayer.fillColor = UIColor.darkGray.cgColor
        }
        
        shapeLayer.strokeColor = UIColor.darkGray.cgColor
        shapeLayer.lineWidth = 1.0
        backgroundColor = .clear
        layer.addSublayer(shapeLayer)
        
        /* Numbers */
        for index in 0 ..< holesCount {
            let textLayer = CATextLayer()
            textLayer.string = "\(number(index))"
            textLayer.backgroundColor = UIColor.white.cgColor
            textLayer.foregroundColor = UIColor.darkGray.cgColor
            textLayer.font = UIFont(name: "Avenir Next", size: numberFontSize)
            textLayer.fontSize = numberFontSize
            textLayer.alignmentMode = kCAAlignmentCenter
            let hole = self.hole(index)
            
            textLayer.frame = CGRect(
                x: hole.x + bounds.midX - bounds.midX - holesRadius,
                y: hole.y + bounds.midY - bounds.midY - holesRadius,
                width: holesRadius * 2.0,
                height: holesRadius * 2.0
            )
            
            textLayer.cornerRadius = textLayer.bounds.midX
            textLayer.contentsScale = UIScreen.main.scale
            layer.addSublayer(textLayer)
        }
    }
    
    func drawDisk() {
        /* Set path */
        path = UIBezierPath()
        
        /* Outter circle path */
        drawCircle(
            center: CGPoint(
                x: bounds.midX,
                y: bounds.midY
            ),
            radius: bounds.width > bounds.height ? bounds.midY : bounds.midX
        )
        
        /* Inner circle path */
        drawCircle(
            center: CGPoint(
                x: bounds.midX,
                y: bounds.midY
            ),
            radius: innerRadius
        )
        
        /* Holes paths */
        for index in 0 ..< holesCount {
            drawCircle(center: hole(index), radius: holesRadius)
        }
        
        /* Drawing the disk holes */
        
        let shapeLayer = CAShapeLayer()
        
        /* Get the background color to set the fill color */
        if let backgroundColor = backgroundColor?.cgColor {
            shapeLayer.fillColor = backgroundColor
        } else {
            shapeLayer.fillColor = UIColor.darkGray.cgColor
        }
        
        backgroundColor = .clear
        shapeLayer.fillRule = kCAFillRuleEvenOdd
        shapeLayer.strokeColor = UIColor.darkGray.cgColor
        shapeLayer.lineWidth = 1.0
        shapeLayer.path = path.cgPath
        layer.addSublayer(shapeLayer)
    }
    
    private var innerRadius: CGFloat {
        return 2.0 * distanceFromHolesToCenter - bounds.midX
    }
}