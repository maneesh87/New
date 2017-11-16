//
//  FeedSelectionTableViewCell.swift
//  NewsApp
//
//  Created by Maneesh Yadav on 21/10/2017.
//  Copyright © 2017 Maneesh Yadav. All rights reserved.
//

import UIKit
import BEMCheckBox

class FeedSelectionTableViewCell: UITableViewCell, CellReuse {
  
  //MARK: - Outlet
  @IBOutlet weak var name: UILabel!
  @IBOutlet weak var checkBox: BEMCheckBox!
  
  // MARK: - Functions
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    self.selectionStyle = .none;
  }
  
  func configureCell(withFeed feed: NewsSources) {
    name.text = feed.name
    checkBox.setOn(feed.isSelected, animated: false)
  }
    
}
