//
//  CustomGestureRecognizer.swift
//  RotaryDialPhone
//
//  Created by Hugo on 11/09/17.
//
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

class RotaryDialGestureRecognizer: UIGestureRecognizer {
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
    
    override var view: RotaryDialView? {
        return super.view as? RotaryDialView
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
        guard let view = view else {
            return 0.0
        }
        
        let x = Float(touchedLocation.x - view.bounds.midX)
        let y = -Float(touchedLocation.y - view.bounds.midY)
        
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
            angle = atan + 0.5 * CGFloat.pi
        }
        
        /* Quad III & Quad IV */
        else /* if y > 0.0 */ {
            angle = atan + 1.5 * CGFloat.pi
        }
        
        let transformedAngle = (angle - view.initHoleAngle + CGFLOAT_2_PI).truncatingRemainder(dividingBy: CGFLOAT_2_PI)
        
        return transformedAngle
    }
    
    private func getHoleIndex(from touchedLocation: CGPoint) -> Int? {
        guard let view = view else {
            return nil
        }
        
        for index in 0 ..< view.holesCount {
            let hole = view.hole(index)
            
            let distanceToHole = sqrt(
                pow(abs(touchedLocation.x - hole.x), 2) +
                pow(abs(touchedLocation.y - hole.y), 2)
            )
            
            if distanceToHole <= view.holesRadius {
                return index
            }
        }
        
        return nil
    }
    
    private func checkBounderies(for touchedLocation: CGPoint) -> Bool {
        if let view = view {
            let diffX = abs(touchedLocation.x - view.bounds.midX)
            let diffY = abs(touchedLocation.y - view.bounds.midY)
            let distanceToCenter = sqrt(pow(diffX, 2.0) + pow(diffY, 2.0))
        
            if distanceToCenter < view.distanceFromHolesToCenter + view.holesRadius {
                if distanceToCenter > view.distanceFromHolesToCenter - view.holesRadius {
                    return true
                }
            }
        }
        
        return false
    }
}
