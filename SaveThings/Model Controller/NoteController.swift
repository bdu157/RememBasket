//
//  NoteController.swift
//  SaveThings
//
//  Created by Dongwoo Pae on 12/22/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation
import UIKit

class NoteController {
    
    var notes: [Note] = []
    
    //create category
    func createCategory(for categoryName: String) {
        let category = Note(category: categoryName)
        self.notes.append(category)
    }
}
