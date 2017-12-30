//
//  SkinSelectionViewController.swift
//  RotaryDialPhone
//
//  Created by Hugo on 28/12/17.
//

import UIKit

let reuseIdentifier = "SkinCollectionViewCell"
let skinCellSize = (UIScreen.main.bounds.width - 40.0) / 2.0 - 1.0
let skinNameLabelSize: CGFloat = 21.0

class SkinSelectionViewController: UIViewController {
  @IBOutlet weak var collectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.delegate = self
    collectionView.dataSource = self
  }
}

extension SkinSelectionViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print(indexPath.row)
    
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
    
    cell.configure(title: "skin_1", imageName: "skin_1")
    
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
}

