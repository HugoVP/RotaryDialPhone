//
//  RotaryDial.swift
//  RotaryDialPhone
//
//  Created by Hugo on 20/12/17.
//

import UIKit

struct RotaryDial {
  var holesCount: Int!
  var holesRadius: CGFloat!
  var distanceFromHolesToCenter: CGFloat!
  var holesSeparationAngle: CGFloat!
  var firstHoleAngle: CGFloat!
  
  var lockAngle: CGFloat!
  var number: ((Int) -> Int)!
  
  /* Temp attrs */
  var numberFontSize: CGFloat!
  var outterDiskBound: CGFloat!
  var innerDiskBound: CGFloat!
}
