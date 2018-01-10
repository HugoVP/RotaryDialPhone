//
//  SkinSelectionViewController.swift
//  RotaryDialPhone
//
//  Created by Hugo on 28/12/17.
//

import UIKit

fileprivate let reuseIdentifier = "SkinCollectionViewCell"
fileprivate let itemsPerRow: CGFloat = 2.0
fileprivate let sectionInsets = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
fileprivate let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
fileprivate let availableWidth = UIScreen.main.bounds.width - paddingSpace
fileprivate let skinCellSize = availableWidth / itemsPerRow
fileprivate let skinNameLabelSize: CGFloat = 21.0

class SkinSelectionViewController: UIViewController {
  @IBOutlet weak var collectionView: UICollectionView!
  
  var selectedItem: Int {
    get {
      return UserDefaults.standard.integer(forKey: "selected-item")
    }
    
    set {
      UserDefaults.standard.set(newValue, forKey: "selected-item")
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.delegate = self
    collectionView.dataSource = self
    let indexPath = IndexPath(row: selectedItem, section: 0)
    collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredVertically)
  }
}

extension SkinSelectionViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    selectedItem = indexPath.row
  }
}

extension SkinSelectionViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: reuseIdentifier,
      for: indexPath
    ) as? SkinCollectionViewCell
    
    else {
      return UICollectionViewCell()
    }
    
    cell.configure(title: "skin_1", imageName: "skin_\(indexPath.row)")
    
    return cell
  }
}

extension SkinSelectionViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(
      width: skinCellSize,
      height: skinCellSize + skinNameLabelSize
    )
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInsets
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return sectionInsets.left
  }
}

