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
    private let holesCount = 10
    
    private var _center: CGPoint!
    private var _holeRadius: CGFloat!
    private var _distanceFromHolesToCenter: CGFloat!
    private var _holesSeparationAngle: CGFloat!
    private var _firstHoleAngle: CGFloat!
    private var _initHoleAngle: CGFloat!
    private var _lockAngle: CGFloat!
    private var _holes = [CGPoint]()
    
    var center: CGPoint {
        return _center
    }
    
    var holeRadius: CGFloat {
        return _holeRadius
    }

    var distanceFromHolesToCenter: CGFloat {
        return _distanceFromHolesToCenter
    }
    
    var holesSeparationAngle: CGFloat {
        return _holesSeparationAngle
    }
    
    var firstHoleAngle: CGFloat {
        return _firstHoleAngle
    }
    
    var holes: [CGPoint] {
        return _holes
    }
    
    init(
        center: CGPoint,
        holeRadius: CGFloat,
        distanceFromHolesToCenter: CGFloat,
        firstHoleAngle: CGFloat,
        holesSeparationAngle: CGFloat
    ) {
        _center = center
        _holeRadius = holeRadius
        _distanceFromHolesToCenter = distanceFromHolesToCenter
        _firstHoleAngle = firstHoleAngle
        _holesSeparationAngle = holesSeparationAngle
        _initHoleAngle = firstHoleAngle - holesSeparationAngle / 2.0
        _lockAngle = 2.0 * CGFloat.pi - holesSeparationAngle / 2.0
        
        setHoles()
    }
    
    private mutating func setHoles() {
        for index in 0 ..< holesCount {
            let holeAngle = firstHoleAngle + holesSeparationAngle * CGFloat(index)
            
            let hole = CGPoint(
                x: distanceFromHolesToCenter * cos(holeAngle) + center.x,
                y: distanceFromHolesToCenter * sin(holeAngle) + center.y
            )
            
            _holes.append(hole)
        }
    }
}
