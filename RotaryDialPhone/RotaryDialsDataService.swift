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
    
    _items.append(
      RotaryDial(
        name: "Cold Blue",
        imageName: "theme_0",
        holesCount: 10,
        holesRadius: 25 * constant,
        distanceFromHolesToCenter: 107.5 * constant,
        holesSeparationAngle: CGFloat.M_2_PI / 12.0,
        firstHoleAngle: CGFloat.M_2_PI / 12.0,
        lockAngle: 0.0,
        number: { (index) in index > 0 ? 10 - index : 0 },
        numberFontSize: 30 + 7 * constant,
        outterDiskBound: 8,
        innerDiskBound: 8,
        
        /* Image View's names */
        numpadImageViewName: "numpad_0",
        diskImageViewName: "disk_0",
        lockImageViewName: "lock_0"
      )
    )
    
    _items.append(
      RotaryDial(
        name: "Autumn",
        imageName: "theme_1",
        holesCount: 10,
        holesRadius: 25 * constant,
        distanceFromHolesToCenter: 107.5 * constant,
        holesSeparationAngle: CGFloat.M_2_PI / 12.0,
        firstHoleAngle: CGFloat.M_2_PI / 12.0,
        lockAngle: 0.0,
        number: { (index) in index > 0 ? 10 - index : 0 },
        numberFontSize: 30 + 7 * constant,
        outterDiskBound: 8,
        innerDiskBound: 8,
        
        /* Image View's names */
        numpadImageViewName: "numpad_1",
        diskImageViewName: "disk_1",
        lockImageViewName: "lock_0"
      )
    )
    
    _items.append(
      RotaryDial(
        name: "Green",
        imageName: "theme_2",
        holesCount: 10,
        holesRadius: 25 * constant,
        distanceFromHolesToCenter: 107.5 * constant,
        holesSeparationAngle: CGFloat.M_2_PI / 12.0,
        firstHoleAngle: CGFloat.M_2_PI / 12.0,
        lockAngle: 0.0,
        number: { (index) in index > 0 ? 10 - index : 0 },
        numberFontSize: 30 + 7 * constant,
        outterDiskBound: 8,
        innerDiskBound: 8,
        
        /* Image View's names */
        numpadImageViewName: "numpad_2",
        diskImageViewName: "disk_2",
        lockImageViewName: "lock_0"
      )
    )
    
    _items.append(
      RotaryDial(
        name: "Pink",
        imageName: "theme_3",
        holesCount: 10,
        holesRadius: 25 * constant,
        distanceFromHolesToCenter: 107.5 * constant,
        holesSeparationAngle: CGFloat.M_2_PI / 12.0,
        firstHoleAngle: CGFloat.M_2_PI / 12.0,
        lockAngle: 0.0,
        number: { (index) in index > 0 ? 10 - index : 0 },
        numberFontSize: 30 + 7 * constant,
        outterDiskBound: 8,
        innerDiskBound: 8,
        
        /* Image View's names */
        numpadImageViewName: "numpad_3",
        diskImageViewName: "disk_3",
        lockImageViewName: "lock_0"
      )
    )
    
    _items.append(
      RotaryDial(
        name: "Green II",
        imageName: "theme_4",
        holesCount: 10,
        holesRadius: 25 * constant,
        distanceFromHolesToCenter: 107.5 * constant,
        holesSeparationAngle: CGFloat.M_2_PI / 12.0,
        firstHoleAngle: CGFloat.M_2_PI / 12.0,
        lockAngle: 0.0,
        number: { (index) in index > 0 ? 10 - index : 0 },
        numberFontSize: 30 + 7 * constant,
        outterDiskBound: 8,
        innerDiskBound: 8,
        
        /* Image View's names */
        numpadImageViewName: "numpad_4",
        diskImageViewName: "disk_4",
        lockImageViewName: "lock_0"
      )
    )
    
    if let delegate = delegate {
      delegate.rotaryDialsDataLoaded()
    }
  }
}
