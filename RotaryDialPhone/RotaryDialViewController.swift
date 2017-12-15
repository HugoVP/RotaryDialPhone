//
//  RotaryDialViewController.swift
//  RotaryDialPhone
//
//  Created by Hugo on 29/08/17.
//
//

import UIKit

class RotaryDialViewController: UIViewController {
    @IBOutlet weak var rotaryDialView: RotaryDialView!
    @IBOutlet weak var numpadImageView: RotaryDialView!
    @IBOutlet weak var diskImageView: RotaryDialView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /* Set params based on screen size */
        switch UIScreen.main.bounds.width {
        case 320:
            rotaryDialView.holesRadius = 45.0 / 2.0
            rotaryDialView.distanceFromHolesToCenter = 112.5
            numpadImageView.numberFontSize = 36.0
        case 375:
            rotaryDialView.holesRadius = 52.734375 / 2.0
            rotaryDialView.distanceFromHolesToCenter = 131.8359375
            numpadImageView.numberFontSize = 42.0
        default: /* 414 */
            rotaryDialView.holesRadius = 58.21875 / 2.0
            rotaryDialView.distanceFromHolesToCenter = 145.546875
            numpadImageView.numberFontSize = 46.0
        }
        
        /* Set numpadView model */
        rotaryDialView.holesSeparationAngle = CGFloat.M_2_PI / 14.0
        rotaryDialView.firstHoleAngle = rotaryDialView.holesSeparationAngle * 2.5
        
        /* Set numpadView model */
        numpadImageView.holesRadius = rotaryDialView.holesRadius
        numpadImageView.distanceFromHolesToCenter = rotaryDialView.distanceFromHolesToCenter
        numpadImageView.holesSeparationAngle = rotaryDialView.holesSeparationAngle
        numpadImageView.firstHoleAngle = rotaryDialView.firstHoleAngle
        
        /* Draw numpadView */
        numpadImageView.image = nil
        numpadImageView.drawNumpad()
        
        /* Set diskImageView model */
        diskImageView.holesRadius = rotaryDialView.holesRadius
        diskImageView.distanceFromHolesToCenter = rotaryDialView.distanceFromHolesToCenter
        diskImageView.holesSeparationAngle = rotaryDialView.holesSeparationAngle
        diskImageView.firstHoleAngle = rotaryDialView.firstHoleAngle
        
        /* Draw diskImageView */
        diskImageView.image = nil
        diskImageView.drawDisk()
    }
    
    @IBAction func rotateAction(_ sender: RotaryDialGestureRecognizer) {
        switch sender.state {
        case .began:
            print("began")
            
        case .changed:
            if let rotationAngle = sender.rotationAngle {
                diskImageView.transform = CGAffineTransform(rotationAngle: rotationAngle)
            }
        
        case .ended:
            if let rotationAngle = sender.rotationAngle {
                reverseRotationAnimation(with: rotationAngle)
            }
            
            if let holeNumber = sender.touchedNumber {
                print("number: ", holeNumber)
            }
            
            print("ended")
            
        case .cancelled:
            if let rotationAngle = sender.rotationAngle {
                reverseRotationAnimation(with: rotationAngle)
            }
            
            print("cancelled")
            
        default:
            break
        }
    }
    
    func reverseRotationAnimation (with angle: CGFloat) {
        let baseTime: CGFloat = 0.4
        let baseAngle = 4 * rotaryDialView.holesSeparationAngle
        let midRotation = angle / 2.0
        let durationTime = midRotation * baseTime / baseAngle
        
        UIView.animate(
            withDuration: Double(durationTime),
            delay: 0,
            options: .curveLinear,
            animations: {
                self.diskImageView.transform = CGAffineTransform(rotationAngle: midRotation)
                },
            completion: { (finished) in
                UIView.animate(
                    withDuration: Double(durationTime),
                    delay: 0,
                    options: .curveLinear,
                    animations: {
                        self.diskImageView.transform = CGAffineTransform(rotationAngle: 0)
                },
                    completion: nil
                )
            }
        )
    }
}
