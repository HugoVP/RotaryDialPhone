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
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    var contactViewController: ContactsViewController? = nil
    let searchController = UISearchController(searchResultsController: nil)
    var prevHeight = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self.contactViewController
        if #available(iOS 9.1, *) {
            searchController.obscuresBackgroundDuringPresentation = false
        }
        searchController.searchBar.placeholder = "Nombre del contacto"
        searchController.searchBar.delegate = self.contactViewController
        searchController.searchBar.sizeToFit()
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
         } else {
            navigationItem.titleView = searchController.searchBar
        }
        definesPresentationContext = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        prevHeight = self.heightConstraint.constant
        
    }
    
    @objc func handleKeyboardNotification(notification: Notification) {
        if let userInfo = notification.userInfo {
            if let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                let isKeyboardShowing = notification.name == .UIKeyboardWillShow
                let dy = isKeyboardShowing ? -keyboardFrame.height : prevHeight
                UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
                    self.heightConstraint.constant = dy
                    self.contactViewController?.view.layoutIfNeeded()
                }, completion: nil)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchController.searchBar.endEditing(true)
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let contactViewController = segue.destination as? ContactsViewController {
            self.contactViewController = contactViewController
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
