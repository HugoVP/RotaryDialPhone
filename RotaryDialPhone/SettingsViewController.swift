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
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "SkinSelectionTableViewCell", for: indexPath)
    
    cell.detailTextLabel?.text = "\(selectedItem)"
    
    return cell
  }
}
