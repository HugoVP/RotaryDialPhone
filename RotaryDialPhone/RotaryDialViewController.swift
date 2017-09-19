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
        rotaryDialView.holesRadius = holeRadius
        rotaryDialView.distanceFromHolesToCenter = distanceToCenter
        rotaryDialView.holesSeparationAngle = CGFloat.pi / 7.0
        rotaryDialView.firstHoleAngle = rotaryDialView.holesSeparationAngle * 2.5
        
        /* Set numpadView model */
        numpadImageView.holesRadius = holeRadius
        numpadImageView.distanceFromHolesToCenter = distanceToCenter
        numpadImageView.holesSeparationAngle = CGFloat.pi / 7.0
        numpadImageView.firstHoleAngle = numpadImageView.holesSeparationAngle * 2.5
        numpadImageView.numberFontSize = numberFontSize
        
        /* Draw numpadView */
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
        case .began:
            print("began")
            
            if let holeNumber = sender.touchedNumber {
                print("number: ", holeNumber)
            }
            
        case .changed:
            diskImageView.transform = CGAffineTransform(rotationAngle: sender.rotationAngle!)
        
        case .ended:
            reverseRotationAnimation(with: sender.rotationAngle!)
            print("ended")
            
        case .cancelled:
            reverseRotationAnimation(with: sender.rotationAngle!)
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
