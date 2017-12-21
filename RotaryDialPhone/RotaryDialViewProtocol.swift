//
//  RotaryDialModel.swift
//  RotaryDialPhone
//
//  Created by Hugo on 19/12/17.
//

import UIKit

protocol RotaryDialViewProtocol {
  var holesCount: Int! { get set }
  var holesRadius: CGFloat! { get set }
  var distanceFromHolesToCenter: CGFloat! { get set }
  var holesSeparationAngle: CGFloat! { get set }
  var firstHoleAngle: CGFloat! { get set }
}

extension RotaryDialViewProtocol where Self: UIView {
  /* startAngle: The angle where's located the first hole's border. */
  var startAngle: CGFloat {
    return firstHoleAngle - atan(holesRadius / distanceFromHolesToCenter)
  }
  
  /* lockAngle: The angle where the lock is located  */
  var lockAngle: CGFloat {
    return firstHoleAngle - holesSeparationAngle
  }
  
  /* Get the number character by the index postion */
  func number(_ index: Int) -> Int {
    if index > 0 {
      return holesCount - index
    }
    
    return 0
  }
  
  /* Get the hole location by the index position */
  func hole(_ index: Int) -> CGPoint {
    let angle = firstHoleAngle + holesSeparationAngle * CGFloat(index)
    
    return CGPoint(
      x: distanceFromHolesToCenter * cos(angle) + bounds.midX,
      y: distanceFromHolesToCenter * sin(angle) + bounds.midY
    )
  }
}
