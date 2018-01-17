//
//  RotaryDialSettingsViewController.swift
//  RotaryDialPhone
//
//  Created by Hugo on 26/12/17.
//

import UIKit

class SettingsViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  
  var selectedItem: Int {
    return UserDefaults.standard.integer(forKey: "selected-item")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }
}

extension SettingsViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: UITableViewCell!
    
    if indexPath.row == 0 {
      cell = tableView.dequeueReusableCell(withIdentifier: "SkinSelectionTableViewCell", for: indexPath)
      cell.detailTextLabel?.text = "\(selectedItem)"
    }
    
    else if indexPath.row == 1 {
      cell = tableView.dequeueReusableCell(withIdentifier: "RegionSelectionTableViewCell", for: indexPath)
    }
    
    else {
      cell = UITableViewCell()
    }
    
    return cell
  }
}
