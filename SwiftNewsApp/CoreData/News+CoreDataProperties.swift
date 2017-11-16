//
//  News+CoreDataProperties.swift
//  NewsApp
//
//  Created by Maneesh Yadav on 21/09/2017.
//  Copyright © 2017 Maneesh Yadav. All rights reserved.
//
//

import Foundation
import CoreData


extension News {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<News> {
        return NSFetchRequest<News>(entityName: "News")
    }

    @NSManaged public var content: String?
    @NSManaged public var date: Date?
    @NSManaged public var identifier: String?
    @NSManaged public var link: String?
    @NSManaged public var thumbnail: String?
    @NSManaged public var title: String?
    @NSManaged public var feed: NewsSources?

}
