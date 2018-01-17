//
//  DataService.swift
//  RotaryDialPhone
//
//  Created by Hugo on 10/01/18.
//

import UIKit

protocol RotaryDialsDataServiceDelegate: class {
  func rotaryDialsDataLoaded()
}

class RotaryDialsDataService {
  static let instance = RotaryDialsDataService()
  weak var delegate: RotaryDialsDataServiceDelegate?
  private var _items = [RotaryDial]()
  
  var items: [RotaryDial] {
    return _items
  }
  
  func loadData() {
    let constant = UIScreen.main.bounds.width / 320.0
    
    /* Set Model 1 */
    let model1 = RotaryDial(
      name: "Skin. No. 1",
      imageName: "skin_0",
      holesCount: 10,
      holesRadius: 45.0 / 2 * constant,
      distanceFromHolesToCenter: 112.5 * constant,
      holesSeparationAngle: CGFloat.M_2_PI / 14.0,
      firstHoleAngle: CGFloat.M_2_PI / 14.0 * 2.5,
      lockAngle: CGFloat.M_2_PI / 14.0 * 1.5,
      number: { (index) in index > 0 ? 10 - index : 0 },
      numberFontSize: 30 + 7 * constant,
      outterDiskBound: 8,
      innerDiskBound: 8
    )
    
    _items.append(model1)
    
    /* Set Model 2 */
    let model2 = RotaryDial(
      name: "Skin. No. 2",
      imageName: "skin_1",
      holesCount: 10,
      holesRadius: 58.0 / 2 * constant,
      distanceFromHolesToCenter: 115.0 * constant,
      holesSeparationAngle: CGFloat.M_2_PI / 11.5,
      firstHoleAngle: CGFloat.M_2_PI / 11.5 * 1.25,
      lockAngle: CGFloat.M_2_PI / 11.5 * 0.25,
      number: { (index) in index > 0 ? 10 - index : 0 },
      numberFontSize: 37 + 7 * constant,
      outterDiskBound: 8,
      innerDiskBound: 8
    )
    
    _items.append(model2)
    
    /* Set Model 3 */
    let model3 = RotaryDial(
      name: "Skin. No. 3",
      imageName: "skin_2",
      holesCount: 10,
      holesRadius: 50.0 / 2 * constant,
      distanceFromHolesToCenter: 115.0 * constant,
      holesSeparationAngle: CGFloat.M_2_PI / 12,
      firstHoleAngle: CGFloat.M_2_PI / 12 * 1.5,
      lockAngle: CGFloat.M_2_PI / 12 * 1.0,
      number: { (index) in index },
      numberFontSize: 32 + 7 * constant,
      outterDiskBound: 6,
      innerDiskBound: 12
    )
    
    _items.append(model3)
    
    if let delegate = delegate {
      delegate.rotaryDialsDataLoaded()
    }
  }
}
