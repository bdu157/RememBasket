//
//  Password.swift
//  RememBasket
//
//  Created by Dongwoo Pae on 10/30/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation
import UIKit

struct Password: Codable, Equatable {
    var title: String
    var username: String
    var password: String
    var notes: String?
    var createdDate: Date
    
    init(title: String, username: String, password: String, notes: String? = nil, createdDate: Date = Date()) {
        self.title = title
        self.username = username
        self.password = password
        self.notes = notes
        self.createdDate = createdDate
    }
}
