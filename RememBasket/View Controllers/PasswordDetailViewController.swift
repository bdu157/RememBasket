//
//  PasswordDetailViewController.swift
//  RememBasket
//
//  Created by Dongwoo Pae on 11/14/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class PasswordDetailViewController: UIViewController {
    
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateViews()
        self.titleTextField.tintColor = #colorLiteral(red: 0.9427343607, green: 0.5175138712, blue: 0.1222904697, alpha: 1)
        self.emailTextField.tintColor = #colorLiteral(red: 0.9427343607, green: 0.5175138712, blue: 0.1222904697, alpha: 1)
        self.passwordTextField.tintColor = #colorLiteral(red: 0.9427343607, green: 0.5175138712, blue: 0.1222904697, alpha: 1)
    }
    
    var password: Password? {
        didSet {
            self.updateViews()
        }
    }
    
    var passwordController: PasswordController?
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = self.titleTextField.text,
            let userName = self.emailTextField.text,
            let passwordInput = self.passwordTextField.text,
            let passwordController = passwordController else {return}
        
        if let password = password {
            passwordController.updatePassword(for: password, changeTitleTo: title, changeUserNameTo: userName, changePasswordTo: passwordInput, changeNotesTo: nil)
        } else {
            passwordController.createPassword(title: title, userName: userName, password: passwordInput)
        }
        
        NotificationCenter.default.post(name: .needtoReloadData, object: self)
        self.dismiss(animated: true, completion: nil)
    }
    
    //private methods
    private func updateViews() {
        guard let password = self.password else {return}
        self.titleTextField?.text = password.title
        self.emailTextField?.text = password.username
        self.passwordTextField?.text = password.password
        self.notesTextView?.text = password.notes
    }
}
