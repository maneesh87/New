//
//  SourceCellModel.swift
//  NewsApp
//
//  Created by Maneesh Yadav on 10/11/2017.
//  Copyright © 2017 Maneesh Yadav. All rights reserved.
//

import Foundation

struct SourceCellModel {
  
  let imageURL: String?
  let name: String
  let link: String

}

extension SourceCellModel {
  
  init?(source: NewsSources) {
    self.imageURL = source.imageName
    if let link = source.url, let name = source.name {
      self.link = link
      self.name = name
    } else {
      return nil
    }
  }
  
}
