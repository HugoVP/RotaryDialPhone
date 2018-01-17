//
//  RegionSelectionViewController.swift
//  RotaryDialPhone
//
//  Created by Hugo on 16/01/18.
//

import UIKit

fileprivate let reuseIndentifier = "RegionTableViewCell"

/* Attributes */
class RegionSelectionViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  
  var selectedRegion: Int {
    get {
      return UserDefaults.standard.integer(forKey: "selected-region")
    }
    
    set {
      UserDefaults.standard.set(newValue, forKey: "selected-region")
    }
  }
}

/* Methods (UIViewController) */
extension RegionSelectionViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    
    let indexPath = IndexPath(row: selectedRegion, section: 0)
    tableView.selectRow(at: indexPath, animated: false, scrollPosition: .middle)
  }
}

/* Methods (UITableViewDelegate) */
extension RegionSelectionViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectedRegion = indexPath.row
  }
}

/* Methods (UITableViewDataSource) */
extension RegionSelectionViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return RegionsDataService.instance.items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIndentifier, for: indexPath)    
    cell.textLabel?.text = RegionsDataService.instance.items[indexPath.row].title
    
    return cell
  }
}

