//
//  RotaryDialModel.swift
//  RotaryDialPhone
//
//  Created by Hugo on 15/09/17.
//
//

import Foundation
import UIKit

protocol RotaryDialModel {
    var holesRadius: CGFloat! { set get }
    var distanceFromHolesToCenter: CGFloat! { set get }
    var holesSeparationAngle: CGFloat! { set get }
    var firstHoleAngle: CGFloat! { set get }
    
    func hole(_ index: Int) -> CGPoint
    func number(_ index: Int) -> Int
}

extension RotaryDialModel where Self: UIImageView {
    var holesCount: Int {
        return 10
    }
    
    var initHoleAngle: CGFloat {
        return firstHoleAngle - holesSeparationAngle / 2.0
    }
    
    var lockAngle: CGFloat {
        return 2.0 * CGFloat.pi - holesSeparationAngle / 2.0
    }
    
    func hole(_ index: Int) -> CGPoint {
        let angle = firstHoleAngle + holesSeparationAngle * CGFloat(index)
        
        return CGPoint(
            x: distanceFromHolesToCenter * cos(angle) + bounds.midX,
            y: distanceFromHolesToCenter * sin(angle) + bounds.midY
        )
    }
    
    func number(_ index: Int) -> Int {
        if index > 0 {
            return holesCount - index
        }
        
        return 0
    }
}
