//
//  CoreDataStack.swift
//  ShopList
//
//  Created by Markus Varner on 8/31/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import Foundation
import CoreData

enum CoreDataStack {
    
    //MARK: - SetUp Persistent Container
    static let container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "ShopList")
        //set the container to load at run time like below
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                fatalError("Failed to Load Persistent Stores \(error)")
            }
        })
        return container
    }()
    
    //MARK: - SetUp Context as Computed Property
    static var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    //MARK: - Save to Persistent Store
    static func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print("There was en error in \(#function) \(error), \(error.localizedDescription)")
        }
    }
    
    //MARK: - Delete From Persistent Store
    
    static func delete(item: Item) {
        CoreDataStack.context.delete(item)
        saveToPersistentStore()
    }
    
}

