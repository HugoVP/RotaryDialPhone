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
  
  var contactViewController: ContactsViewController? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    

    let searchController = UISearchController(searchResultsController: nil)
    searchController.searchResultsUpdater = self.contactViewController
    
    if #available(iOS 9.1, *) {
      searchController.obscuresBackgroundDuringPresentation = false

    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    var contactViewController: ContactsViewController? = nil
    let searchController = UISearchController(searchResultsController: nil)
    let searchBar = UISearchBar()
    var prevHeight = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self.contactViewController
        self.searchBar.placeholder = "Nombre del contacto"
        self.searchBar.sizeToFit()
        /*searchController.searchResultsUpdater = self.contactViewController
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Nombre del contacto"
        searchController.searchBar.delegate = self.contactViewController
        searchController.searchBar.sizeToFit()
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
         } else {
            navigationItem.titleView = searchController.searchBar
        }*/
        navigationItem.titleView = self.searchBar
        definesPresentationContext = true

        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: .UIKeyboardWillHide, object: nil)
        self.prevHeight = self.heightConstraint.constant
        
    }
    
    @objc func handleKeyboardNotification(notification: Notification) {
        if let userInfo = notification.userInfo {
            if let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
                let animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval
            {
                let isKeyboardShowing = notification.name == .UIKeyboardWillShow
                let dy = isKeyboardShowing ? -keyboardFrame.height : prevHeight
                self.heightConstraint.constant = dy
                UIView.animate(withDuration: animationDuration, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //self.searchController.searchBar.endEditing(true)
        self.searchBar.endEditing(true)
        self.view.endEditing(true)
    }
    
    searchController.searchBar.placeholder = "Nombre del contacto"
    searchController.searchBar.delegate = self.contactViewController
    searchController.searchBar.showsCancelButton = false
    
    searchController.searchBar.sizeToFit()
    
//    if #available(iOS 11.0, *) {
//      navigationItem.searchController = searchController
//    } else {
//      navigationItem.titleView = searchController.searchBar
//    }
    
    definesPresentationContext = true
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
