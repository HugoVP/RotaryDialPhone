//
//  numpadView.swift
//  RotaryDialPhone
//
//  Created by Hugo on 10/09/17.
//
//

import UIKit

class NumpadView: UIView, CirclePath {
    var path: UIBezierPath!
    
    private var diskCenter: CGPoint!
    private var diskRadius: CGFloat!
    private var holes: [CGPoint]!
    private var holeRadius: CGFloat!
    private var numberFontSize: CGFloat!
    
    private var holeDiameter: CGFloat {
        return 2.0 * holeRadius
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(
        diskRadius: CGFloat,
        diskCenter: CGPoint,
        holes: [CGPoint],
        holeRadius: CGFloat,
        numberFontSize: CGFloat
        ) {
        self.diskRadius = diskRadius
        self.diskCenter = diskCenter
        self.holes = holes
        self.holeRadius = holeRadius
        self.numberFontSize = numberFontSize
        numpadLayer()
    }
    
    func numpadLayer() {
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
        holes.enumerated().forEach { (index, hole) in
//            path = UIBezierPath()
//            
//            drawCircle(
//                center: CGPoint(
//                    x: hole.x + bounds.midX - diskRadius,
//                    y: hole.y + bounds.midY - diskRadius
//                ),
//                radius: holeRadius
//            )
//
//            let shapeLayer = CAShapeLayer()
//            shapeLayer.path = path.cgPath
//            shapeLayer.fillColor = UIColor.white.cgColor
//            layer.addSublayer(shapeLayer)
            
            let textLayer = CATextLayer()
            textLayer.string = "\(index)"
            textLayer.backgroundColor = UIColor.white.cgColor
            textLayer.foregroundColor = UIColor.darkGray.cgColor
            textLayer.font = UIFont(name: "Avenir Next", size: numberFontSize)
            textLayer.fontSize = numberFontSize
            textLayer.alignmentMode = kCAAlignmentCenter
            
            textLayer.frame = CGRect(
                x: hole.x + bounds.midX - diskCenter.x - holeRadius,
                y: hole.y + bounds.midY - diskCenter.y - holeRadius,
                width: holeDiameter,
                height: holeDiameter
            )
            
            textLayer.cornerRadius = textLayer.bounds.midX
            textLayer.contentsScale = UIScreen.main.scale
            layer.addSublayer(textLayer)
        }
    }
}
