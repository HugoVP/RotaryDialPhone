//
//  RegionDataService.swift
//  RotaryDialPhone
//
//  Created by Hugo on 17/01/18.
//

import Foundation

protocol RegionsDataServiceDelegate: class {
  func regionsDataLoaded()
}

class RegionsDataService {
  static let instance = RegionsDataService()
  weak var delegate: RegionsDataServiceDelegate?
  private var _items = [Region]()
  
  var items: [Region] {
    return _items
  }
  
  func loadData() {
    _items.append(Region(title: "Mexico"))
    _items.append(Region(title: "USA"))
    _items.append(Region(title: "Canada"))
    
    if let delegate = delegate {
      delegate.regionsDataLoaded()
    }
  }
}
