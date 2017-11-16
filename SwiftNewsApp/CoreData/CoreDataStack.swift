//
//  CoreDataStack.swift
//  NewsApp
//
//  Created by Maneesh Yadav on 11/11/2017.
//  Copyright © 2017 Maneesh Yadav. All rights reserved.
//

import CoreData

class CoreDataStack {
  
  let persistentContainer: NSPersistentContainer!
  
  // Mark: - Default init
  convenience init() {
    //Use the default container for production environment
    let container = NSPersistentContainer(name: "SwiftNewsApp")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    self.init(container: container)
  }
  
  //MARK: - Init with dependency
  init(container: NSPersistentContainer) {
    self.persistentContainer = container
    self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
  }
  
  // Mark: - Properties
  lazy var managedObjectContext: NSManagedObjectContext = {
    return persistentContainer.viewContext
  }()
  
  // MARK: - Core Data Saving support
  func saveContext () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
}
