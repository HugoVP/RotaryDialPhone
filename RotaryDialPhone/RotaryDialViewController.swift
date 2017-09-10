//
//  RotaryDialViewController.swift
//  RotaryDialPhone
//
//  Created by Hugo on 29/08/17.
//
//

import UIKit

class RotaryDialViewController: UIViewController {
    @IBOutlet weak var diskView: DiskView!
    var model: RotaryDial!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /* Model params */
        let holeRadius: CGFloat!
        let distanceToCenter: CGFloat!
        
        /* Set params based on screen size */
        switch UIScreen.main.bounds.width {
        case 320:
            holeRadius = 45.0
            distanceToCenter = 112.5
        case 375:
            holeRadius = 52.734375
            distanceToCenter = 131.8359375
        default: /* 414 */
            holeRadius = 58.21875
            distanceToCenter = 145.546875
        }
        
        model = RotaryDial(
            center: CGPoint(
                x: diskView.bounds.midX,
                y: diskView.bounds.midY
            ),
            holeRadius: holeRadius / 2,
            distanceFromHolesToCenter: distanceToCenter,
            firstHoleAngle: 2.5 * CGFloat.pi / 7.0,
            holesSeparationAngle: CGFloat.pi / 7.0
        )
        
        diskView.setModel(model)
    }
}
