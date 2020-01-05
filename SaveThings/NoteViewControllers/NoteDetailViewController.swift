//
//  NoteDetailViewController.swift
//  SaveThings
//
//  Created by Dongwoo Pae on 12/28/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class NoteDetailViewControllers: UIViewController {
    
    //MARK: Properties and Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    
    //Buttons - not yet implemented
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!

    @IBOutlet weak var buttonsViewInUpdateView: UIView!
    
    //Date Labels - not yet implemented
    @IBOutlet weak var createdDateLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var modifiedDateLabel: UILabel!
    @IBOutlet weak var modifiedLabel: UILabel!
    
    

}
