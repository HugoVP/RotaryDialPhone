//
//  ContactsViewController.swift
//  RotaryDialPhone
//
//  Created by Jose Carabez on 03/12/16.
//  Copyright © 2016 Hugo. All rights reserved.
//

import UIKit
import Contacts

class ContactsViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onClick(_ sender: UIButton) {
        print("Click desde contactos")
        print("Test")
    }

    func requestForAccess(completionHandler: (_ accessGranted: Bool) -> Void) {
        // Get authorization
        let authorizationStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)

        switch authorizationStatus {
        case .authorized:
            break
        case .denied, .notDetermined:
            break
        default:
            break
        }
    }

    func showMessage(msg: String) {
        let alertController = UIAlertController(title: "Alert", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        let dismissAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action) -> Void in }
        alertController.addAction(dismissAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
