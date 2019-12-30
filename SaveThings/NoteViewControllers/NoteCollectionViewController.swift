//
//  NoteCollectionViewController.swift
//  SaveThings
//
//  Created by Dongwoo Pae on 12/22/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit
import CoreData

class NoteCollectionViewController: UICollectionViewController, NSFetchedResultsControllerDelegate, NoteCollectionViewCellDelegate {
    
    
    let noteController = NoteController()
    
    @IBOutlet weak var addCategoryButton: UIBarButtonItem!
    
    //unwindSegue from popover VC
    @IBAction func unwindToNoteCollectionViewController(_ sender: UIStoryboardSegue) {
        
    }
    
    var fetchedResultsController: NSFetchedResultsController<Category> {
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let moc = CoreDataStack.shared.mainContext
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        try! frc.performFetch()
        return frc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //toolbar
        navigationController?.isToolbarHidden = true
        //edit
        navigationItem.leftBarButtonItem = editButtonItem
        installsStandardGestureForInteractiveMovement = true
        
        self.observerShouldShowNewCategory()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        addCategoryButton.isEnabled = !editing
        collectionView?.allowsMultipleSelection = editing
        collectionView.indexPathsForSelectedItems?.forEach {
            collectionView.deselectItem(at: $0, animated: false)
        }
        
        guard let indexes = collectionView?.indexPathsForVisibleItems else {
            return
        }
        for index in indexes {
            let cell = collectionView?.cellForItem(at: index) as! NoteCollectionViewCell
            cell.isEditing = isEditing
        }
    }
    
    
    
    func observerShouldShowNewCategory() {
        NotificationCenter.default.addObserver(self, selector: #selector(refreshViews(notification:)), name: .addCategoryClicked, object: nil)
    }
    
    @objc func refreshViews(notification: Notification) {
        let indexPath = IndexPath(row: fetchedResultsController.fetchedObjects!.count - 1, section: 0)
        collectionView.insertItems(at: [indexPath])
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //for popoverview
        if segue.identifier == "toAddCategory" {
            
            let popOverVC = segue.destination as! PopOverViewController
            popOverVC.noteController = self.noteController
            let ppc = popOverVC.popoverPresentationController
            if let button = sender as? UIButton {
                ppc?.sourceView = button
                ppc?.sourceRect = button.bounds
            }
            ppc?.delegate = self
        } else if segue.identifier == "ToNoteTableView" {
            guard let destVC = segue.destination as? NoteTableViewController,
                let selectedItem = collectionView.indexPathsForSelectedItems?.first else {return}
            destVC.noteController = self.noteController
            destVC.category = self.fetchedResultsController.object(at: selectedItem)
            
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"CategoryCell", for: indexPath) as! NoteCollectionViewCell
        let category = self.fetchedResultsController.object(at: indexPath)
        cell.category = category
        cell.delegate = self
        cell.isEditing = isEditing
        return cell
    }
    
    func removeCellAndReload(for cell: NoteCollectionViewCell) {
        
        guard let indexPath = collectionView.indexPath(for: cell) else {return}
        let category = self.fetchedResultsController.object(at: indexPath)
        self.noteController.deleteCategory(for: category)
        collectionView.deleteItems(at: [indexPath])
    }
}

extension NoteCollectionViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}


