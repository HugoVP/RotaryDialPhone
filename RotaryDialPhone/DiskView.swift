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
    private var holes = [CGPoint]()
    
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
    
    func configure(
        holes: [CGPoint],
        holeRadius: CGFloat
    ) {
        
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
            drawCircle(center: hole, radius: model.holeRadius)
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
        
        path.move(to: CGPoint(x: center.x + radius, y: center.y))
        
        path.addCurve(
            to: CGPoint(x: center.x, y: center.y - radius),
            controlPoint1: CGPoint(x: center.x + radius, y: center.y - bzCtrlPt),
            controlPoint2: CGPoint(x: center.x + bzCtrlPt, y: center.y - radius)
        )
        
        path.addCurve(
            to: CGPoint(x: center.x - radius, y: center.y),
            controlPoint1: CGPoint(x: center.x - bzCtrlPt, y: center.y - radius),
            controlPoint2: CGPoint(x: center.x - radius, y: center.y - bzCtrlPt)
        )
        
        path.addCurve(
            to: CGPoint(x: center.x, y: center.y + radius),
            controlPoint1: CGPoint(x: center.x - radius, y: center.y + bzCtrlPt),
            controlPoint2: CGPoint(x: center.x - bzCtrlPt, y: center.y + radius)
        )
        
        path.addCurve(
            to: CGPoint(x: center.x + radius, y: center.y),
            controlPoint1: CGPoint(x: center.x + bzCtrlPt, y: center.y + radius),
            controlPoint2: CGPoint(x: center.x + radius, y: center.y + bzCtrlPt)
        )
    }
}
