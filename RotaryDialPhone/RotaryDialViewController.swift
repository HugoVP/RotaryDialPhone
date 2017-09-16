//
//  RotaryDialViewController.swift
//  RotaryDialPhone
//
//  Created by Hugo on 29/08/17.
//
//

import UIKit

class RotaryDialViewController: UIViewController {
    @IBOutlet weak var numpadImageView: RotaryDialView!
    @IBOutlet weak var diskImageView: RotaryDialView!
    
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
        
        /* Set numpadView model */
        numpadImageView.holesRadius = holeRadius
        numpadImageView.distanceFromHolesToCenter = distanceToCenter
        numpadImageView.holesSeparationAngle = CGFloat.pi / 7.0
        numpadImageView.firstHoleAngle = numpadImageView.holesSeparationAngle * 2.5
        numpadImageView.numberFontSize = numberFontSize
        
        /* Drae numpadView */
        numpadImageView.image = nil
        numpadImageView.drawNumpad()
        
        /* Set diskImageView model */
        diskImageView.holesRadius = holeRadius
        diskImageView.distanceFromHolesToCenter = distanceToCenter
        diskImageView.holesSeparationAngle = CGFloat.pi / 7.0
        diskImageView.firstHoleAngle = diskImageView.holesSeparationAngle * 2.5
        
        /* Draw diskImageView */
        diskImageView.image = nil
        diskImageView.drawDisk()
    }
    
    @IBAction func rotateAction(_ sender: RotaryDialGestureRecognizer) {
        switch sender.state {
        case .cancelled:
            UIView.animate(
                withDuration: 0.1,
                animations: {
                    self.diskImageView.transform = CGAffineTransform(rotationAngle: 0.0)
            },
                completion: nil
            )
            
        case .changed:
            if let rotationAngle = sender.rotationAngle {
                diskImageView.transform = CGAffineTransform(rotationAngle: rotationAngle)
            }
        
        case .ended:
            UIView.animate(
                withDuration: 0.1,
                animations: {
                    self.diskImageView.transform = CGAffineTransform(rotationAngle: 0.0)
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
