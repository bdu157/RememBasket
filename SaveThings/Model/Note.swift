//
//  Note.swift
//  SaveThings
//
//  Created by Dongwoo Pae on 12/22/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

struct Note: Equatable {
    var category: String
    var title: String?
    var notes: String?
    
    init(category: String, title: String? = nil, notes: String? = nil) {
        self.category = category
        self.title = title
        self.notes = notes
    }
}
