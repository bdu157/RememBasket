//
//  PasswordDetailViewController.swift
//  RememBasket
//
//  Created by Dongwoo Pae on 11/14/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class PasswordDetailViewController: UIViewController {
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateViews()
        //title
        titleTextField.tintColor = .orange
        titleTextField.textColor = .black
        titleTextField.shapeTextField()
        
        //email
        userNameTextField.tintColor = .orange
        userNameTextField.textColor = .black
        userNameTextField.shapeTextField()
        
        //password
        passwordTextField.tintColor = .orange
        passwordTextField.textColor = .black
        passwordTextField.shapeTextField()
        
        //notesTextField
        notesTextView.tintColor = .orange
        notesTextView.textColor = .black
        notesTextView.layer.cornerRadius = 8
        notesTextView.layer.borderWidth = 0.4
        notesTextView.layer.borderColor = UIColor.orange.cgColor
        
        let titleIcon = UIImage(named: "title")!
        self.titleTextField.addLeftImage(image: titleIcon)
        
        let userNameIcon = UIImage(named: "userName")!
        self.userNameTextField.addLeftImage(image: userNameIcon)
        
        let lockIcon = UIImage(named: "lock")!
        self.passwordTextField.addLeftImage(image: lockIcon)
    }
  
    

    var password: Password? {
        didSet {
            self.updateViews()
        }
    }
    
    var passwordController: PasswordController?
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = self.titleTextField.text,
            let userName = self.userNameTextField.text,
            let passwordInput = self.passwordTextField.text,
            let notes = self.notesTextView.text,
            let passwordController = passwordController else {return}
        
        if let password = password {
            passwordController.updatePassword(for: password, changeTitleTo: title, changeUserNameTo: userName, changePasswordTo: passwordInput, changeNotesTo: notes)
        } else {
            passwordController.createPassword(title: title, userName: userName, password: passwordInput, notes: notes)
            
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    //private methods
    private func updateViews() {
        if let password = self.password {
            self.title = password.title
            self.titleTextField?.text = password.title
            self.userNameTextField?.text = password.username
            self.passwordTextField?.text = password.password
            self.notesTextView?.text = password.notes
        } else {
            self.title = "Add Password"
        }
    }
}
