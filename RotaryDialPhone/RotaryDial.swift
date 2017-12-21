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
  
  /* Get the number character by the index postion */
  func number(_ index: Int) -> Int {
    if index > 0 {
      return holesCount - index
    }
    
    return 0
  }
  
  /* Get the hole location by the index position */
//  func hole(_ index: Int) -> CGPoint {
//    let angle = firstHoleAngle + holesSeparationAngle * CGFloat(index)
//    
//    return CGPoint(
//      x: distanceFromHolesToCenter * cos(angle) + bounds.midX,
//      y: distanceFromHolesToCenter * sin(angle) + bounds.midY
//    )
//  }
}
