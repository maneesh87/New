//
//  NSMutableAttributedString+Font.swift
//  NewsApp
//
//  Created by Maneesh Yadav on 07/10/2017.
//  Copyright © 2017 Maneesh Yadav. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {
    
    @discardableResult func bold(_ text: String) -> NSMutableAttributedString {
      let attrs : [NSAttributedStringKey : Any] = [NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue) : UIFont.boldSystemFont(ofSize: 16)]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    
    @discardableResult func normal(_ text: String)->NSMutableAttributedString {
      let attrs : [NSAttributedStringKey : Any] = [NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue) : UIFont.systemFont(ofSize: 14)]
        let normal = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(normal)
        return self
    }
    
    @discardableResult func attributedString(forNews news:  News) -> NSMutableAttributedString {
        var headlineTxt = news.title ?? noTitleText
        headlineTxt = headlineTxt + "\n"
        let descrition = news.content ?? noDescriptionText
        self.bold(headlineTxt).normal(descrition)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = 5
        paragraphStyle.lineSpacing = 2
        paragraphStyle.lineBreakMode = .byTruncatingTail

        let textFontAttributes = [ NSAttributedStringKey.paragraphStyle: paragraphStyle ]
        self.addAttributes(textFontAttributes, range: NSMakeRange(0, self.length))
        return self
    }
    
}

