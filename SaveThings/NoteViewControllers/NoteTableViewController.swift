//
//  NoteTableViewController.swift
//  SaveThings
//
//  Created by Dongwoo Pae on 12/28/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit
import CoreData

class NoteTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating, NoteTableViewCellDelegate {
    
    //MARK: Properties
    var category: Category!
    var noteController: NoteController!
    let searchController = UISearchController(searchResultsController: nil)
    
    var notes: [Note] {
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        let moc = CoreDataStack.shared.mainContext
        fetchRequest.predicate = NSPredicate(format: "owner == %@", category)
     
        let searchText = searchController.searchBar.text!

        if !searchText.isEmpty {
            fetchRequest.predicate = NSPredicate(format: "title CONTAINS[cd] %@ AND owner = %@", searchText, self.category)
        }
        do {
            fetchRequest.sortDescriptors = sortOnes
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
    and once a category is deleted it will remove them all - relational CoreData
 */
 
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           navigationItem.title = self.category.name
           self.tableView.reloadData()
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        
        navigationBarSetUp()
        searchControllerSetUp()
        observeShouldReloadData()
    }

    //MARK: Observer for reloadData() - once present modally view is dismiessed
    private func observeShouldReloadData() {
        NotificationCenter.default.addObserver(self, selector: #selector(refresh(notification:)), name: .needtoReloadData, object: nil)
    }
    
    @objc func refresh(notification: Notification) {
        self.tableView.reloadData()
    }
    
    //MARK: SearchController SetUp
    private func searchControllerSetUp() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Note"
        searchController.searchBar.tintColor = .orange
        searchController.searchBar.scopeButtonTitles = ["A-Z", "Z-A", "Recently Added"]
        searchController.searchResultsUpdater = self
    }
    
    //MARK: NavigationBarSetUp
    private func navigationBarSetUp() {
        //navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notes.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteTableViewCell
        let note = self.notes[indexPath.row]
        cell.delegate = self
        cell.note = note
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let note = self.notes[indexPath.row]
            self.noteController.deleteNote(for: note)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToUpdateNote" {
            guard let detailVC = segue.destination as? NoteDetailViewController,
                let selectedRow = self.tableView.indexPathForSelectedRow else {return}
            let note = self.notes[selectedRow.row]
            detailVC.note = note
            detailVC.noteController = self.noteController
            detailVC.category = self.category
        } else if segue.identifier == "ToAddNote" {
            guard let detailVC = segue.destination as? NoteDetailViewController else {return}
            detailVC.noteController = self.noteController
            detailVC.category = self.category
        }
    }
    
    //MARK:UISearchResultsUpdating method
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scopeIndex = searchBar.selectedScopeButtonIndex
        if scopeIndex == 0 || scopeIndex == 1 || scopeIndex == 2 {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            print("changed isFiltering")
        }
    }
    
    //MARK: Protocol method - one to one communication between cell and NoteTableViewCell (update Object as well)
    func togglePreviewImage(for cell: NoteTableViewCell) {
        guard let indexPath = self.tableView.indexPath(for: cell) else {return}
        let note = self.notes[indexPath.row]
        self.noteController.toggleImageforPreview(for: note)
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    // ActivityController to share notes
    func showActivityView(for cell: NoteTableViewCell) {
        guard let noteInput = cell.note?.content,
            let noteTitle = cell.note?.title else {
                print("no text found")
                return
            }
            let vc = UIActivityViewController(activityItems: [noteTitle, noteInput], applicationActivities: [])
            self.present(vc, animated: true, completion: nil)
        }
}
