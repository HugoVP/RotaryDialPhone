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
  @IBInspectable var holesRadius: CGFloat = 22.5
  @IBInspectable var distanceFromHolesToCenter: CGFloat = 112.5
  @IBInspectable var holesSeparationAngle: CGFloat = CGFloat.M_2_PI / 14.0
  @IBInspectable var firstHoleAngle: CGFloat = CGFloat.M_2_PI / 14.0 * 2.5
  @IBInspectable var lockAngle: CGFloat = CGFloat.M_2_PI / 14.0 * 1.5
  
  
  var number: ((Int) -> Int)! = { (index) in index > 0 ? 10 - index : 0 }
}
