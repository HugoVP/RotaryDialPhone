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
  @IBOutlet weak var numpadView: NumpadView!
  @IBOutlet weak var diskView: DiskView!
  @IBOutlet weak var lockView: LockView!
  
  var model: RotaryDial!
  var models = [RotaryDial]()
  
  var phoneNumber = ""
  
  /* Delay before perform the call */
  /* when a phone number has been successfully entered */
  let delayBeforeTheCall = 1.15
  
  /* Rotation animation */
  let baseRotationAnimationTime: CGFloat = 0.4
  
  var baseRotationAnimationAngle: CGFloat {
    return 4.0 * rotaryDialView.holesSeparationAngle
  }
}

extension RotaryDialViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    /* Feed Models Array */
    feedModelsArray()
    
    /* Select a model */
    model = models[0]
    
    /* Set views */
    setAllViews()
  }
  
  @IBAction func rotateAction(_ sender: RotaryDialGestureRecognizer) {
    switch sender.state {
    case .began:
      /* Cancel all previus calls to the makePhoneCall method */
      NSObject.cancelPreviousPerformRequests(withTarget: self)
      
    case .changed:
      if let rotationAngle = sender.rotationAngle {
        diskView.transform = CGAffineTransform(rotationAngle: rotationAngle)
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
    
    /* Temporal functionality */
    /* Randomly chooses a model and redraws it */
    model = models[Int(arc4random_uniform(UInt32(models.count)))]
    setAllViews()
    numpadView.redraw()
    diskView.redraw()
    lockView.redraw()
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
        self.diskView.transform = CGAffineTransform(rotationAngle: midRotation)
      },
      completion: { (finished) in
        UIView.animate(
          withDuration: Double(durationTime),
          delay: 0,
          options: .curveLinear,
          animations: {
            self.diskView.transform = CGAffineTransform(rotationAngle: 0)
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
  
  func feedModelsArray() {
    let constant = UIScreen.main.bounds.width / 320.0

    /* Set Model 1 */
    let model1 = RotaryDial(
      holesCount: 10,
      holesRadius: 45.0 / 2 * constant,
      distanceFromHolesToCenter: 112.5 * constant,
      holesSeparationAngle: CGFloat.M_2_PI / 14.0,
      firstHoleAngle: CGFloat.M_2_PI / 14.0 * 2.5,
      lockAngle: CGFloat.M_2_PI / 14.0 * 1.5,
      number: { (index) in index > 0 ? 10 - index : 0 },
      numberFontSize: 30 + 7 * constant,
      outterDiskBound: 8,
      innerDiskBound: 8
    )
    
    models.append(model1)
    
    /* Set Model 2 */
    let model2 = RotaryDial(
      holesCount: 10,
      holesRadius: 58.0 / 2 * constant,
      distanceFromHolesToCenter: 115.0 * constant,
      holesSeparationAngle: CGFloat.M_2_PI / 11.5,
      firstHoleAngle: CGFloat.M_2_PI / 11.5 * 1.25,
      lockAngle: CGFloat.M_2_PI / 11.5 * 0.25,
      number: { (index) in index > 0 ? 10 - index : 0 },
      numberFontSize: 37 + 7 * constant,
      outterDiskBound: 8,
      innerDiskBound: 8
    )
    
    models.append(model2)
    
    /* Set Model 3 */
    let model3 = RotaryDial(
      holesCount: 10,
      holesRadius: 50.0 / 2 * constant,
      distanceFromHolesToCenter: 115.0 * constant,
      holesSeparationAngle: CGFloat.M_2_PI / 12,
      firstHoleAngle: CGFloat.M_2_PI / 12 * 1.5,
      lockAngle: CGFloat.M_2_PI / 12 * 1.0,
      number: { (index) in index },
      numberFontSize: 32 + 7 * constant,
      outterDiskBound: 6,
      innerDiskBound: 12
    )
    
    models.append(model3)
  }
  
  /* Set Views */
  func setAllViews() {
    setRotaryDialView()
    setNumpadView()
    setDiskView()
    setLockView()
  }
  
  /* Set rotaryDialView */
  func setRotaryDialView() {
    rotaryDialView.holesCount = model.holesCount
    rotaryDialView.holesRadius = model.holesRadius
    rotaryDialView.distanceFromHolesToCenter = model.distanceFromHolesToCenter
    rotaryDialView.holesSeparationAngle = model.holesSeparationAngle
    rotaryDialView.firstHoleAngle = model.firstHoleAngle
    rotaryDialView.lockAngle = model.lockAngle
    rotaryDialView.number = model.number
  }
  
  /* Set numpadView */
  func setNumpadView() {
    numpadView.holesCount = model.holesCount
    numpadView.holesRadius = model.holesRadius
    numpadView.distanceFromHolesToCenter = model.distanceFromHolesToCenter
    numpadView.holesSeparationAngle = model.holesSeparationAngle
    numpadView.firstHoleAngle = model.firstHoleAngle
    numpadView.number = model.number
    numpadView.numberFontSize = model.numberFontSize
  }
  
  /* Set diskImageView */
  func setDiskView() {
    diskView.holesCount = model.holesCount
    diskView.holesRadius = model.holesRadius
    diskView.distanceFromHolesToCenter = model.distanceFromHolesToCenter
    diskView.holesSeparationAngle = model.holesSeparationAngle
    diskView.firstHoleAngle = model.firstHoleAngle
    diskView.number = model.number
    diskView.outterBound = model.outterDiskBound
    diskView.innerBound = model.innerDiskBound
  }
  
  func setLockView() {
    lockView.lockAngle = model.lockAngle
    lockView.holesRadius = model.holesRadius
    lockView.distanceFromHolesToCenter = model.distanceFromHolesToCenter
  }
}

