//
//  DiskImageView.swift
//  RotaryDialPhone
//
//  Created by Hugo on 19/12/17.
//

import UIKit

/* Attributes */
class DiskImageView: UIImageView, RotaryDialViewProtocol {
  var path: UIBezierPath!
  
  var holesCount: Int!
  var holesRadius: CGFloat!
  var distanceFromHolesToCenter: CGFloat!
  var holesSeparationAngle: CGFloat!
  var firstHoleAngle: CGFloat!
  
  var lockAngle: CGFloat!
  var number: ((Int) -> Int)!
}

extension DiskImageView: CirclePath {
  private var innerRadius: CGFloat {
    return 2.0 * distanceFromHolesToCenter - bounds.midX
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
}
