//
//  ContactsViewController.swift
//  RotaryDialPhone
//
//  Created by Jose Carabez on 03/12/16.
//  Copyright © 2016 Hugo. All rights reserved.
//

import UIKit
import Contacts

class ContactsViewController: UIViewController, ContactDelegate {
        
    @IBOutlet weak var numberContactLabel: UILabel!
    @IBOutlet weak var nameContactLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.numberContactLabel.text = ""
        self.nameContactLabel.text = ""
        requestForAccess { (accessGranted) in
            // Nothing here just ask for contacts acces
        }
    }
    
    func onReceive(contactName: String?, contactPhoneNumber: String?) {
        self.nameContactLabel.text = contactName
        self.numberContactLabel.text = contactPhoneNumber
    }
    
    func requestForAccess(completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
        let authorizationStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
        switch authorizationStatus {
        case .authorized:
            completionHandler(true)
        case .denied, .notDetermined:
            CNContactStore().requestAccess(for: CNEntityType.contacts, completionHandler: { (access, error) -> Void in
                if(access){
                    completionHandler(access)
                } else if(authorizationStatus == CNAuthorizationStatus.denied) {
                    // It is not necessary for now
                    /*DispatchQueue.main.async {
                        let message = "accessError!.localizedDescription)\n\nPlease allow the app to access your contacts through the Settings."
                        self.showMessage(msg: message)
                    }*/
                    completionHandler(false)
                }
            })
        default:
            completionHandler(false)
        }
    }

    func showMessage(msg: String) {
        let alertController = UIAlertController(title: "Alert", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        let dismissAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action) -> Void in }
        alertController.addAction(dismissAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
