//
//  PasswordViewController.swift
//  RememBasket
//
//  Created by Dongwoo Pae on 11/14/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit
import CoreData

class PasswordTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {
    
    let passwordController = PasswordController()
    let searchController = UISearchController(searchResultsController: nil)
    
    /* not being used
     //fetchedResultsController -> changed this lazy var to computed property
     lazy var fetchedResultsController: NSFetchedResultsController<Password> = {
     let fetchRequest: NSFetchRequest<Password> = Password.fetchRequest()
     let moc = CoreDataStack.shared.mainContext
     
     fetchRequest.sortDescriptors = self.sortOnes //giving first NSSortDescriptor mood is the key to make section srot correctly
     let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: "sectionTitle", cacheName: nil)
     frc.delegate = self
     try! frc.performFetch()
     return frc
     //add NSFetchResulsControllerDelegate
     }()
     */
    
    //computed property
    var sortOnes: [NSSortDescriptor] {
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
    
    
    var passwords: [Password] {
        let fetchRequest: NSFetchRequest<Password> = Password.fetchRequest()
        let moc = CoreDataStack.shared.mainContext
        //let bgContext = CoreDataStack.shared.container.newBackgroundContext()
        let searchText = searchController.searchBar.text!
        
        if !searchText.isEmpty {
            fetchRequest.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
        do {
            fetchRequest.sortDescriptors = self.sortOnes
            return try moc.fetch(fetchRequest)
        } catch {
            NSLog("there is an error getting data through Predicate")
            return []
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        
        searchController.searchBar.placeholder = "Search Password"
        searchController.searchBar.tintColor = .orange
        searchController.searchBar.scopeButtonTitles = ["A-Z", "Z-A", "Recently Added"]
        
        //searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        
        observeShouldReloadData()
    }
    
    //observeShouldReloadData
    func observeShouldReloadData() {
        NotificationCenter.default.addObserver(self, selector: #selector(refresh(notification:)), name: .needtoReloadData, object: nil)
    }
    
    @objc func refresh(notification: Notification) {
        self.tableView.reloadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    
    //tableView data source
    
    /* section not being used
     override func numberOfSections(in tableView: UITableView) -> Int {
     //return self.fetchedResultsController.sections?.count ?? 1
     return 1
     }
     override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
     guard let section = self.fetchedResultsController.sections?[section] else {return nil}
     return section.name
     }
     */
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.fetchedResultsController.sections?[section].numberOfObjects ?? 0
        return passwords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PasswordCell", for: indexPath) as! PasswordTableViewCell
        //let password = self.fetchedResultsController.object(at: indexPath)
        let password = self.passwords[indexPath.row]
        cell.password = password
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //let password = self.fetchedResultsController.object(at: indexPath)
            let password = self.passwords[indexPath.row]
            self.passwordController.deletePassword(for: password)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToUpdatePassword" {
            guard let detailVC = segue.destination as? PasswordDetailViewController,
                let selectedRow = self.tableView.indexPathForSelectedRow else {return}
            let password = self.passwords[selectedRow.row]
            detailVC.password = password
            detailVC.passwordController = self.passwordController
        } else if segue.identifier == "ToAddPassword" {
            guard let detailVC = segue.destination as? PasswordDetailViewController else {return}
            detailVC.passwordController = self.passwordController
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        NotificationCenter.default.post(name: .needtoResetData, object: self)
    }
    
    
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
    
    /* not being used
     //MARK: - NSfetchresultcontrollerDelegate - boilerPlate codes for coreData start here.
     func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
     self.tableView.beginUpdates()
     }
     func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
     self.tableView.endUpdates()
     }
     
     
     //Sections
     func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
     didChange sectionInfo: NSFetchedResultsSectionInfo,
     atSectionIndex sectionIndex: Int,
     for type: NSFetchedResultsChangeType) {
     switch type {
     case .insert:
     tableView.insertSections(IndexSet(integer: sectionIndex), with: .automatic)
     case .delete:
     tableView.deleteSections(IndexSet(integer: sectionIndex), with: .automatic)
     default:
     break
     }
     }
     
     //Rows
     func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
     didChange anObject: Any,
     at indexPath: IndexPath?,
     for type: NSFetchedResultsChangeType,
     newIndexPath: IndexPath?) {
     switch type {
     case .insert:
     guard let newIndexPath = newIndexPath else {return}
     tableView.insertRows(at: [newIndexPath], with: .automatic)
     case .update:
     guard let indexPath = indexPath else {return}
     tableView.reloadRows(at: [indexPath], with: .automatic)
     case .move:
     guard let oldIndexPath = indexPath,
     let newIndexPath = newIndexPath else {return}
     tableView.deleteRows(at: [oldIndexPath], with: .automatic)
     tableView.insertRows(at: [newIndexPath], with: .automatic)
     case .delete:
     guard let indexPath = indexPath else {return}
     tableView.deleteRows(at: [indexPath], with: .automatic)
     default:
     break
     }
     }
     */
}

