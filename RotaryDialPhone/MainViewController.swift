//
//  ViewController.swift
//  RotaryDialPhone
//
//  Created by Hugo on 15/08/16.
//  Copyright © 2016 Hugo. All rights reserved.
//

import UIKit
import Contacts

class MainViewController: UIViewController {
    
    var contactViewController: ContactsViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let contactViewController = segue.destination as? ContactsViewController {
            self.contactViewController = contactViewController
        } else if let destination = segue.destination as? SearchContactViewController {
            destination.deletegate = self.contactViewController
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
