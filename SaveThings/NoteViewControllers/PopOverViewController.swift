//
//  PopOverViewController.swift
//  SaveThings
//
//  Created by Dongwoo Pae on 12/24/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class PopOverViewController: UIViewController {
    
    
    //MARK: Properties and Outlets
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var addCategoryButton: UIButton!
    
    var noteController: NoteController?
    
    //Private properties
    private var categoryLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //textfield delegate through storyboard
        self.setUpTextField()
        self.addCategoryButton.tintColor = .black
    }
    
    
    @IBAction func addCategoryButtonTapped(_ sender: Any) {
        if let newCategoryInput = self.categoryTextField.text,
            let noteController = noteController {
            
            noteController.createCategory(name: newCategoryInput)
            
            NotificationCenter.default.post(name: .addCategoryClicked, object: self)
        }
    }
    
    
    //MARK: Private set up methods - titleTextField, Placeholder, CategoryLeftImage
    private func setUpTextField() {
        //Title Set up
        categoryTextField.shapeTextField()
        
        //Placeholder SetUp
        categoryLabel.frame = CGRect(x: 40, y: 15, width: 150, height: 40)
        categoryLabel.setUpPlaceHolderLabels(for: "Category Name")
        self.categoryTextField.addSubview(categoryLabel)
    
        //Category leftImage
        let categoryIcon = UIImage(named: "category")!
        self.categoryTextField.addLeftImage(image: categoryIcon)
    }
}


//MARK: UITextFieldDelegate Methods
extension PopOverViewController: UITextFieldDelegate {
    
    //When TextField is being edited
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let oldText = textField.text,
            let stringRange = Range(range, in: oldText) else {
                return false
        }
        
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        if !newText.isEmpty {
            
            UILabel.animate(withDuration: 0.1, animations: {
                self.categoryLabel.alpha = 1
                self.categoryLabel.frame.origin.x = 40
                self.categoryLabel.frame.origin.y = -33
            }, completion: nil)
            
        } else {
            UILabel.animate(withDuration: 0.1, animations: {
                self.categoryLabel.alpha = 0
                self.categoryLabel.frame.origin.x = 40
                self.categoryLabel.frame.origin.y = 15
            })
        }
        return true
    }
}
