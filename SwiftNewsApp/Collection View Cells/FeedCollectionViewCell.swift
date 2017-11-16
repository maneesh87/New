//
//  SiteCell.swift
//  NewsApp
//
//  Created by Maneesh Yadav on 12/10/2017.
//  Copyright © 2017 Maneesh Yadav. All rights reserved.
//

import UIKit

class FeedCollectionViewCell: UICollectionViewCell, CellReuse {
  
  //MARK: - Outlet
  @IBOutlet weak var name: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  
  // MARK: - Functions
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    name.textColor = UIColor.white
    name.backgroundColor = UIColor.clear
  }
  
  var cellModel: SourceCellModel? {
    didSet {
      name.text = cellModel?.name
      if let imageName = cellModel?.imageURL {
        imageView.image = UIImage.init(named: imageName)
      }
    }
  }
  
}
