//
//  NoteCollectionViewController.swift
//  SaveThings
//
//  Created by Dongwoo Pae on 12/22/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class NoteCollectionViewController: UICollectionViewController {
    
    let noteController = NoteController()
    
    //unwindSegue from popover VC
    @IBAction func unwindToNoteCollectionViewController(_ sender: UIStoryboardSegue) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.observerShouldShowNewCategory()
        
    }
    
    func observerShouldShowNewCategory() {
        NotificationCenter.default.addObserver(self, selector: #selector(refreshViews(notification:)), name: .addCategoryClicked, object: nil)
    }
    
    @objc func refreshViews(notification: Notification) {
        collectionView.reloadData()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddCategory" {
            
            let popOverVC = segue.destination as! PopOverViewController
            popOverVC.noteController = self.noteController
            let ppc = popOverVC.popoverPresentationController
            if let button = sender as? UIButton {
                ppc?.sourceView = button
                ppc?.sourceRect = button.bounds
            }
            ppc?.delegate = self
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.noteController.notes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"CategoryCell", for: indexPath) as! NoteCollectionViewCell
        let note = self.noteController.notes[indexPath.item]
        cell.note = note
        return cell
    }
}

extension NoteCollectionViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}


