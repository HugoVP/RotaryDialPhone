//
//  LockImageView.swift
//  RotaryDialPhone
//
//  Created by Hugo on 22/12/17.
//

import UIKit

@IBDesignable
class LockView: RotaryDialElementView {

}

extension LockView: RedrawableView {
  override func draw(_ rect: CGRect) {
    let hole = CGPoint(
      x: distanceFromHolesToCenter * cos(lockAngle) + rect.midX,
      y: distanceFromHolesToCenter * sin(lockAngle) + rect.midY
    )
    
    let path = UIBezierPath(
      ovalIn: CGRect(
        x: hole.x - holesRadius,
        y: hole.y - holesRadius,
        width: holesRadius * 2.0,
        height: holesRadius * 2.0
      )
    )
    
    let shapeLayer = CAShapeLayer()
    shapeLayer.fillColor = UIColor.clear.cgColor // fillColor.cgColor
    shapeLayer.fillRule = kCAFillRuleEvenOdd
    shapeLayer.strokeColor = UIColor.darkGray.cgColor
    shapeLayer.lineWidth = 1.0
    shapeLayer.path = path.cgPath
    backgroundColor = .clear
    
    layer.addSublayer(shapeLayer)
  }
}
