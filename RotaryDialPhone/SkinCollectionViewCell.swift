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
      if isSelected {
        imageView.layer.borderWidth = 1.0
        alpha = 0.85
      }

      else {
        imageView.layer.borderWidth = 0.0
        alpha = 1.0
      }
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    imageView.layer.borderColor = UIColor.lightGray.cgColor
    isSelected = false
  }
  
  func configure(title: String, imageName: String) {
    nameLabel.text = title
    imageView.image = UIImage(named: imageName)
  }
}
