//
//  SkinCollectionViewCell.swift
//  RotaryDialPhone
//
//  Created by Hugo on 30/12/17.
//

import UIKit

class SkinCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  
  override var isSelected: Bool {
    didSet {
//      imageView.layer.borderWidth = isSelected ? 1.0 : 0.0
//      alpha = isSelected ? 0.85 : 1.0
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    imageView.layer.borderColor = UIColor.lightGray.cgColor
    isSelected = false
  }
  
  func configure(title: String, imageName: String) {
    imageView.image = UIImage(named: title)
    nameLabel.text = imageName
  }
}
