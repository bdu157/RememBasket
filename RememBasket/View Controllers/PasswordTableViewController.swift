//
//  PasswordViewController.swift
//  RememBasket
//
//  Created by Dongwoo Pae on 11/14/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit
import CoreData

class PasswordTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    let passwordController = PasswordController()
    
    //fetchedResultsController
    lazy var fetchedResultsController: NSFetchedResultsController<Password> = {
        let fetchRequest: NSFetchRequest<Password> = Password.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "sectionTitle", ascending: true), NSSortDescriptor(key: "timestamp", ascending: true)] //giving first NSSortDescriptor mood is the key to make section srot correctly
        let moc = CoreDataStack.shared.mainContext
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: "sectionTitle", cacheName: nil)
        frc.delegate = self
        try! frc.performFetch()
        return frc
        
        // add NSFetchResulsControllerDelegate
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.placeholder = "Search Password"
        searchController.searchBar.tintColor = .orange
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    
    //tableView data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        self.fetchedResultsController.sections?.count ?? 1
    }
    
    //sectionTitle
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = self.fetchedResultsController.sections?[section] else {return nil}
        return section.name
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PasswordCell", for: indexPath) as! PasswordTableViewCell
        let password = self.fetchedResultsController.object(at: indexPath)
        cell.password = password
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let password = self.fetchedResultsController.object(at: indexPath)
            self.passwordController.deletePassword(for: password)
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToUpdatePassword" {
            guard let detailVC = segue.destination as? PasswordDetailViewController,
                let selectedRow = self.tableView.indexPathForSelectedRow else {return}
            let password = self.fetchedResultsController.object(at: selectedRow)
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
}
