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
  
  func configure(title: String, imageName: String) {
    imageView.image = UIImage(named: title)
    nameLabel.text = imageName
  }
}
