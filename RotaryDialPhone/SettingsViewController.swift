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
  
  var selectedRegion: Int {
    return UserDefaults.standard.integer(forKey: "selected-region")
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
    
    switch indexPath.row {
    case 0:
      cell = tableView.dequeueReusableCell(withIdentifier: "SkinSelectionTableViewCell", for: indexPath)
      
      if let detailTextLabel = cell.detailTextLabel {
        let rotaryDialName = RotaryDialsDataService.instance.items[selectedItem].name
        detailTextLabel.text = rotaryDialName
      }
      
    case 1:
      cell = tableView.dequeueReusableCell(withIdentifier: "RegionSelectionTableViewCell", for: indexPath)
      
      if let detailTextLabel = cell.detailTextLabel {
        let regionTitle = RegionsDataService.instance.items[selectedRegion].title
        detailTextLabel.text = regionTitle
      }
      
    default:
      cell = UITableViewCell()
    }
    
    return cell
  }
}
