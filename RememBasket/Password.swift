//
//  Password.swift
//  RememBasket
//
//  Created by Dongwoo Pae on 10/30/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation

class password: Codable {
    var title: String
    var username: String
    var password: String
    var notes: String?
    let createdDate: Date
    
    init(title: String, username: String, password: String, notes: String? = nil, createdDate: Date = Date()) {
        self.title = title
        self.username = username
        self.password = password
        self.notes = notes
        self.createdDate = createdDate
    }
}
