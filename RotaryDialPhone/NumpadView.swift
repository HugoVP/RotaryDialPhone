//
//  NumpadImageView.swift
//  RotaryDialPhone
//
//  Created by Hugo on 19/12/17.
//

import UIKit

/* Attributes */
@IBDesignable
class NumpadView: RotaryDialElementView {
  @IBInspectable var numberFontSize: CGFloat = 37.0
}

/* Draw Numpad */
extension NumpadView: CirclePath, RedrawableView {
  override func draw(_ rect: CGRect) {
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
    shapeLayer.fillColor = fillColor.cgColor
    shapeLayer.fillRule = kCAFillRuleEvenOdd
    shapeLayer.strokeColor = UIColor.darkGray.cgColor
    shapeLayer.lineWidth = 1.0
    shapeLayer.path = path.cgPath
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
        x: hole.x - holesRadius,
        y: hole.y - holesRadius,
        width: holesRadius * 2.0,
        height: holesRadius * 2.0
      )

      textLayer.cornerRadius = textLayer.bounds.midX
      textLayer.contentsScale = UIScreen.main.scale
      layer.addSublayer(textLayer)
    }
  }
}