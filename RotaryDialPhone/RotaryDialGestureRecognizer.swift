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
    var rotationAngle: CGFloat? {
        return _rotationAngle
    }
    
    var touchedNumber: Int? {
        return view!.number(_touchedHoleIndex!)
    }
    
    override var view: RotaryDialView? {
        return super.view as? RotaryDialView
    }
    
    private var firstAngle: CGFloat?
    private var currentAngle: CGFloat?
    private var _rotationAngle: CGFloat?
    private var _touchedHoleIndex: Int?

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        
        guard touches.count == 1,
            let touchedLocation = touches.first?.location(in: view),
            let touchedHoleIndex = getHoleIndex(from: touchedLocation)
            
        else {
            state = .failed
            return
        }
        
        firstAngle = getAngle(for: touchedLocation)
        _touchedHoleIndex = touchedHoleIndex
        state = .began
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        
        if state == .failed {
            return
        }
        
        guard let touchedLocation = touches.first?.location(in: view) else {
            state = .failed
            return
        }
        
        let currentAngle = getAngle(for: touchedLocation)
        let diffAngle = currentAngle - firstAngle!
        
        if diffAngle <= 0 {
            _rotationAngle = 0
            
            guard isTouchedLocation(touchedLocation, insideHole: _touchedHoleIndex!) == true else {
                state = .failed
                return
            }
        }
        
        else {
            _rotationAngle = diffAngle
            
            guard checkBoundaries(for: touchedLocation) == true else {
                state = .failed
                return
            }
        }
        
        state = .changed
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        state = .ended
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesCancelled(touches, with: event)
        state = .cancelled
    }
    
    override func reset() {
        firstAngle = nil
        currentAngle = nil
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
            } else /* x <= 0 */ {
                return CGFloat.pi
            }
        }
        
        let atan = CGFloat(atanf(x / y))
        
        /* Quad I & Quad II */
        if y < 0.0 {
            return atan + CGFloat.M_PI_2
        }
        
        /* Quad III & Quad IV */
        else /* if y > 0.0 */ {
            return atan + CGFloat.M_PI_2 * 3.0
        }
    }
    
    private func getHoleIndex(from touchedLocation: CGPoint) -> Int? {
        for index in 0 ..< view!.holesCount {
            if isTouchedLocation(touchedLocation, insideHole: index) {
                return index
            }
        }
        
        return nil
    }
    
    private func isTouchedLocation(_ touchedLocation: CGPoint, insideHole index: Int) -> Bool {
        let hole = view!.hole(index)
        
        let distanceToHole = sqrt(
            pow(abs(touchedLocation.x - hole.x), 2.0) +
            pow(abs(touchedLocation.y - hole.y), 2.0)
        )
        
        return distanceToHole <= view!.holesRadius
    }

    private func checkBoundaries(for touchedLocation: CGPoint) -> Bool {
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
