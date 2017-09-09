//
//  CircleView.swift
//  RotaryDialPhone
//
//  Created by Hugo on 08/09/17.
//
//

import UIKit

class DiskView: UIView {
    private var _model: RotaryDial!
    
    let bz: CGFloat = 0.55228
    var path: UIBezierPath!
    
    var model: RotaryDial {
        return _model
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setModel(_ model: RotaryDial) {
        _model = model
        backgroundColor = .darkGray
        circleLayer()
    }
    
    func circleLayer() {
        setPath()
        
        drawCircle(
            center: CGPoint(
                x: bounds.midX,
                y: bounds.midY
            ),
            radius: bounds.width > bounds.height ? bounds.midY : bounds.midX
        )
        
        model.holes.forEach { (hole) in
            let shape = UIView(
                frame: CGRect(
                    x: hole.x - model.holesSize / 2.0,
                    y: hole.y - model.holesSize / 2.0,
                    width: model.holesSize,
                    height: model.holesSize
                )
            )
            
            shape.layer.cornerRadius = shape.bounds.midX
            shape.clipsToBounds = true
            shape.layer.borderColor = UIColor.red.cgColor
            shape.layer.borderWidth = 1.0
            addSubview(shape)
        }
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.lightGray.cgColor
        shapeLayer.fillRule = kCAFillRuleEvenOdd
        shapeLayer.path = path.cgPath
        layer.mask = shapeLayer
//         layer.addSublayer(shapeLayer)
    }
    
    func setPath() {
        path = UIBezierPath()
    }
    
    func drawCircle(center: CGPoint, radius: CGFloat) {
        let bzCtrlPt = bz * radius
        let val1 = center.x + radius
        let val2 = center.x
        let val3 = center.x - radius
        let val4 = center.x - bzCtrlPt
        let val5 = center.x + bzCtrlPt
        
        path.move(to: CGPoint(x: val1, y: val2))
        
        path.addCurve(
            to: CGPoint(x: val2, y: val3),
            controlPoint1: CGPoint(x: val1, y: val4),
            controlPoint2: CGPoint(x: val5, y: val3)
        )
        
        path.addCurve(
            to: CGPoint(x: val3, y: val2),
            controlPoint1: CGPoint(x: val4, y: val3),
            controlPoint2: CGPoint(x: val3, y: val4)
        )
        
        path.addCurve(
            to: CGPoint(x: val2, y: val1),
            controlPoint1: CGPoint(x: val3, y: val5),
            controlPoint2: CGPoint(x: val4, y: val1)
        )
        
        path.addCurve(
            to: CGPoint(x: val1, y: val2),
            controlPoint1: CGPoint(x: val5, y: val1),
            controlPoint2: CGPoint(x: val1, y: val5)
        )
    }
}
