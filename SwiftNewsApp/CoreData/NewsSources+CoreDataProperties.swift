//
//  NewsSources+CoreDataProperties.swift
//  NewsApp
//
//  Created by Maneesh Yadav on 21/09/2017.
//  Copyright © 2017 Maneesh Yadav. All rights reserved.
//
//

import Foundation
import CoreData


extension NewsSources {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsSources> {
        return NSFetchRequest<NewsSources>(entityName: "NewsSources")
    }

    @NSManaged public var imageName: String?
    @NSManaged public var isLanguageLeftAligned: Bool
    @NSManaged public var isSelected: Bool
    @NSManaged public var lastSyncedTime: NSDate?
    @NSManaged public var name: String?
    @NSManaged public var url: String?
    @NSManaged public var news: NSSet?

}

// MARK: Generated accessors for news
extension NewsSources {

    @objc(addNewsObject:)
    @NSManaged public func addToNews(_ value: News)

    @objc(removeNewsObject:)
    @NSManaged public func removeFromNews(_ value: News)

    @objc(addNews:)
    @NSManaged public func addToNews(_ values: NSSet)

    @objc(removeNews:)
    @NSManaged public func removeFromNews(_ values: NSSet)

}
