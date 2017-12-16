//
//  CGFloat+Ext.swift
//  RotaryDialPhone
//
//  Created by Hugo on 16/09/17.
//
//

import UIKit

extension CGFloat {
    var degrees: CGFloat {
        return self * 180.0 / CGFloat.pi
    }
    
    static var M_2_PI: CGFloat {
        return CGFloat.pi * 2.0
    }
    
    static var M_PI_2: CGFloat {
        return CGFloat.pi / 2.0
    }
}
