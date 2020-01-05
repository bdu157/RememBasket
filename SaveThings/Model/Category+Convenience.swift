//
//  Category+Convenience.swift
//  SaveThings
//
//  Created by Dongwoo Pae on 12/30/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation
import CoreData

extension Category {
    convenience init(name: String, timestamp: Date = Date(), context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.name = name
        self.timestamp = timestamp
    }
}

