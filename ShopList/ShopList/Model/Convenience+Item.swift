//
//  Convenience+Item.swift
//  ShopList
//
//  Created by Markus Varner on 8/31/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import Foundation
import CoreData

extension Item {
    //this makes it so if we unwrap something and dont assign it to a var and we dont "use it" that error will go away
    @discardableResult
    //MARK: - Init Convenience Intializer
    convenience init(name: String, didBuy: Bool = false, context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.name = name
//        self.didBuy = didBuy
        
    }
    
}
