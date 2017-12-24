//
//  RotaryDialElementView.swift
//  RotaryDialPhone
//
//  Created by Hugo on 24/12/17.
//

import UIKit

class RotaryDialElementView: UIView, RotaryDialViewProtocol {
  var path: UIBezierPath!
  
  @IBInspectable var fillColor: UIColor = .clear
  
  @IBInspectable var holesCount: Int = 10
  @IBInspectable var holesRadius: CGFloat = 25.0
  @IBInspectable var distanceFromHolesToCenter: CGFloat = 115.0
  @IBInspectable var holesSeparationAngle: CGFloat = CGFloat.M_2_PI / 11.5
  @IBInspectable var firstHoleAngle: CGFloat = CGFloat.M_2_PI / 11.5 * 1.25
  
  var number: ((Int) -> Int)! = { (index) in index > 0 ? 10 - index : 0 }
}
