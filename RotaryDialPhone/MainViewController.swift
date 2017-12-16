//
//  ViewController.swift
//  RotaryDialPhone
//
//  Created by Hugo on 15/08/16.
//  Copyright © 2016 Hugo. All rights reserved.
//

import UIKit
import Contacts

class MainViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate {

    @IBOutlet weak var nameContactLabel: UILabel!
    @IBOutlet weak var numberContactLabel: UILabel!

    let keys = [CNContactIdentifierKey as CNKeyDescriptor,
                CNContactPhoneNumbersKey as CNKeyDescriptor,
                CNContactFormatter.descriptorForRequiredKeys(for:CNContactFormatterStyle.fullName)]
    let formatter = CNContactFormatter()
    let contactStore = CNContactStore()

    //var contacts = [CNContact]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.formatter.style = .fullName
        self.nameContactLabel.text = ""
        self.numberContactLabel.text = ""
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
      if #available(iOS 9.1, *) {
        searchController.obscuresBackgroundDuringPresentation = false
      } else {
        // Fallback on earlier versions
      }
        searchController.searchBar.placeholder = "Nombre del contacto"
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            navigationItem.titleView = searchController.searchBar
        }
        definesPresentationContext = true
    }

    func updateSearchResults(for searchController: UISearchController) {
        //let authorizationStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
        if let inputText = (searchController.searchBar.text), !inputText.isEmpty {
            searchContact(input: inputText)
        }
    }

    func searchContact(input: String) {
        self.nameContactLabel.alpha = 0;
        self.numberContactLabel.alpha = 0;
        DispatchQueue.global().async {
            let predicate = CNContact.predicateForContacts(matchingName: input)
            do {
                let contacts = try self.contactStore.unifiedContacts(matching: predicate, keysToFetch: self.keys)
                if(contacts.count == 0) {
                    DispatchQueue.main.async {
                        self.nameContactLabel.text = "No contact found."
                        self.numberContactLabel.text = ""
                    }
                } else {
                    for contact in contacts {
                        print(self.formatter.string(from: contact)!)
                    }
                    DispatchQueue.main.async {
                        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                            self.nameContactLabel.alpha = 1;
                            self.numberContactLabel.alpha = 1;
                            self.nameContactLabel.text = self.formatter.string(from: contacts[0])!
                            self.numberContactLabel.text = contacts[0].phoneNumbers.first!.value.stringValue
                        }, completion: nil);
                    }
                }
            } catch {
                print("Unable to fetch contacts")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
                }else if(authorizationStatus == CNAuthorizationStatus.denied){
                    DispatchQueue.main.async {
                        let message = "accessError!.localizedDescription)\n\nPlease allow the app to access your contacts through the Settings."
                        self.showMessage(msg: message)
                    }
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

    func requestContactsPermition() {

    }
}
