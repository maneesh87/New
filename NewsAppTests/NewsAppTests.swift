//
//  NewsAppTests.swift
//  NewsAppTests
//
//  Created by Maneesh Yadav on 18/10/2017.
//  Copyright © 2017 Maneesh Yadav. All rights reserved.
//

import XCTest
import CoreData

@testable import NewsApp

class NewsAppTests: XCTestCase {
  
  //MARK: - mock NewsSource
  var newsSource: NewsSources!
  var newsSource2: NewsSources!
  
  //MARK: - mock CoreDataStack
  var coreDataStack: CoreDataStack!
  
  //MARK: - Setup
  override func setUp() {
    super.setUp()
    initStubs()
  }
  
  //MARK: - Teardown
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
    flushData()
  }
  
  //MARK: - Test
  func testToFetchSourceData() {
    guard let data = readDataFromPlist() else {
      XCTAssertTrue(false)
      return
    }
    XCTAssertTrue(data.count > 0)
    let model = NewsSite(newsSite: data.first!)
    XCTAssertNotNil(model?.name)
    let newsSourceModel = NewsSources(fromNewsSite: model!, inContext: coreDataStack.managedObjectContext)
    XCTAssert(model?.name == newsSourceModel.name)
  }
  
  func testToGetSelectedSource() {
    let sourceListDataManager = SourceListDataManager(context: coreDataStack.managedObjectContext, dataType: .SelectedSource)
    let rowCount = sourceListDataManager.rowCount
    XCTAssert(rowCount == 2)
  }
  
  func testToGetUnSelectedSource() {
    let sourceListDataManager = SourceListDataManager(context: coreDataStack.managedObjectContext, dataType: .SelectedSource)
    newsSource2.isSelected = false
    coreDataStack.saveContext()
    let rowCount = sourceListDataManager.rowCount
    XCTAssert(rowCount == 1)
  }
  
  func testToGetSourceViewModelFromDataManager() {
    let sourceListDataManager = SourceListDataManager(context: coreDataStack.managedObjectContext, dataType: .SelectedSource)
    let cellModel = sourceListDataManager.getViewModel(index: 0)
    XCTAssertNotNil(cellModel)
  }
  
  func testToGetNewCountFromDataManager() {
    let headlineDataManager = HeadlineDataManager(context: coreDataStack.managedObjectContext, dataType: .Headlines(selectedFeed: newsSource))
    let _ = createMockNews()
    let rowCount = headlineDataManager.rowCount
    XCTAssert(rowCount == 1)
  }
  
  func testToGetNewsViewModelFromDataManager() {
    let headlineDataManager = HeadlineDataManager(context: coreDataStack.managedObjectContext, dataType: .Headlines(selectedFeed: newsSource))
    let _ = createMockNews()
    let cellModel = headlineDataManager.getViewModel(index: 0)
    XCTAssertNotNil(cellModel)
  }
  
  func testToSaveNews() {
    let expectation = XCTestExpectation(description: "Save Data from TestRSS.xml")
    let feedKitAdaptor =  FeedKitAdaptor(selectedFeed: newsSource, context: coreDataStack.managedObjectContext)
    
    feedKitAdaptor.saveNewsFeed { (_) in
      let fetchRequest = News.getAllNewsFetchRequest(forSource: self.newsSource.name)
      let newsList = try! self.coreDataStack.managedObjectContext.fetch(fetchRequest) as! [News]
      XCTAssert(newsList.count == 47)
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 10.0)
  }
  
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
  //MARK: - mock in-memory persistant store
  lazy var managedObjectModel: NSManagedObjectModel = {
    let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main] )!
    return managedObjectModel
  }()
  
  lazy var mockPersistantContainer: NSPersistentContainer = {
    
    let container = NSPersistentContainer(name: "MockSwiftNewsApp", managedObjectModel: self.managedObjectModel)
    let description = NSPersistentStoreDescription()
    description.type = NSInMemoryStoreType
    description.shouldAddStoreAsynchronously = false // Make it simpler in test env
    
    container.persistentStoreDescriptions = [description]
    container.loadPersistentStores { (description, error) in
      // Check if the data store is in memory
      precondition( description.type == NSInMemoryStoreType )
      
      // Check if creating container wrong
      if let error = error {
        fatalError("Create an in-mem coordinator failed \(error)")
      }
    }
    
    return container
  }()
  
}

//MARK: - Helper Functions
extension NewsAppTests {
  
  func createMockNews() -> News {
    let news = News(context: coreDataStack.managedObjectContext)
    news.content = "Mock news description"
    news.title = "Mock news Title"
    news.feed = newsSource
    coreDataStack.saveContext()
    return news
  }
  
  func initStubs() {
    
    coreDataStack = CoreDataStack(container: getMockPersistantContainer())
    
    let filepath = Bundle(for: type(of: self)).url(forResource: "MockRSS", withExtension: "xml")!
    
    let source = NewsSources(context: coreDataStack.managedObjectContext)
    source.url = filepath.absoluteString
    source.name = "NYTimes"
    source.isSelected = true
    source.isLanguageLeftAligned = false
    newsSource = source
    
    newsSource2 = NewsSources(context: coreDataStack.managedObjectContext)
    newsSource2.isSelected = true
    newsSource2.name = "Washington Post"
    
    coreDataStack.saveContext()
  }
  
  func flushData() {
    let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "NewsSources")
    let objs = try! mockPersistantContainer.viewContext.fetch(fetchRequest)
    for case let obj as NSManagedObject in objs {
      mockPersistantContainer.viewContext.delete(obj)
    }
    try! mockPersistantContainer.viewContext.save()
  }
  
  func getMockPersistantContainer() -> NSPersistentContainer {
    
    let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main] )!
    
    let container = NSPersistentContainer(name: "MockSwiftNewsApp", managedObjectModel: managedObjectModel)
    let description = NSPersistentStoreDescription()
    description.type = NSInMemoryStoreType
    description.shouldAddStoreAsynchronously = false // Make it simpler in test env
    
    container.persistentStoreDescriptions = [description]
    container.loadPersistentStores { (description, error) in
      // Check if the data store is in memory
      precondition( description.type == NSInMemoryStoreType )
      
      // Check if creating container wrong
      if let error = error {
        fatalError("Create an in-mem coordinator failed \(error)")
      }
    }
    
    return container
  }
  
}


