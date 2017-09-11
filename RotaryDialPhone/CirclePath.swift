//
//  CircleView.swift
//  RotaryDialPhone
//
//  Created by Hugo on 11/09/17.
//
//
import UIKit

protocol CirclePath {
    var path: UIBezierPath! { get set }
}

extension CirclePath where Self: UIView {
    var bz: CGFloat {
        return 0.55228
    }
    
    func drawCircle(center: CGPoint, radius: CGFloat) {
        let bzCtrlPt = bz * radius
        
        path.move(to: CGPoint(x: center.x + radius, y: center.y))
        
        path.addCurve(
            to: CGPoint(x: center.x, y: center.y - radius),
            controlPoint1: CGPoint(x: center.x + radius, y: center.y - bzCtrlPt),
            controlPoint2: CGPoint(x: center.x + bzCtrlPt, y: center.y - radius)
        )
        
        path.addCurve(
            to: CGPoint(x: center.x - radius, y: center.y),
            controlPoint1: CGPoint(x: center.x - bzCtrlPt, y: center.y - radius),
            controlPoint2: CGPoint(x: center.x - radius, y: center.y - bzCtrlPt)
        )
        
        path.addCurve(
            to: CGPoint(x: center.x, y: center.y + radius),
            controlPoint1: CGPoint(x: center.x - radius, y: center.y + bzCtrlPt),
            controlPoint2: CGPoint(x: center.x - bzCtrlPt, y: center.y + radius)
        )
        
        path.addCurve(
            to: CGPoint(x: center.x + radius, y: center.y),
            controlPoint1: CGPoint(x: center.x + bzCtrlPt, y: center.y + radius),
            controlPoint2: CGPoint(x: center.x + radius, y: center.y + bzCtrlPt)
        )
    }
}
