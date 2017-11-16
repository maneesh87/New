//
//  HeadlineCellModel.swift
//  NewsApp
//
//  Created by Maneesh Yadav on 26/10/2017.
//  Copyright © 2017 Maneesh Yadav. All rights reserved.
//

import Foundation

struct HeadlineCellModel {
  
  let headline: NSMutableAttributedString
  let date: String
  let imageUrl : URL?
  let link: String?
  
}

extension HeadlineCellModel {
  
  init(news: News) {
    let formattedString = NSMutableAttributedString().attributedString(forNews: news)
    self.headline = formattedString
    self.link = news.link
    if let date = news.date {
      self.date = dateTimeAgo(date: date)
    } else {
      self.date = ""
    }
    if let thumbnailUrl = news.thumbnail {
      self.imageUrl = URL.init(string: thumbnailUrl)
    } else {
      self.imageUrl = nil
    }
  }
  
}
