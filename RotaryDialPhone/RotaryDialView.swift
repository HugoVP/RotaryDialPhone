//
//  DiskImageView2.swift
//  RotaryDialPhone
//
//  Created by Hugo on 15/09/17.
//
//

import UIKit

class RotaryDialView: UIView, RotaryDialViewProtocol {
  var holesCount: Int = 10
  var holesRadius: CGFloat = 25.0
  var distanceFromHolesToCenter: CGFloat = 115.0
  var holesSeparationAngle: CGFloat = CGFloat.M_2_PI / 11.5
  var firstHoleAngle: CGFloat = CGFloat.M_2_PI / 11.5 * 1.25
  var lockAngle: CGFloat = CGFloat.M_2_PI / 11.5 * 0.25
  
  var number: ((Int) -> Int)!
}
