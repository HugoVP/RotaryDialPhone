//
//  NumpadImageView.swift
//  RotaryDialPhone
//
//  Created by Hugo on 19/12/17.
//

import UIKit

/* Attributes */
class NumpadImageView: UIImageView, RotaryDialViewProtocol {
  var path: UIBezierPath!
  var numberFontSize: CGFloat!
  
  var holesCount: Int!
  var holesRadius: CGFloat!
  var distanceFromHolesToCenter: CGFloat!
  var holesSeparationAngle: CGFloat!
  var firstHoleAngle: CGFloat!
  
  var lockAngle: CGFloat!
  var number: ((Int) -> Int)!
}

/* Draw Numpad */
extension NumpadImageView: CirclePath {
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
}
