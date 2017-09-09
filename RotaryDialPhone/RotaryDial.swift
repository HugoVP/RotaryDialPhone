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
    private var _diskCenter: CGPoint!
    private var _holesSize: CGFloat!
    private var _distanceFromHolesToCenter: CGFloat!
    private var _holesSeparationAngle: CGFloat!
    private var _firstHoleAngle: CGFloat!
    private var _initHoleAngle: CGFloat!
    private var _lockAngle: CGFloat!
    private var _holes = [CGPoint]()
    
    var diskCenter: CGPoint {
        return _diskCenter
    }
    
    var holesSize: CGFloat {
        return _holesSize
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
        diskCenter: CGPoint,
        holesSize: CGFloat,
        distanceFromHolesToCenter: CGFloat,
        firstHoleAngle: CGFloat,
        holesSeparationAngle: CGFloat
    ) {
        _diskCenter = diskCenter
        _holesSize = holesSize
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
                x: distanceFromHolesToCenter * cos(holeAngle) + diskCenter.x,
                y: distanceFromHolesToCenter * sin(holeAngle) + diskCenter.y
            )
            
            _holes.append(hole)
        }
    }
}
