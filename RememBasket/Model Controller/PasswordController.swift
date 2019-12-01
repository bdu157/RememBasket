//
//  PasswordController.swift
//  RememBasket
//
//  Created by Dongwoo Pae on 10/30/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation
import CoreData

class PasswordController {
    
    //CRUD
    //create password
    func createPassword(title: String, userName: String, password: String, notes: String?) {
        let _ = Password(title: title, username: userName, password: password, notes: notes)
        saveToPersistentStore()
    }
    
    //read password
    
    //update password
    func updatePassword(for password: Password, changeTitleTo: String, changeUserNameTo: String, changePasswordTo: String, changeNotesTo: String?, modifiedDate: Date = Date()) {
        password.title = changeTitleTo
        password.username = changeUserNameTo
        password.password = changePasswordTo
        password.notes = changeNotesTo
        password.timestamp = modifiedDate
        
        saveToPersistentStore()
    }
    
    //delete password
    func deletePassword(for password: Password) {
        let moc = CoreDataStack.shared.mainContext
        moc.delete(password)
        saveToPersistentStore()
    }

    
    //MARK: SaveToCoreDataStore - maincontext
    func saveToPersistentStore() {
        do {
            let moc = CoreDataStack.shared.mainContext
            try moc.save()
        } catch {
            NSLog("Error saving managed object context:\(error)")
        }
    }
    
    //MARK: SaveToCoreDataStore - backgroundContext
    func saveToPersistentStoreBackgroundContext(bgcontext: NSManagedObjectContext = CoreDataStack.shared.mainContext) throws {
        var error: Error?
        bgcontext.performAndWait {
            do {
                try bgcontext.save()
            } catch let saveError {
                error = saveError
            }
        }
        if let error = error {throw error}
    }
}
