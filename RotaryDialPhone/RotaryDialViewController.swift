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
  @IBOutlet weak var numpadImageView: NumpadImageView!
  @IBOutlet weak var diskImageView: DiskImageView!
  
  var model: RotaryDial!
  
  var phoneNumber = ""
  
  /* Delay before perform the call */
  /* when a phone number has been successfully entered */
  let delayBeforeTheCall = 1.15
  
  /* Rotation animation */
  let baseRotationAnimationTime: CGFloat = 0.4
  
  var baseRotationAnimationAngle: CGFloat {
    return 4 * rotaryDialView.holesSeparationAngle
  }
}

extension RotaryDialViewController {
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    /* Model params */
    let holesCount = 10
    let holesSeparationAngle = CGFloat.M_2_PI / 14.0
    let firstHoleAngle = holesSeparationAngle * 2.5
    let lockAngle = firstHoleAngle - holesSeparationAngle
    
    func number(index: Int) -> Int {
      if index > 0 {
        return holesCount - index
      }
      
      return 0
    }
    
    /* Set params based on screen size */
    switch UIScreen.main.bounds.width {
    case 320:
      /* Init model */
      model = RotaryDial(
        holesCount: holesCount,
        holesRadius: 45.0 / 2.0,
        distanceFromHolesToCenter: 112.5,
        holesSeparationAngle: holesSeparationAngle,
        firstHoleAngle: firstHoleAngle,
        lockAngle: lockAngle,
        number: number
      )
      
      /* Fonst size */
      numpadImageView.numberFontSize = 36.0
    
    case 375:
      /* Init model */
      model = RotaryDial(
        holesCount: holesCount,
        holesRadius: 52.734375 / 2.0,
        distanceFromHolesToCenter: 131.8359375,
        holesSeparationAngle: holesSeparationAngle,
        firstHoleAngle: firstHoleAngle,
        lockAngle: lockAngle,
        number: number
      )
      
      /* Fonst size */
      numpadImageView.numberFontSize = 42.0
    
    case 414:
      /* Init model */
      model = RotaryDial(
        holesCount: holesCount,
        holesRadius: 58.21875 / 2.0,
        distanceFromHolesToCenter: 145.546875,
        holesSeparationAngle: holesSeparationAngle,
        firstHoleAngle: firstHoleAngle,
        lockAngle: lockAngle,
        number: number
      )
      
      /* Fonst size */
      numpadImageView.numberFontSize = 46.0
      
    default:
      break
    }
    
    /* Set rotaryDialView */
    rotaryDialView.holesCount = model.holesCount
    rotaryDialView.holesRadius = model.holesRadius
    rotaryDialView.distanceFromHolesToCenter = model.distanceFromHolesToCenter
    rotaryDialView.holesSeparationAngle = model.holesSeparationAngle
    rotaryDialView.firstHoleAngle = model.firstHoleAngle
    rotaryDialView.lockAngle = model.lockAngle
    rotaryDialView.number = model.number
    
    /* Set numpadView */
    numpadImageView.holesCount = rotaryDialView.holesCount
    numpadImageView.holesRadius = rotaryDialView.holesRadius
    numpadImageView.distanceFromHolesToCenter = rotaryDialView.distanceFromHolesToCenter
    numpadImageView.holesSeparationAngle = rotaryDialView.holesSeparationAngle
    numpadImageView.firstHoleAngle = rotaryDialView.firstHoleAngle
    numpadImageView.lockAngle = rotaryDialView.lockAngle
    numpadImageView.number = rotaryDialView.number
    numpadImageView.image = nil
    
    /* Draw numpadView */
    numpadImageView.drawNumpad()
    
    /* Set diskImageView */
    diskImageView.holesCount = rotaryDialView.holesCount
    diskImageView.holesRadius = rotaryDialView.holesRadius
    diskImageView.distanceFromHolesToCenter = rotaryDialView.distanceFromHolesToCenter
    diskImageView.holesSeparationAngle = rotaryDialView.holesSeparationAngle
    diskImageView.firstHoleAngle = rotaryDialView.firstHoleAngle
    diskImageView.lockAngle = rotaryDialView.lockAngle
    diskImageView.number = rotaryDialView.number
    diskImageView.image = nil
    
    /* Draw diskImageView */
    diskImageView.drawDisk()
  }
  
  @IBAction func rotateAction(_ sender: RotaryDialGestureRecognizer) {
    switch sender.state {
    case .began:
      /* Cancel all previus calls to the makePhoneCall method */
      NSObject.cancelPreviousPerformRequests(withTarget: self)
      
    case .changed:
      if let rotationAngle = sender.rotationAngle {
        diskImageView.transform = CGAffineTransform(rotationAngle: rotationAngle)
      }
      
    case .ended:
      /* Get the touched number and add to the full phone number */
      if let holeNumber = sender.touchedNumber {
        phoneNumber += "\(holeNumber)"
        print("Phone Number: \(phoneNumber)")
      }
      
      /* Make reset disk angle animation */
      if let rotationAngle = sender.rotationAngle {
        reverseRotationAnimation(with: rotationAngle, rotateDialGestureEnded: true)
      }
      
    case .cancelled:
      if let rotationAngle = sender.rotationAngle {
        reverseRotationAnimation(with: rotationAngle)
      }
      
    default:
      break
    }
  }
  
  @IBAction func resetBtnPresed(_ sender: UIButton) {
    phoneNumber = ""
  }
}

extension RotaryDialViewController {
  func reverseRotationAnimation (with angle: CGFloat, rotateDialGestureEnded ended: Bool = false) {
    let midRotation = angle / 2.0
    let durationTime = midRotation * baseRotationAnimationTime / baseRotationAnimationAngle
    
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
              self.checkPhoneNumberFormat()
            }
          }
        )
      }
    )
  }
  
  @objc @available(iOS 10.0, *)
  func makePhoneCall() {
    guard phoneNumber.count > 0,
      let phoneNumberURL = URL(string: "tel://\(phoneNumber)"),
      UIApplication.shared.canOpenURL(phoneNumberURL) == true
      
    else {
      return
    }
    
    UIApplication.shared.open(phoneNumberURL, options: [:], completionHandler: nil)
  }
  
  func checkPhoneNumberFormat() {
    switch self.phoneNumber.count {
    case 3: /* Service phones */
      fallthrough
      
    case 7...8: /* XXX XXXX | XXXX XXXX */
      // print("call to landline")
      fallthrough
      
    case 10: /* XXX XXX XXXX | XX XXXX XXXX */
      // print("call to mobile")
      fallthrough
      
    case 12: /* 01 (XXX XXX | XX XXXX) XXXX  */
      // print("call to landline (long distance)")
      fallthrough
      
    case 13: /* (044 | 045) (XXX XXX | XX XXXX) XXXX */
      // print("call to mobile (from landline)")
      
      if #available(iOS 10.0, *) {
        /* Tempt to perform makePhoneCall method */
        /* Can be cancelled by the beginning of the gesture recognizer */
        self.perform(#selector(self.makePhoneCall), with: nil, afterDelay: self.delayBeforeTheCall)
      }
      
    default:
      break
    }
  }
}

