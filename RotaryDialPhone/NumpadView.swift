//
//  numpadView.swift
//  RotaryDialPhone
//
//  Created by Hugo on 10/09/17.
//
//

import UIKit

class NumpadView: UIView {
    var path: UIBezierPath!
    var model: RotaryDial!
    var numberFontSize: CGFloat!
}

extension NumpadView: CirclePath {
    func draw() {
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
        model.holes.enumerated().forEach { (index, hole) in
            let textLayer = CATextLayer()
            textLayer.string = "\(model.numbers[index])"
            textLayer.backgroundColor = UIColor.white.cgColor
            textLayer.foregroundColor = UIColor.darkGray.cgColor
            textLayer.font = UIFont(name: "Avenir Next", size: numberFontSize)
            textLayer.fontSize = numberFontSize
            textLayer.alignmentMode = kCAAlignmentCenter
            
            textLayer.frame = CGRect(
                x: hole.x + bounds.midX - model.center.x - model.holeRadius,
                y: hole.y + bounds.midY - model.center.y - model.holeRadius,
                width: model.holeRadius * 2.0,
                height: model.holeRadius * 2.0
            )
            
            textLayer.cornerRadius = textLayer.bounds.midX
            textLayer.contentsScale = UIScreen.main.scale
            layer.addSublayer(textLayer)
        }
    }
}
