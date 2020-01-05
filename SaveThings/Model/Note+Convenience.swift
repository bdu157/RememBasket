//
//  Note+Convenience.swift
//  SaveThings
//
//  Created by Dongwoo Pae on 12/30/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation
import CoreData

extension Note {
    convenience init(title: String, content: String, timestamp: Date = Date(), owner: Category, openPreview: Bool = false, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.title = title
        self.content = content
        self.timestamp = timestamp
        self.owner = owner
        self.openPreview = openPreview
    }
}
