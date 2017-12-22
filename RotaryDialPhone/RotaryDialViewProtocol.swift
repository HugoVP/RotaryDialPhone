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
  
  /* lockAngle: The angle where the lock is located  */
  var lockAngle: CGFloat! { get }
  
  /* Get the number character by the index postion */
  var number: ((Int) -> Int)! { get set }
}

extension RotaryDialViewProtocol where Self: UIView {
  /* startAngle: The angle where's located the first hole's border. */
  var startAngle: CGFloat {
    return firstHoleAngle - atan(holesRadius / distanceFromHolesToCenter)
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
