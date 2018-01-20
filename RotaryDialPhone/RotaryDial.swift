//
//  RotaryDial.swift
//  RotaryDialPhone
//
//  Created by Hugo on 20/12/17.
//

import UIKit

struct RotaryDial {
  private var _name: String!
  private var _imageName: String!
  private var _holesCount: Int!
  private var _holesRadius: CGFloat!
  private var _distanceFromHolesToCenter: CGFloat!
  private var _holesSeparationAngle: CGFloat!
  private var _firstHoleAngle: CGFloat!
  
  private var _lockAngle: CGFloat!
  private var _number: ((Int) -> Int)!
  
  /* Temp attrs */
  private var _numberFontSize: CGFloat!
  private var _outterDiskBound: CGFloat!
  private var _innerDiskBound: CGFloat!
  
  /* Image Views' names */
  private var _numpadImageViewName: String!
  private var _diskImageViewName: String!
  private var _lockImageViewName: String!
  
  var name: String {
    return _name
  }
  
  var imageName: String {
    return _imageName
  }
  
  var holesCount: Int {
    return _holesCount
  }
  
  var holesRadius: CGFloat {
    return _holesRadius
  }
  
  var distanceFromHolesToCenter: CGFloat {
    return _distanceFromHolesToCenter
  }
  
  var holesSeparationAngle: CGFloat {
    return _holesSeparationAngle
  }
  
  var firstHoleAngle: CGFloat {
    return _firstHoleAngle
  }
  
  var lockAngle: CGFloat {
    return _lockAngle
  }
  
  var number: (Int) -> Int {
    return _number
  }
  
  var numberFontSize: CGFloat {
    return _numberFontSize
  }
  
  var outterDiskBound: CGFloat {
    return _outterDiskBound
  }
  
  var innerDiskBound: CGFloat {
    return _innerDiskBound
  }
  
  /* Image Views' names */
  
  var numpadImageViewName: String {
    return _numpadImageViewName
  }
  
  var diskImageViewName: String {
    return _diskImageViewName
  }
  
  var lockImageViewName: String {
    return _lockImageViewName
  }
  
  init(
    name: String,
    imageName: String,
    holesCount: Int,
    holesRadius: CGFloat,
    distanceFromHolesToCenter: CGFloat,
    holesSeparationAngle: CGFloat,
    firstHoleAngle: CGFloat,
    lockAngle: CGFloat,
    number: ((Int) -> Int)!,
    numberFontSize: CGFloat,
    outterDiskBound: CGFloat,
    innerDiskBound: CGFloat,
    
    /* Image View's names */
    numpadImageViewName: String,
    diskImageViewName: String,
    lockImageViewName: String
  ) {
    _name = name
    _imageName = imageName
    _holesCount = holesCount
    _holesRadius = holesRadius
    _distanceFromHolesToCenter = distanceFromHolesToCenter
    _holesSeparationAngle = holesSeparationAngle
    _firstHoleAngle = firstHoleAngle
    _lockAngle = lockAngle
    _number = number
    _numberFontSize = numberFontSize
    _outterDiskBound = outterDiskBound
    _innerDiskBound = innerDiskBound
    
    /* Image View's names */
    _numpadImageViewName = numpadImageViewName
    _diskImageViewName = diskImageViewName
    _lockImageViewName = lockImageViewName
  }
}
