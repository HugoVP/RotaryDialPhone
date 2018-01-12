//
//  RedrawableView.swift
//  RotaryDialPhone
//
//  Created by Hugo on 23/12/17.
//

import UIKit

protocol RedrawableView {}

extension RedrawableView where Self:UIView {
  /* Erase the view and redraws it */
  func redraw() {
    guard let sublayers = layer.sublayers else {
      return
    }
    
    for sublayer in sublayers {
      sublayer.removeFromSuperlayer()
    }
    
    setNeedsDisplay()
  }
}
