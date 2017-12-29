//
//  SearchContactViewController.swift
//  RotaryDialPhone
//
//  Created by Hugo on 27/12/17.
//

import UIKit

class SearchContactViewController: UIViewController, UISearchResultsUpdating {
  let searchController = UISearchController(searchResultsController: nil)

  override func viewDidLoad() {
    super.viewDidLoad()

    // Setup the Search Controller
    searchController.searchResultsUpdater = self

    if #available(iOS 9.1, *) {
      searchController.obscuresBackgroundDuringPresentation = false
    }

    searchController.searchBar.placeholder = "Nombre del contacto"
    searchController.searchBar.delegate = self
    searchController.searchBar.showsCancelButton = false

    if #available(iOS 11.0, *) {
      navigationItem.searchController = searchController
    } else {
      navigationItem.titleView = searchController.searchBar
    }

    definesPresentationContext = true
  }
}

extension SearchContactViewController: UISearchBarDelegate {
  func updateSearchResults(for searchController: UISearchController) {

  }
}
