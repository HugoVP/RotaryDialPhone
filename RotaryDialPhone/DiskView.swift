//
//  DiskImageView.swift
//  RotaryDialPhone
//
//  Created by Hugo on 19/12/17.
//

import UIKit

/* Attributes */
@IBDesignable
class DiskView: UIView, RotaryDialViewProtocol {
  var path: UIBezierPath!
  
  @IBInspectable var fillColor: UIColor = .clear
  
  @IBInspectable var holesCount: Int = 10
  @IBInspectable var holesRadius: CGFloat = 25.0
  @IBInspectable var distanceFromHolesToCenter: CGFloat = 115.0
  @IBInspectable var holesSeparationAngle: CGFloat = CGFloat.M_2_PI / 11.5
  @IBInspectable var firstHoleAngle: CGFloat = CGFloat.M_2_PI / 11.5 * 1.25
  var lockAngle: CGFloat = CGFloat.M_2_PI / 11.5 * 0.25
  
  @IBInspectable var outterBound: CGFloat = 8
  @IBInspectable var innerBound: CGFloat = 8
  
  private var outterRadius: CGFloat {
    return distanceFromHolesToCenter + holesRadius + outterBound
  }
  
  private var innerRadius: CGFloat! {
    return distanceFromHolesToCenter - holesRadius - innerBound
  }
  
  var number: ((Int) -> Int)! = { (index) in index }
}

extension DiskView: CirclePath, RedrawableView {
  override func draw(_ rect: CGRect) {
    /* Set path */
    path = UIBezierPath()
    
    /* Outter circle path */
    drawCircle(
      center: CGPoint(
        x: rect.midX,
        y: rect.midY
      ),
      radius: outterRadius
    )
    
    /* Inner circle path */
    drawCircle(
      center: CGPoint(
        x: rect.midX,
        y: rect.midY
      ),
      radius: innerRadius
    )
    
    /* Holes paths */
    for index in 0 ..< holesCount {
      drawCircle(center: hole(index), radius: holesRadius)
    }
    
    /* Drawing the disk holes */
    
    let shapeLayer = CAShapeLayer()
    shapeLayer.fillColor = fillColor.cgColor
    shapeLayer.fillRule = kCAFillRuleEvenOdd
    shapeLayer.strokeColor = UIColor.darkGray.cgColor
    shapeLayer.lineWidth = 1.0
    shapeLayer.path = path.cgPath
    backgroundColor = .clear

    layer.addSublayer(shapeLayer)
  }
}
