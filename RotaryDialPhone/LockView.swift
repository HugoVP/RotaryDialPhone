//
//  LockImageView.swift
//  RotaryDialPhone
//
//  Created by Hugo on 22/12/17.
//

import UIKit

@IBDesignable
class LockView: UIView {
  @IBInspectable var fillColor: UIColor = .green
}

extension LockView {
  override func draw(_ rect: CGRect) {
    let lockWidth: CGFloat = 10.0
    
    let path = UIBezierPath(
      rect: CGRect(
        x: bounds.midX - lockWidth / 2.0,
        y: 0.0,
        width: lockWidth,
        height: 100.0
      )
    )
    
    fillColor.setFill()
    path.fill()
  }
}
