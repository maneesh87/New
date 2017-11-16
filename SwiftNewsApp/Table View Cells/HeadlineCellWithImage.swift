//
//  HeadlineCellWithImage.swift
//  NewsApp
//
//  Created by Maneesh Yadav on 07/10/2017.
//  Copyright © 2017 Maneesh Yadav. All rights reserved.
//

import UIKit
import SDWebImage

class HeadlineCellWithImage: UITableViewCell, CellReuse {
  
  //MARK: - Outlet
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var headline: UILabel!
  @IBOutlet weak var imageStackView: UIStackView!
  @IBOutlet weak var headlineImage: UIImageView!
  
  // MARK: - Functions
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    headlineImage.layer.cornerRadius = 5.0
    headlineImage.clipsToBounds = true
  }
  
  var cellModel: HeadlineCellModel? {
    didSet {
      
      dateLabel.text = cellModel?.date
      headline.attributedText = cellModel?.headline
      
      if let imageURL = cellModel?.imageUrl {
        imageStackView.isHidden = false
        headlineImage.sd_setImage(with: imageURL)
      } else {
        imageStackView.isHidden = true
      }
    }
  }

}
