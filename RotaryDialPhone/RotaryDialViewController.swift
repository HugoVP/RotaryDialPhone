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
  
  var phoneNumber = ""
  
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
      // print("changed")
      
      if let rotationAngle = sender.rotationAngle {
        diskImageView.transform = CGAffineTransform(rotationAngle: rotationAngle)
      }
      
    case .ended:
      // print("ended")
      
      /* Get the touched number and add to the full phone number */
      if let holeNumber = sender.touchedNumber {
        // print("number: ", holeNumber)
        phoneNumber += "\(holeNumber)"
        print("Phone Number: \(phoneNumber)")
      }
      
      /* Make reset disk angle animation */
      if let rotationAngle = sender.rotationAngle {
        reverseRotationAnimation(with: rotationAngle, ended: true)
      }
      
    case .cancelled:
      // print("cancelled")
      
      if let rotationAngle = sender.rotationAngle {
        reverseRotationAnimation(with: rotationAngle)
      }
      
    default:
      break
    }
  }
  
  @IBAction func resetBtnPressed(_ sender: UIButton) {
    // print("Reset")
    phoneNumber = ""
  }
}

extension RotaryDialViewController {
  func reverseRotationAnimation (with angle: CGFloat, ended: Bool = false) {
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
          completion: { (finished) in
            if (ended) {
              print("ended: \(ended)")
              
              switch self.phoneNumber.count {
              case 7...8: /* XXX XXXX | XXXX XXXX */
                print("call to landline")
                fallthrough
              
              case 10: /* XXX XXX XXXX | XX XXXX XXXX */
                print("call to mobile")
                fallthrough
                
              case 12: /* 01 (XXX XXX | XX XXXX) XXXX  */
                print("call to landline (long distance)")
                fallthrough
                
              case 13: /* (044 | 045) (XXX XXX | XX XXXX) XXXX */
                print("call to mobile (from landline)")
                
                if #available(iOS 10.0, *) {
                  self.makePhoneCall()
                }
                
              default:
                break
              }
            }
          }
        )
      }
    )
  }
  
  @available(iOS 10.0, *)
  func makePhoneCall() {
    guard phoneNumber.count > 0,
      let phoneNumberURL = URL(string: "tel://\(phoneNumber)"),
      UIApplication.shared.canOpenURL(phoneNumberURL) == true
      
      else {
        return
    }
    
    UIApplication.shared.open(phoneNumberURL, options: [:], completionHandler: nil)
  }
}

