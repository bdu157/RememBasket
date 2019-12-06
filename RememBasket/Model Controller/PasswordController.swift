//
//  PasswordController.swift
//  RememBasket
//
//  Created by Dongwoo Pae on 10/30/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class PasswordController {
    
    //CRUD
    //create password
    func createPassword(title: String, userName: String, password: String, notes: String?, imageURLString: String?, logoViewbgColor: String) {
        //let firstLetterOfTitle = title[0] this would work with StringExtension
        let firstLetter = title.prefix(1)
        let _ = Password(title: title, username: userName, password: password, notes: notes, sectionTitle: String(firstLetter), imageURLString: imageURLString, logoViewbgColor: logoViewbgColor)
        saveToPersistentStore()
    }
    
    //read password
    
    //update password
    func updatePassword(for password: Password, changeTitleTo: String, changeUserNameTo: String, changePasswordTo: String, changeNotesTo: String?, modifiedDate: Date = Date(), changeImageURLStringTo: String?, logoViewbgColor: String) {
        password.title = changeTitleTo
        password.username = changeUserNameTo
        password.password = changePasswordTo
        password.notes = changeNotesTo
        password.timestamp = modifiedDate
        password.sectionTitle = String(changeTitleTo.prefix(1))
        password.imageURLString = changeImageURLStringTo
        password.logoViewbgColor = logoViewbgColor
        
        saveToPersistentStore()
    }
    
    //delete password
    func deletePassword(for password: Password) {
        let moc = CoreDataStack.shared.mainContext
        moc.delete(password)
        do {
            try moc.save()
        } catch {
            moc.reset()
            NSLog("there is an error in deleting row: \(error)")
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
    
    
    //Networking for company logo
    enum NetworkError: Error {
        case badData
        case noData
        case otherError
        case noLogo
    }
    //https://logo.clearbit.com/google.com
    
    var baseUrl = URL(string: "https://logo.clearbit.com/")!
    
    var logoImageURLString: String?
    
    func fetchCompanyLogo(searchTerms: [String], completion: @escaping (Result<UIImage?, NetworkError>) -> Void ) {
        
        for aTerm in searchTerms {
            
            let urlRequest = baseUrl.appendingPathComponent(aTerm)
            var request = URLRequest(url: urlRequest)
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let response = response as? HTTPURLResponse,
                    response.statusCode == 404 {
                    completion(.failure(.noLogo))
                    print("\(aTerm) after receiving 404 response")
                    return
                }
                
                if let _ = error {
                    completion(.failure(.otherError))
                    print("\(aTerm) after receiving error")
                    return
                }
                guard let data = data else {
                    completion(.failure(.noData))
                    print("\(aTerm) after receiving no data")
                    return
                }
                
                let image = UIImage(data: data)
                print("\(aTerm) after receiving Data!!")
                self.logoImageURLString = aTerm
                completion(.success(image))
            }.resume()
        }
    }
    
    func fetchCompanyLogoForOneTerm(searchTerm: String, completion: @escaping (Result<UIImage?, NetworkError>) -> Void ) {
        
        let urlRequest = baseUrl.appendingPathComponent(searchTerm)
        var request = URLRequest(url: urlRequest)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode == 404 {
                completion(.failure(.noLogo))
                print("\(searchTerm) after receiving 404 response")
                return
            }
            
            if let _ = error {
                completion(.failure(.otherError))
                print("\(searchTerm) after receiving error")
                return
            }
            guard let data = data else {
                completion(.failure(.noData))
                print("\(searchTerm) after receiving no data")
                return
            }
            
            let image = UIImage(data: data)
            print("\(searchTerm) after receiving Data!!")
            completion(.success(image))
        }.resume()
    }
}

