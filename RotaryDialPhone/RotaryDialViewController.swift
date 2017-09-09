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
        
        model = RotaryDial(
            holesSize: 100.0,
            distanceFromHolesToCenter: 100.0
        )
        
        diskView.setModel(model)
        print(diskView.model)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
