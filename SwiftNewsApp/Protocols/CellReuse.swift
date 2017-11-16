//
//  CellReuse.swift
//  NewsApp
//
//  Created by Maneesh Yadav on 12/10/2017.
//  Copyright © 2017 Maneesh Yadav. All rights reserved.
//

import Foundation

protocol CellReuse {
  static var identifier: String {get}
}

extension CellReuse {
  static var identifier: String {
    return String(describing: self)
  }
}
