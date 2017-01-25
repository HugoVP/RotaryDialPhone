//
//  ContactsViewController.swift
//  iOSHelloWorld
//
//  Created by Jose Carabez on 03/12/16.
//  Copyright © 2016 Hugo. All rights reserved.
//

import UIKit
import Contacts

class ContactsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var contactsList : [String] = []
    let cellIdentifier = "cellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getContacts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let contactItem = contactsList[indexPath.row]
        cell.textLabel?.text = contactItem
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsList.count
    }
    
    func getContacts() {
        let keys = CNContactFetchRequest(keysToFetch: [CNContactIdentifierKey as CNKeyDescriptor, CNContactPhoneNumbersKey as CNKeyDescriptor, CNContactFormatter.descriptorForRequiredKeys(for: CNContactFormatterStyle.fullName)])
        let formatter = CNContactFormatter()
        formatter.style = .fullName
        
        let contactsStore = CNContactStore()
        do {
            try contactsStore.enumerateContacts(with: keys, usingBlock:
                {(contact: CNContact, cursor: UnsafeMutablePointer<ObjCBool>) -> Void in
                    if(!contact.phoneNumbers.isEmpty){
                        print("---------------------\n")
                        let name = formatter.string(from: contact)
                        print(name!)
                        print("\(contact.phoneNumbers.first!.value.stringValue) \n")
                        self.contactsList.append(name!)
                    }
                })
        } catch {
            print("Unable to fetch contacts")
        }
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

    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
