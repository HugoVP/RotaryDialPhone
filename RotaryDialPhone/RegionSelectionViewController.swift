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
  var regions = ["Mexico", "USA", "Canada"]
}

/* Methods (UIViewController) */
extension RegionSelectionViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
  }
}

extension RegionSelectionViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return regions.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIndentifier, for: indexPath)    
    cell.textLabel?.text = regions[indexPath.row]
    
    return cell
  }
}

