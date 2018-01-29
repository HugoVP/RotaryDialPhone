//
//  RotaryDialViewController.swift
//  RotaryDialPhone
//
//  Created by Hugo on 29/08/17.
//
//

import UIKit
import AVFoundation

/* Attributes */
class RotaryDialViewController: UIViewController {
    @IBOutlet weak var rotaryDialView: RotaryDialView!
    @IBOutlet weak var numpadView: NumpadView!
    @IBOutlet weak var diskView: DiskView!
    @IBOutlet weak var lockView: LockView!
    
    var audioActivated = true;
    var audioPlayOnce = false;
    var beginAudioDial: AVAudioPlayer?
    var returnAudioDial: AVAudioPlayer?
    var endAudioDial: AVAudioPlayer?
    
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
        
        /* Setting rotary dials data service's delegate */
        // rotaryDialsDataService.delegate = self
        
        /* Load models */
        // rotaryDialsDataService.loadRotaryDialsData()
        
        if audioActivated {
            let pathReturnDial = Bundle.main.path(forResource: "dial_return", ofType: "wav")!
            let pathBeginDial = Bundle.main.path(forResource: "dial_begin", ofType: "wav")!
            let pathEndDial = Bundle.main.path(forResource: "dial_end", ofType: "wav")!
            let urlReturnDial = URL(fileURLWithPath: pathReturnDial)
            let urlEndDial = URL(fileURLWithPath: pathEndDial)
            let urlBeginDial = URL(fileURLWithPath: pathBeginDial)
            do {
                returnAudioDial = try AVAudioPlayer(contentsOf: urlReturnDial)
                returnAudioDial?.prepareToPlay()
                returnAudioDial?.numberOfLoops = -1
                endAudioDial = try AVAudioPlayer(contentsOf: urlEndDial)
                endAudioDial?.prepareToPlay()
                beginAudioDial = try AVAudioPlayer(contentsOf: urlBeginDial)
                beginAudioDial?.prepareToPlay()
            } catch {
                print(error)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /* Select a model */
        model = rotaryDialsDataService.items[selectedItem]
        
        /* Set views */
        setAllViews()
        
        numpadView.redraw()
        diskView.redraw()
        lockView.redraw()
    }
}

/* @IBAction methods */
extension RotaryDialViewController {
    @IBAction func rotateAction(_ sender: RotaryDialGestureRecognizer) {
        switch sender.state {
        case .began:
            /* Cancel all previus calls to the makePhoneCall method */
            NSObject.cancelPreviousPerformRequests(withTarget: self)
            audioPlayOnce = true
        case .changed:
            if let rotationAngle = sender.rotationAngle {
                diskView.transform = CGAffineTransform(rotationAngle: rotationAngle)
                if(audioPlayOnce) {
                    beginAudioDial?.play()
                    audioPlayOnce = false
                }
            }
        case .ended:
            /* Get the touched number and add to the full phone number */
            endAudioDial?.play()
            if let holeNumber = sender.touchedNumber {
                phoneNumber += "\(holeNumber)"
                print("Phone Number: \(phoneNumber)")
            }
            /////asdasdasd
            /* Make reset disk angle animation */
            returnAudioDial?.play()
            print("ended")
            if let rotationAngle = sender.rotationAngle {
                reverseRotationAnimation(with: rotationAngle, rotateDialGestureEnded: true)
            }
            
        case .cancelled:
            if let rotationAngle = sender.rotationAngle {
                returnAudioDial?.play()
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
                        if (self.returnAudioDial?.isPlaying)! {
                            self.returnAudioDial?.stop()
                        }
                        self.audioPlayOnce = false
                }
                )
        }
        )
    }
    
    @objc @available(iOS 10.0, *)
    func makePhoneCall() {
        // TODO: asdasdasd
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

//extension RotaryDialViewController: RotaryDialsDataServiceDelegate {
//  func rotaryDialsDataLoaded() {
//    print("data loaded")
//  }
//}

