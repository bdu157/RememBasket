//
//  NoteDetailViewController.swift
//  SaveThings
//
//  Created by Dongwoo Pae on 12/28/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit
import CoreData

class NoteDetailViewController: UIViewController {

    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    var noteController: NoteController?
    var category: Category!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    /* make sure you give note.category = category when creating a new note
     
    var category: Category!
     
    @IBAction func addPet() {
     
     use NoteController
     
        let data = PetData()
        let pet = Pet(entity: Pet.entity(), insertInto: context)
        pet.name = data.name
        pet.kind = data.kind
        pet.dob = data.dob as NSDate
        pet.owner = friend
        appDelegate.saveContext()
        refresh()
        collectionView.reloadData()
        }
    }
    */
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let title = self.titleTextField.text,
            let content = self.contentTextView.text,
            let noteController = self.noteController else {return}
            noteController.createNote(title: title, content: content, owner: self.category)
        navigationController?.popViewController(animated: true)
    }
}
