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
    override var view: DiskView? {
        return super.view as? DiskView
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        
        if touches.count > 1 {
            state = .failed
            return
        }
        
        state = .began
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        state = .ended
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        
        if state == .failed {
            return
        }
        
        state = .changed
    }
}
