//
//  PasswordController.swift
//  RememBasket
//
//  Created by Dongwoo Pae on 10/30/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation

class PasswordController {
    
    var passwords: [Password] = []
    
    //CRUD
    //create password
    func createPassword(title: String, userName: String, password: String, notes: String = "", createDate: Date = Date()) {
        let password = Password(title: title, username: userName, password: password, notes: notes, createdDate: createDate)
        self.passwords.append(password)
    }
    
    //read password
    
    //update password
    func updatePassword(for password: Password, changeTitleTo: String, changeUserNameTo: String, changePasswordTo: String, changeNotesTo: String?, modifiedDate: Date = Date()) {
        guard let index = self.passwords.firstIndex(of: password) else {return}
        self.passwords[index].title = changeTitleTo
        self.passwords[index].username = changeUserNameTo
        self.passwords[index].password = changePasswordTo
        self.passwords[index].notes = changeNotesTo
        self.passwords[index].createdDate = modifiedDate
    }
    
    //delete password
    func deletePassword(for password: Password) {
        guard let index = self.passwords.firstIndex(of: password) else {return}
        self.passwords.remove(at: index)
    }
}
