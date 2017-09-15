//
//  RotaryDialViewController.swift
//  RotaryDialPhone
//
//  Created by Hugo on 29/08/17.
//
//

import UIKit

class RotaryDialViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var numpadView: NumpadView!
    @IBOutlet weak var diskView: DiskView!
    
    var model: RotaryDial!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let numberFontSize: CGFloat!
    
        /* Model params */
        let holeRadius: CGFloat!
        let distanceToCenter: CGFloat!
        
        /* Set params based on screen size */
        switch UIScreen.main.bounds.width {
        case 320:
            holeRadius = 45.0 / 2.0
            distanceToCenter = 112.5
            numberFontSize = 36.0
        case 375:
            holeRadius = 52.734375 / 2.0
            distanceToCenter = 131.8359375
            numberFontSize = 42.0
        default: /* 414 */
            holeRadius = 58.21875 / 2.0
            distanceToCenter = 145.546875
            numberFontSize = 46.0
        }
        
        model = RotaryDial(
            center: CGPoint(
                x: diskView.bounds.midX,
                y: diskView.bounds.midY
            ),
            holeRadius: holeRadius,
            distanceFromHolesToCenter: distanceToCenter,
            firstHoleAngle: 2.5 * CGFloat.pi / 7.0,
            holesSeparationAngle: CGFloat.pi / 7.0
        )
        
        /* Set circular shape to numpadView */
        numpadView.configure(
            diskCenter: model.center,
            holes: model.holes,
            holeRadius: model.holeRadius,
            numbers: model.numbers,
            numberFontSize: numberFontSize
        )
        
        /* Set diskView */
        diskView.configure(
            holes: model.holes,
            holeRadius: model.holeRadius,
            distanceFromHolesToCenter: model.distanceFromHolesToCenter,
            initHoleAngle: model.initHolesAngle
        )
    }
    
    @IBAction func rotateAction(_ sender: DiskGestureRecognizer) {
        switch sender.state {
        case .cancelled:
            UIView.animate(
                withDuration: 0.1,
                animations: {
                    self.diskView.transform = CGAffineTransform(rotationAngle: 0.0)
            },
                completion: nil
            )
            
        case .changed:
            if let rotationAngle = sender.rotationAngle {
                diskView.transform = CGAffineTransform(rotationAngle: rotationAngle)
            }
        
        case .ended:
            UIView.animate(
                withDuration: 0.1,
                animations: {
                    self.diskView.transform = CGAffineTransform(rotationAngle: 0.0)
                },
                completion: nil
            )
            
        default:
            break
        }
    }
}

extension CGFloat {
    func toDegrees() -> CGFloat {
        return self * 180.0 / CGFloat.pi
    }
}
