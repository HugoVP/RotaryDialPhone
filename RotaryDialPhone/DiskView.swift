//
//  CircleView.swift
//  RotaryDialPhone
//
//  Created by Hugo on 08/09/17.
//
//

import UIKit

class DiskView: UIView, CircleView {
    private var _holes = [CGPoint]()
    private var _holeRadius: CGFloat!
    private var _distanceFromHolesToCenter: CGFloat!
    
    private var innerRadius: CGFloat {
        return 2.0 * distanceFromHolesToCenter - bounds.midX
    }
    
    var path: UIBezierPath!
    
    var holes: [CGPoint] {
        return _holes
    }
    
    var holeRadius: CGFloat {
        return _holeRadius
    }
    
    var distanceFromHolesToCenter: CGFloat {
        return _distanceFromHolesToCenter
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(
        holes: [CGPoint],
        holeRadius: CGFloat,
        distanceFromHolesToCenter: CGFloat
    ) {
        _holes = holes
        _holeRadius = holeRadius
        _distanceFromHolesToCenter = distanceFromHolesToCenter
        circleLayer()
    }
    
    func circleLayer() {
        /* Set path */
        path = UIBezierPath()
        
        /* Outter circle */
        drawCircle(
            center: CGPoint(
                x: bounds.midX,
                y: bounds.midY
            ),
            radius: bounds.width > bounds.height ? bounds.midY : bounds.midX
        )
        
        /* Inner circle */
        drawCircle(
            center: CGPoint(
                x: bounds.midX,
                y: bounds.midY
            ),
            radius: innerRadius
        )
        
        /* Holes */
        holes.forEach { (hole) in
            drawCircle(center: hole, radius: holeRadius)
        }
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.darkGray.cgColor
        shapeLayer.fillRule = kCAFillRuleEvenOdd
        shapeLayer.path = path.cgPath
        layer.mask = shapeLayer
//         layer.addSublayer(shapeLayer)
    }
}
