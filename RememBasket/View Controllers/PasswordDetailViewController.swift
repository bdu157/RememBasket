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
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateViews()
        //title
        titleTextField.tintColor = .orange
        titleTextField.textColor = .black
        titleTextField.layer.cornerRadius = 8
        titleTextField.layer.borderWidth = 0.4
        titleTextField.layer.borderColor = UIColor.orange.cgColor
        
        //email
        emailTextField.tintColor = .orange
        emailTextField.textColor = .black
        emailTextField.layer.cornerRadius = 8
        emailTextField.layer.borderWidth = 0.4
        emailTextField.layer.borderColor = UIColor.orange.cgColor
        
        //password
        passwordTextField.tintColor = .orange
        passwordTextField.textColor = .black
        passwordTextField.layer.cornerRadius = 8
        passwordTextField.layer.borderWidth = 0.4
        passwordTextField.layer.borderColor = UIColor.orange.cgColor
        
        //notesTextField
        notesTextView.tintColor = .orange
        notesTextView.textColor = .black
        notesTextView.layer.cornerRadius = 8
        notesTextView.layer.borderWidth = 0.4
        notesTextView.layer.borderColor = UIColor.orange.cgColor
    }
    
    var password: Password? {
        didSet {
            self.updateViews()
        }
    }
    
    var passwordController: PasswordController?
    
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = self.titleTextField.text,
            let userName = self.emailTextField.text,
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
            self.emailTextField?.text = password.username
            self.passwordTextField?.text = password.password
            self.notesTextView?.text = password.notes
        } else {
            self.title = "Add Password"
        }
        
    }
}
