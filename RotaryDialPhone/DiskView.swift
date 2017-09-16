//
//  CircleView.swift
//  RotaryDialPhone
//
//  Created by Hugo on 08/09/17.
//
//

import UIKit

class DiskView: UIView {
    var path: UIBezierPath!
    var model: RotaryDial!
}

extension DiskView: CirclePath {
    private var innerRadius: CGFloat {
        return 2.0 * model.distanceFromHolesToCenter - bounds.midX
    }
    
    func draw() {
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
        model.holes.forEach { (hole) in
            drawCircle(center: hole, radius: model.holeRadius)
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
}
