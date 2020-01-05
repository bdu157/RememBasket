//
//  NoteController.swift
//  SaveThings
//
//  Created by Dongwoo Pae on 12/22/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class NoteController {
    
    //CRUD for category
    func createCategory(name: String) {
        let _ = Category(name: name)
        saveToPersistentStore()
    }
    
    func updateCategory(for category: Category, changeCategoryNameTo: String) {
        category.name = changeCategoryNameTo
        saveToPersistentStore()
    }
    
    func deleteCategory(for category: Category) {
        let moc = CoreDataStack.shared.mainContext
        moc.delete(category)
        do {
            try moc.save()
        } catch {
            moc.reset()
            NSLog("there is an error in deleting category: \(error)")
        }
    }
    
    //CRUD for note
    func createNote(title: String, content: String, owner: Category, logoViewbgColor: String) {
        let _ = Note(title: title, content: content, owner: owner, logoViewbgColor: logoViewbgColor)
        saveToPersistentStore()
    }
    
    func updateNote(for note: Note, changeTitleTo: String, changeContentTo: String, modifiedDate: Date, logoViewbgColor: String) {
        note.title = changeTitleTo
        note.content = changeContentTo
        note.modifiedDate = modifiedDate
        note.logoViewbgColor = logoViewbgColor
        saveToPersistentStore()
    }
    
    func deleteNote(for note: Note) {
        let moc = CoreDataStack.shared.mainContext
        moc.delete(note)
        do {
            try moc.save()
        } catch {
            moc.reset()
            NSLog("there is an error in deleting note: \(error)")
        }
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
    
    //toggle preview button in cell
    func toggleImageforPreview(for note: Note) {
        note.openPreview = !note.openPreview
        saveToPersistentStore()
    }
}
