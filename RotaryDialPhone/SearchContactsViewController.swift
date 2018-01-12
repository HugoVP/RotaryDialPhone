//
//  SearchContactViewController.swift
//  RotaryDialPhone
//
//  Created by Hugo on 27/12/17.
//

import UIKit
import Contacts

class SearchContactViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var contactTableView: UITableView!
    
    var deletegate: ContactDelegate?
    var isSearching = false
    var contactsList = [CNContact]();
    
    let cellId = "ContactCell"
    let contactStore = CNContactStore()
    let contactFormatter = CNContactFormatter()
    let searchController = UISearchController(searchResultsController: nil)
    let searchDelay = DispatchTime(uptimeNanoseconds: 100)
    let keys = [CNContactIdentifierKey as CNKeyDescriptor,
                CNContactPhoneNumbersKey as CNKeyDescriptor,
                CNContactFormatter.descriptorForRequiredKeys(for:CNContactFormatterStyle.fullName)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.definesPresentationContext = true
        self.contactFormatter.style = .fullName
        
        self.searchController.searchBar.placeholder = "Nombre del contacto"
        self.searchController.searchBar.delegate = self
        
        self.contactTableView.delegate = self
        self.contactTableView.dataSource = self
        
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            contactTableView.tableHeaderView = searchController.searchBar
            
        }
        
        if #available(iOS 9.1, *) {
            self.searchController.obscuresBackgroundDuringPresentation = false
        }
        
        definesPresentationContext = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contactsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath)
        cell.textLabel?.text = self.contactFormatter.string(from: self.contactsList[indexPath.row])
        cell.detailTextLabel?.text = self.contactsList[indexPath.row].phoneNumbers.first?.value.stringValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        deletegate?.onReceive(contactName: self.contactFormatter.string(from: self.contactsList[indexPath.row]), contactPhoneNumber: self.contactsList[indexPath.row].phoneNumbers.first?.value.stringValue)
        navigationController?.popViewController(animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let authorizationStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
        if let searchName = (searchBar.text), !searchName.isEmpty, authorizationStatus == .authorized {
            if self.isSearching { return }
            self.isSearching = true
            let predicate = CNContact.predicateForContacts(matchingName: searchName)
            DispatchQueue.global().asyncAfter(deadline: self.searchDelay) {
                do {
                    self.contactsList = try self.contactStore.unifiedContacts(matching: predicate, keysToFetch: self.keys)
                } catch {
                    print("Unable to fetch contacts")
                }
                self.isSearching = false
                DispatchQueue.main.async {
                    self.contactTableView.reloadData()
                }
            }
        }
    }
}

