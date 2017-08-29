//
//  GestureTestVC.swift
//  RotaryDialPhone
//
//  Created by Hugo on 03/12/16.
//  Copyright © 2016 Hugo. All rights reserved.
//

import UIKit

class GestureTestVC: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var syncBtn: UIButton!
    @IBOutlet weak var syncImageView: UIImageView!

    var angle = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()

        _ = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(self .fire),
            userInfo: nil,
            repeats: true)

//        let timer = Timer.scheduledTimer(
//            timeInterval: 1.0,
//            target: self,
//            selector: #selector(fire(_:)),
//            userInfo: nil,
//            repeats: true)

//        let tapSyncBtn = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))

//        syncBtn.addGestureRecognizer(tapSyncBtn)
    }

//    @IBAction func fire (_ timer: Timer) {
    func fire () {
        print(angle)
        syncImageView.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
        angle += 0.0174533 * 25.7142857143
    }

    func startSpinning () {
        syncImageView.transform = CGAffineTransform(rotationAngle: CGFloat(/*M_PI / 2)*/angle))
        angle += 0.0174533 * 25.7142857143
    }

    @IBAction func handleTap (_ sender: UITapGestureRecognizer) {
        //      syncImageView.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
        startSpinning()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
