//
//  NoteTableViewController.swift
//  SaveThings
//
//  Created by Dongwoo Pae on 12/28/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit
import CoreData

class NoteTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var category: Category!
    var noteController: NoteController!
    
    var note: [Note] {
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        let moc = CoreDataStack.shared.mainContext
        fetchRequest.predicate = NSPredicate(format: "category == %@", category)
     
        let searchText = searchController.searchBar.text!
        
        if !searchText.isEmpty {
            fetchRequest.predicate = NSPredicate(format: "title CONTAINS[cd] %@ AND category = %@", searchText, category)
        }
        do {
            fetchRequest.sortDescriptors = self.sortOnes
            return try moc.fetch(fetchRequest)
        } catch {
            NSLog("there is an error getting data through Predicate")
            return []
        }
    }
    
    //private computed property - to determine NSSortDescriptor based on selectedScopeButtonIndex
    private var sortOnes: [NSSortDescriptor] {
        let selectedScopeIndex = searchController.searchBar.selectedScopeButtonIndex
        
        switch selectedScopeIndex {
        case 0:
            return [NSSortDescriptor(key: "title", ascending: true)]
        case 1:
            return [NSSortDescriptor(key: "title", ascending: false)]
        case 2:
            return [NSSortDescriptor(key: "timestamp", ascending: false)]
        default:
            return [NSSortDescriptor(key: "title", ascending: true)]
        }
    }
    
    /*
    add fetchedResultsController with <Note> that has title and contents inside of NoteTableViewController under one category
    and once a category is deleted it will remove them all
 */
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
