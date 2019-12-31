//
//  PopOverViewController.swift
//  SaveThings
//
//  Created by Dongwoo Pae on 12/24/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class PopOverViewController: UIViewController {

    @IBOutlet weak var categoryTextField: UITextField!
    
    var noteController: NoteController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addCategoryButtonTapped(_ sender: Any) {
        if let newCategoryInput = self.categoryTextField.text,
            let noteController = noteController {
            
            noteController.createCategory(name: newCategoryInput)
            
            NotificationCenter.default.post(name: .addCategoryClicked, object: self)
        }
    }
}
