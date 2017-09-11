//
//  numpadView.swift
//  RotaryDialPhone
//
//  Created by Hugo on 10/09/17.
//
//

import UIKit

class NumpadView: UIView, CircleView {
    var path: UIBezierPath!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
