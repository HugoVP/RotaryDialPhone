//
//  RotaryDialSettingsViewController.swift
//  RotaryDialPhone
//
//  Created by Hugo on 26/12/17.
//

import UIKit

/* Attributes */
class SettingsViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  
  var selectedItem: Int {
    return UserDefaults.standard.integer(forKey: "selected-item")
  }
  
  var rotaryDialsDataService = RotaryDialsDataService.instance
}

/* Methods (UIViewController) */
extension SettingsViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }
}

/* Methods (UITableViewDataSource) */
extension SettingsViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: UITableViewCell!
      
    switch indexPath.row {
    case 0:
      cell = tableView.dequeueReusableCell(withIdentifier: "SkinSelectionTableViewCell", for: indexPath)
      
      if let detailTextLabel = cell.detailTextLabel {
        let rotaryDialName = rotaryDialsDataService.items[selectedItem].name
        detailTextLabel.text = rotaryDialName
      }
    default:
      cell = UITableViewCell()
    }
    
    return cell
  }
}
