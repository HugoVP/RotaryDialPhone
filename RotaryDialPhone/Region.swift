//
//  Region.swift
//  RotaryDialPhone
//
//  Created by Hugo on 17/01/18.
//

import Foundation

struct Region {
  private var _title: String!
  
  var title: String {
    return _title
  }
  
  init(title: String) {
    _title = title
  }
}
