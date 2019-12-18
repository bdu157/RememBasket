//
//  PasswordViewController.swift
//  RememBasket
//
//  Created by Dongwoo Pae on 11/14/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit
import CoreData

class PasswordTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating, PasswordTableViewCellDelegate {
    
    
    //MARK: Properties
    let passwordController = PasswordController()
    let searchController = UISearchController(searchResultsController: nil)
    
    
    var passwords: [Password] {
        let fetchRequest: NSFetchRequest<Password> = Password.fetchRequest()
        let moc = CoreDataStack.shared.mainContext
        
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
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
        searchController.searchBar.placeholder = "Search Password"
        searchController.searchBar.tintColor = .orange
        searchController.searchBar.scopeButtonTitles = ["A-Z", "Z-A", "Recently Added"]
        searchController.searchResultsUpdater = self
    }
    
    
    //MARK: NavigationBarSetUp
    private func navigationBarSetUp() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    
    //MARK: TableView Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passwords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PasswordCell", for: indexPath) as! PasswordTableViewCell
        let password = self.passwords[indexPath.row]
        cell.delegate = self
        cell.password = password
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
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
    
    //MARK: Reset Button
    @IBAction func resetButtonTapped(_ sender: Any) {
        self.reset()
    }
    
    private func reset() {
        let passwordsforReset = self.passwords.filter {$0.openBasket == true}
        for password in passwordsforReset {
            password.openBasket = false
        }
        self.passwordController.saveToPersistentStore()
        self.tableView.reloadData()
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
    
    
    //MARK: Protocol method - one to one communication between cell and PasswordTableViewController (update Object as well)
    func toggleLockImage(for cell: PasswordTableViewCell) {
        guard let indexPath = self.tableView.indexPath(for: cell) else {return}
        let password = self.passwords[indexPath.row]
        self.passwordController.toggleOpenBasket(for: password)
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    
    //MARK: FetchedResultsController
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

