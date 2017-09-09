//
//  RotaryDial.swift
//  RotaryDialPhone
//
//  Created by Hugo on 08/09/17.
//
//

import Foundation
import UIKit

struct RotaryDial {
    private var _holesSize: CGFloat
    private var _distanceFromHolesToCenter: CGFloat
    
    var holesSize: CGFloat {
        return _holesSize
    }
    
    var distanceFromHolesToCenter: CGFloat {
        return _distanceFromHolesToCenter
    }
    
    init(holesSize: CGFloat, distanceFromHolesToCenter: CGFloat) {
        _holesSize = holesSize
        _distanceFromHolesToCenter = distanceFromHolesToCenter
    }
}
