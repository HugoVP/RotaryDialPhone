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
      return _touchedNumber
    }
    
    override var view: RotaryDialView? {
        return super.view as? RotaryDialView
    }
  
    private var firstAngle: CGFloat?
    private var _rotationAngle: CGFloat?
    private var _touchedHoleIndex: Int?
    private var _touchedNumber: Int?

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
        
        guard let touchedLocation = touches.first?.location(in: view),
            let touchedHoleIndex = _touchedHoleIndex
          
        else {
            state = .failed
            return
        }
        
        let currentAngle = getAngle(for: touchedLocation)
        let diffAngle = currentAngle - firstAngle!
        
        if diffAngle <= 0 {
            _rotationAngle = 0
            firstAngle = currentAngle
            
            if isTouchedLocation(touchedLocation, insideHole: touchedHoleIndex) == false {
                state = .failed
                return
            }
        }
        
        else {
            _rotationAngle = diffAngle
            
            if checkBoundaries(for: touchedLocation) == false {
                state = .failed
                return
            }
            
            /* Successfully complete gesture when lockAngle location is reached */
            if currentAngle >= transformAngle((view?.lockAngle)!) {
                if let touchedNumber = view?.number(touchedHoleIndex) {
                    _touchedNumber = touchedNumber
                }

                state = .recognized
                return
            }
        }
        
//        print("firstAngle: \(firstAngle!.degrees)")
//        print("currentAngle: \(currentAngle.degrees)")
//        print("rotationAngle: \(rotationAngle!.degrees)")
//        print("lockAngle: \((view?.lockAngle)!.degrees)")
        
        state = .changed
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
      
        /* Get touchedLocation */
        guard let touchedLocation = touches.first?.location(in: view) else {
            state = .failed
            return
        }
      
        /* Get currentAngle */
        let currentAngle = getAngle(for: touchedLocation)
      
        /* If lockAngle was not reached by the currentAngle, gesture fails */
        if currentAngle < transformAngle((view?.lockAngle)!) {
            // print("lockAngle location was not reached")
            state = .failed
            return
        }
      
        state = .ended
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesCancelled(touches, with: event)
        state = .cancelled
    }
    
    override func reset() {
        firstAngle = nil
        _rotationAngle = nil
        _touchedHoleIndex = nil
        _touchedNumber = nil
    }
    
    private func getAngle(for touchedLocation: CGPoint) -> CGFloat {
        guard let view = view else {
            return 0.0
        }
        
        let x = touchedLocation.x - view.bounds.midX
        let y = -(touchedLocation.y - view.bounds.midY)
        
        if y == 0.0 {
            if x > 0.0 {
                return transformAngle(0.0)
            } else /* x <= 0 */ {
                return transformAngle(CGFloat.pi)
            }
        }
        
        let angle = atan(x / y)
        
        /* Quad I & Quad II */
        if y < 0.0 {
            return transformAngle(angle + CGFloat.M_PI_2)
        }
        
        /* Quad III & Quad IV */
        else /* if y > 0.0 */ {
            return transformAngle(angle + CGFloat.M_PI_2 * 3.0)
        }
    }
    
    /* Transform the given angle into relative one to the disk holes  */
    private func transformAngle(_ angle: CGFloat) -> CGFloat {
        /* Get the startAngle from the view */
        guard let startAngle = view?.startAngle else {
            return 0.0
        }
        
        /* Substract startAngle from the given angle; then plus 360º, finally module 360º.
         * The result should be a positive angle. */
        return (angle - startAngle + CGFloat.M_2_PI).truncatingRemainder(dividingBy: CGFloat.M_2_PI)
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
