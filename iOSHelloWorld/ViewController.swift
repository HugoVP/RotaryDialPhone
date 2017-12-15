//
//  ViewController.swift
//  iOSHelloWorld
//
//  Created by Hugo on 15/08/16.
//  Copyright © 2016 Hugo. All rights reserved.
//

import UIKit
import Contacts

class ViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate {
   
    @IBOutlet weak var nameContactLabel: UILabel!
    @IBOutlet weak var numberContactLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
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
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if let inputText = (searchBar.text), !inputText.isEmpty {
            searchContact(input: inputText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text!)
    }
    
    
    @IBAction func contactInput(_ sender: UITextField) {
        if let inputText = (sender.text), !inputText.isEmpty {
            searchContact(input: inputText)
        }
    }
    
    func searchContact(input: String) {
        DispatchQueue.global().async {
            let predicate = CNContact.predicateForContacts(matchingName: input)
            let keys = [CNContactIdentifierKey as CNKeyDescriptor,
                        CNContactPhoneNumbersKey as CNKeyDescriptor,
                        CNContactFormatter.descriptorForRequiredKeys(for:CNContactFormatterStyle.fullName)]
            let formatter = CNContactFormatter()
            formatter.style = .fullName
            
            let contactStore = CNContactStore()
            
            var contacts = [CNContact]()
            do {
                contacts = try contactStore.unifiedContacts(matching: predicate, keysToFetch: keys)
                if(contacts.count == 0) {
                    DispatchQueue.main.async {
                        self.nameContactLabel.text = "No contact found."
                        self.numberContactLabel.text = ""
                    }
                } else {
                    for contact in contacts {
                        print(formatter.string(from: contact)!)
                    }
                    DispatchQueue.main.async {
                        self.nameContactLabel.text = formatter.string(from: contacts[0])!
                        self.numberContactLabel.text = contacts[0].phoneNumbers.first!.value.stringValue
                    }
                }
            } catch {
                print("Unable to fetch contacts")
            }
        }
    }
    
    func getContacts() {
        /*DispatchQueue.global().async {
            let keys = CNContactFetchRequest(keysToFetch: [CNContactIdentifierKey as CNKeyDescriptor, CNContactPhoneNumbersKey as CNKeyDescriptor, CNContactFormatter.descriptorForRequiredKeys(for: CNContactFormatterStyle.fullName)])
            let formatter = CNContactFormatter()
            formatter.style = .fullName
            
            let contactsStore = CNContactStore()
            do {
                try contactsStore.enumerateContacts(with: keys, usingBlock:
                {(contact: CNContact, cursor: UnsafeMutablePointer<ObjCBool>) -> Void in
                    if(!contact.phoneNumbers.isEmpty) {
                        let curretnName = formatter.string(from: contact)
                        let currentNumber = contact.phoneNumbers.first!.value.stringValue
                        let contact = Contact(name: curretnName!, number: currentNumber)
                        self.contactsList.append(contact)
                    }
                })
            } catch {
                print("Unable to fetch contacts")
            }
            DispatchQueue.main.async {
                self.mTableView.reloadData()
            }
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func requestForAccess(completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
        // Get authorization
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

