//
//  RotaryDialViewController.swift
//  RotaryDialPhone
//
//  Created by Hugo on 29/08/17.
//
//

import UIKit

/* Attributes */
class RotaryDialViewController: UIViewController {
  @IBOutlet weak var rotaryDialView: RotaryDialView!
  @IBOutlet weak var numpadImageView: UIImageView!
  @IBOutlet weak var diskImageView: UIImageView!
  @IBOutlet weak var lockImageView: UIImageView!
  
  var model: RotaryDial!
  
  var phoneNumber = ""
  
  /* Delay before perform the call */
  /* when a phone number has been successfully entered */
  let delayBeforeTheCall = 1.15
  
  /* Rotation animation */
  let baseRotationAnimationTime: CGFloat = 0.4
  
  var baseRotationAnimationAngle: CGFloat {
    return 4.0 * rotaryDialView.holesSeparationAngle
  }
  
  var selectedItem: Int {
    return UserDefaults.standard.integer(forKey: "selected-item")
  }
  
  var rotaryDialsDataService = RotaryDialsDataService.instance
}

/* UIViewController Methods */
extension RotaryDialViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    /* Select a model */
    model = rotaryDialsDataService.items[selectedItem]
    
    /* Set views */
    setAllViews()
  }
}

/* @IBAction methods */
extension RotaryDialViewController {
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

/* Custom methods */
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
              /* Tempt to perform makePhoneCall method */
              /* Can be cancelled by the beginning of the gesture recognizer */
              if #available(iOS 10.0, *) {
                self.perform(#selector(self.makePhoneCall), with: nil, afterDelay: self.delayBeforeTheCall)
              }
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
  
  /* Set Views */
  func setAllViews() {
    setRotaryDialView()
    setNumpadImageView()
    setDiskImageView()
    setLockImageView()
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
  func setNumpadImageView() {
    numpadImageView.image = UIImage(named: model.numpadImageViewName)
  }
  
  /* Set diskImageView */
  func setDiskImageView() {
    diskImageView.image = UIImage(named: model.diskImageViewName)
  }
  
  func setLockImageView() {
    lockImageView.image = UIImage(named: model.lockImageViewName)
  }
}
