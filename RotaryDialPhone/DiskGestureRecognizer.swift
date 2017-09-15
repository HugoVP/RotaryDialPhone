//
//  CustomGestureRecognizer.swift
//  RotaryDialPhone
//
//  Created by Hugo on 11/09/17.
//
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

class DiskGestureRecognizer: UIGestureRecognizer {
    var touchedHoleIndex: Int {
        return _touchedHoleIndex
    }
    
    var rotationAngle: CGFloat? {
        guard let currentAngle = _currentAngle,
            let firstAngle = _firstAngle,
            currentAngle > firstAngle else {
            return nil
        }
        
        let diffAngle = currentAngle - firstAngle
        let rotationAngle = (CGFLOAT_2_PI + diffAngle).truncatingRemainder(dividingBy: CGFLOAT_2_PI)
            
        return rotationAngle
    }
    
    private var CGFLOAT_2_PI: CGFloat {
        return 2.0 * CGFloat.pi
    }
    
    private var _touchedHoleIndex: Int!
    private var _rotationAngle: CGFloat!
    private var _firstAngle: CGFloat!
    private var _currentAngle: CGFloat!
    
//    override var view: DiskView? {
//        return super.view as? DiskView
//    }
    
    var diskView: DiskView? {
        // if view != nil {
            return view as? DiskView
        // }
        
        // return nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        
        guard touches.count <= 1,
            let touchedLocation = touches.first?.location(in: view),
            let touchedHoleIndex = getHoleIndex(from: touchedLocation) else
            {
                state = .failed
                return
            }
        
        _touchedHoleIndex = touchedHoleIndex
        _currentAngle = getAngle(for: touchedLocation)
        _firstAngle = _currentAngle
        state = .began
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        
        if state == .failed {
            return
        }
        
        guard let touchedLocation = touches.first?.location(in: view),
            checkBounderies(for: touchedLocation) == true else {
                state = .cancelled
                return
            }
        
        _currentAngle = getAngle(for: touchedLocation)
        state = .changed
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        state = .ended
        
        _firstAngle = nil
        _currentAngle = nil
        _rotationAngle = nil
        _touchedHoleIndex = nil
    }
    
    private func getAngle(for touchedLocation: CGPoint) -> CGFloat {
        guard let diskView = diskView else {
            return 0.0
        }
        
        let x = Float(touchedLocation.x - diskView.bounds.midX)
        let y = -Float(touchedLocation.y - diskView.bounds.midY)
        
        if y == 0.0 {
            if x > 0.0 {
                return 0.0
            } else {
                return CGFloat.pi
            }
        }
        
        let atan = CGFloat(atanf(x / y))
        let angle: CGFloat!
        
        /* Quad I & Quad II */
        if y < 0.0 {
            // return atan + 0.5 * CGFloat.pi
            angle = atan + 0.5 * CGFloat.pi
        }
        
        /* Quad III & Quad IV */
        else /* if y > 0.0 */ {
            // return atan + 1.5 * CGFloat.pi
            angle = atan + 1.5 * CGFloat.pi
        }
        
        // return angle
        
        let transformedAngle = (angle - diskView.model.initHolesAngle + CGFLOAT_2_PI).truncatingRemainder(dividingBy: CGFLOAT_2_PI)
        
        return transformedAngle
    }
    
    private func getHoleIndex(from touchedLocation: CGPoint) -> Int? {
        guard let diskView = diskView else {
            return nil
        }
        
        for index in 0 ..< diskView.model.holes.count {
            let hole = diskView.model.holes[index]
            
            let distanceToHole = sqrt(
                pow(abs(touchedLocation.x - hole.x), 2) +
                pow(abs(touchedLocation.y - hole.y), 2)
            )
            
            if distanceToHole <= diskView.model.holeRadius {
                return index
            }
        }
        
        return nil
    }
    
    private func checkBounderies(for touchedLocation: CGPoint) -> Bool {
        if let diskView = diskView {
            let diffX = abs(touchedLocation.x - diskView.bounds.midX)
            let diffY = abs(touchedLocation.y - diskView.bounds.midY)
            let distanceToCenter = sqrt(pow(diffX, 2.0) + pow(diffY, 2.0))
        
            if distanceToCenter < diskView.model.distanceFromHolesToCenter + diskView.model.holeRadius {
                if distanceToCenter > diskView.model.distanceFromHolesToCenter - diskView.model.holeRadius {
                    return true
                }
            }
        }
        
        return false
    }
}
