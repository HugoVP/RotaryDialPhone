//
//  DiskImageView2.swift
//  RotaryDialPhone
//
//  Created by Hugo on 15/09/17.
//
//

import UIKit

class RotaryDialView: UIView, RotaryDialViewProtocol {
  var holesCount: Int = 0
  var holesRadius: CGFloat = 0.0
  var distanceFromHolesToCenter: CGFloat = 0.0
  var holesSeparationAngle: CGFloat = 0.0
  var firstHoleAngle: CGFloat = 0.0
  
  /* The angle where the lock is located  */
  var lockAngle: CGFloat = 0.0
  
  /* The angle where's located the first hole's border. */
  var startAngle: CGFloat {
    return firstHoleAngle - atan(holesRadius / distanceFromHolesToCenter)
  }
  
  var number: ((Int) -> Int)!
}
