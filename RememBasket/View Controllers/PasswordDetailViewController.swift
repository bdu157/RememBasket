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
        titleTextField.shapeTextField()
        
        //userName
        userNameTextField.shapeTextField()
        
        //password
        passwordTextField.shapeTextField()
        
        //notesTextField
        notesTextView.tintColor = .orange
        notesTextView.textColor = .black
        notesTextView.layer.cornerRadius = 8
        notesTextView.layer.borderWidth = 0.6
        
        //shadow
        notesTextView.layer.shadowOpacity = 0.6
        notesTextView.clipsToBounds = false
        notesTextView.layer.shadowOffset = CGSize.zero
        notesTextView.layer.shadowColor = UIColor.darkGray.cgColor
        
        let titleIcon = UIImage(named: "title")!
        self.titleTextField.addLeftImage(image: titleIcon)
        
        let userNameIcon = UIImage(named: "userName")!
        self.userNameTextField.addLeftImage(image: userNameIcon)
        
        let lockIcon = UIImage(named: "lock")!
        self.passwordTextField.addLeftImage(image: lockIcon)
        
        addDoneButtonToKeyboard()
        
        //delegates are set up through storyboards
        
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

extension PasswordDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("UIResponder.keyboardWillShow/HideNotification are removed")
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [], animations: {
            self.view.frame.origin.y = 0
        }, completion: nil)
        return true
    }
}

extension PasswordDetailViewController: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        print("textview is being editied")
        print("UIResponder.keyboardWillShowNotification is set")
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        print("UIResponder.keyboardWillHideNotification is set")
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        return true
    }
    
    //this reacts whenver keyboard appears and disappears
    //make this occur only when textView is selected
    @objc func keyboardWillChange(notification: Notification) {
        print("keyboard did show: \(notification.name.rawValue)")
        
        let info:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        //Key Logic for show and hide
        //self.view.fram.origin.y + space between textview and the bottom of the app
        if notification.name == UIResponder.keyboardWillShowNotification {
            self.view.frame.origin.y = -keyboardSize.height + (self.view.frame.height - (self.notesTextView.frame.origin.y + self.notesTextView.frame.height))
        } else {
            self.view.frame.origin.y = 0
        }
    }
    
    func addDoneButtonToKeyboard() {
        let toolBar = UIToolbar(frame: CGRect(x:0.0, y:0.0, width: UIScreen.main.bounds.size.width, height:44.0))
        let barButton = UIBarButtonItem(title: "Done", style: .done, target: nil, action: #selector(doneButtonTapped(sender:)))
        let rightSide = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([rightSide, barButton], animated: false)
        self.notesTextView.inputAccessoryView = toolBar
    }
    
    @objc func doneButtonTapped(sender: Any) {
        self.notesTextView.endEditing(true)
        print("UIResponder.keyboardWillShow/HideNotification are removed")
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
