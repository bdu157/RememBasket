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
    
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var buttonsView: UIView!
    
    //private properties for showHideButton
    private var showHideButton: UIButton = UIButton()
    private var hidePassword: Bool = false
    
    //private properties for setting up logoimage
    private var logoRightLabel: UILabel = UILabel()
    private var logoRightView: UIView = UIView()
    
    //textfield input animation for placeholder
    private var titleLabel: UILabel = UILabel()
    private var userNameLabel: UILabel = UILabel()
    private var passwordInputLabel: UILabel = UILabel()
    private var chosenLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateViews()
        
        self.setUpTextFields()
        
        self.setUpButtonsUIView()
        
        self.addDoneButtonToKeyboard()
        //delegates are set up through storyboards
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    var password: Password? {
        didSet {
            self.updateViews()
        }
    }
    
    var passwordController: PasswordController?
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        if let title = self.titleTextField.text?.capitalized,
            let userName = self.userNameTextField.text,
            let passwordInput = self.passwordTextField.text,
            let passwordController = self.passwordController {
            
            guard let notes = self.notesTextView.text else {return}
            
            if self.password == nil {
                
                let randomNumber = Int.random(in: 0...2)
                if title.isEmpty {
                    print("title is empty (before updating password)")
                    
                    switch randomNumber {
                    case 0:
                        self.titleTextField.shake()
                    case 1:
                        self.titleTextField.pulse()
                    case 2:
                        self.titleTextField.flash()
                    default:
                        self.titleTextField.shake()
                    }
                } else {
                    //create
                    passwordController.createPassword(title: title, userName: userName, password: passwordInput, notes: notes)
                    navigationController?.popViewController(animated: true)
                }
                
            }
        }
    }
    
    @IBAction func saveButtonFromUpdateView(_ sender: Any) {
        if let title = self.titleTextField.text?.capitalized,
            let userName = self.userNameTextField.text,
            let passwordInput = self.passwordTextField.text,
            let passwordController = self.passwordController {
            
            guard let notes = self.notesTextView.text else {return}
            
            if let password = self.password {
                
                let randomNumber = Int.random(in: 0...2)
                if title.isEmpty {
                    print("title is empty (before updating password)")
                    
                    switch randomNumber {
                    case 0:
                        self.titleTextField.shake()
                    case 1:
                        self.titleTextField.pulse()
                    case 2:
                        self.titleTextField.flash()
                    default:
                        self.titleTextField.shake()
                    }
                } else {
    
                    //update
                    passwordController.updatePassword(for: password, changeTitleTo: title, changeUserNameTo: userName, changePasswordTo: passwordInput, changeNotesTo: notes)
                    NotificationCenter.default.post(name: .needtoReloadData, object: self)
                    self.dismiss(animated: true, completion: nil)
                }
                
            }
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //private methods
    private func updateViews() {
        if let password = self.password {
            self.title = password.title
            self.titleTextField?.text = password.title
            self.userNameTextField?.text = password.username
            self.passwordTextField?.text = password.password
            self.notesTextView?.text = password.notes
            self.buttonsView?.isHidden = false
            self.logoRightLabel.text = String(password.title!.prefix(1))
        } else {
            self.title = "Add Password"
            self.buttonsView?.isHidden = true
        }
    }
    
    //setup uiview
    private func setUpButtonsUIView() {
        self.buttonsView.shapeButtonsView()
    }
    
    //setup textfield design
    private func setUpTextFields() {
        //title
        titleTextField.shapeTextField()
        //titleLabel
        //titleLabel.frame = CGRect(x: 40, y: self.titleTextField.frame.origin.y / 2 - 7, width: 40, height: 40)
        titleLabel.frame = CGRect(x: 40, y: 15, width: 40, height: 40)
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .thin)
        titleLabel.text = "Title"
        titleLabel.textColor = .lightGray
        titleLabel.alpha = 0
        self.titleTextField.addSubview(titleLabel)
        
        self.addRightLogoView()
        
        
        
        //userName
        userNameTextField.shapeTextField()
        //userNameLabel
        userNameLabel.frame = CGRect(x: 40, y: 15, width: 80, height: 40)
        userNameLabel.font = UIFont.systemFont(ofSize: 15, weight: .thin)
        userNameLabel.text = "Username"
        userNameLabel.textColor = .lightGray
        userNameLabel.alpha = 0
        self.userNameTextField.addSubview(userNameLabel)
        
        
        //password
        passwordTextField.shapeTextField()
        //passwordInputLabel
        passwordInputLabel.frame = CGRect(x: 40, y: 15, width: 80, height: 40)
        passwordInputLabel.font = UIFont.systemFont(ofSize: 15, weight: .thin)
        passwordInputLabel.text = "Password"
        passwordInputLabel.textColor = .lightGray
        passwordInputLabel.alpha = 0
        self.passwordTextField.addSubview(passwordInputLabel)
        
        
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
        
        
        //textfields images
        let titleIcon = UIImage(named: "title")!
        self.titleTextField.addLeftImage(image: titleIcon)
        
        let userNameIcon = UIImage(named: "userName")!
        self.userNameTextField.addLeftImage(image: userNameIcon)
        
        let lockIcon = UIImage(named: "lock")!
        self.passwordTextField.addLeftImage(image: lockIcon)
        
        let eyesClosed = UIImage(named: "eyes-closed")!
        self.setUpShowHidePasswordButton(image: eyesClosed)
    }
    
    private func setUpShowHidePasswordButton(image: UIImage) {
        showHideButton = UIButton(frame: CGRect(x: 3.0, y: 3.0, width: 30.0, height: 30.0))
        showHideButton.setImage(image, for: .normal)
        showHideButton.tintColor = UIColor.black
        let iconContainer: UIView = UIView(frame: CGRect(x: 5.0, y: 0, width: 40, height: 30))
        iconContainer.addSubview(showHideButton)
        
        self.passwordTextField.rightView = iconContainer
        self.passwordTextField.rightViewMode = .always
        
        //logic for show hide button
        showHideButton.addTarget(self, action: #selector(showHideButtonImageTapped), for: .touchUpInside)
    }
    
    @objc func showHideButtonImageTapped() {
        if hidePassword {
            self.showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
            self.passwordTextField.isSecureTextEntry = true
            hidePassword = false
        } else {
            self.showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
            self.passwordTextField.isSecureTextEntry = false
            hidePassword = true
        }
    }
    
    //set up rightview for setting up the logo image property
    private func addRightLogoView() {
        logoRightLabel.frame = CGRect(x: 10.0, y: 10.0, width: 30.0, height: 30.0)
        logoRightLabel.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
        logoRightLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        logoRightView.backgroundColor = .white

        //give constraints for the label
        logoRightView.frame = CGRect(x: 0.0, y: 0, width: 40, height: 40)
        logoRightView.layer.cornerRadius = 10
        logoRightView.layer.borderWidth = 1.5
        logoRightView.layer.borderColor = UIColor.black.cgColor
        //random uiview color
        //logoRightView.backgroundColor = .orange
        logoRightView.addSubview(logoRightLabel)
        
        //add padding by adding another uiview with bigger width
        let logoRightViewWithPadding: UIView = UIView(frame: CGRect(x: 0.0, y: 0, width: 50, height: 40))
        logoRightViewWithPadding.addSubview(logoRightView)
        
        self.titleTextField.rightView = logoRightViewWithPadding
        self.titleTextField.rightViewMode = .always
    }
    
}



//Extensions
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
    
    //textfield being edited
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let oldText = textField.text,
            let stringRange = Range(range, in: oldText) else {
                return false
        }
        
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        let chosenTextField = textField
        switch chosenTextField {
        case self.titleTextField:
            self.chosenLabel = self.titleLabel
        case self.userNameTextField:
            self.chosenLabel = self.userNameLabel
        case self.passwordTextField:
            self.chosenLabel = self.passwordInputLabel
        default:
            self.chosenLabel = self.titleLabel
        }
        
        if !newText.isEmpty {
            
        //add fetch company logo here and make completion result to show in logoRightView
        //this will hit the internet on g, o, o, g, l, e for google and once it hits google it will show the logo image
        // then save it to the object property - image
            self.passwordController?.fetchCompanyLogo(searchTerm: "\(newText).com", completion: { (result) in
                if let result = try? result.get() {
                    DispatchQueue.main.async {
                        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
                        imageView.image = result
                        self.logoRightView.addSubview(imageView)
                    }
                }
            })
            
            
            UILabel.animate(withDuration: 0.1, animations: {
                self.chosenLabel.alpha = 1
                self.chosenLabel.frame.origin.x = 40
                self.chosenLabel.frame.origin.y = -5
                //give a logic so if there is no image from the internet then trigger this
                if self.chosenLabel == self.titleLabel {
                    self.logoRightLabel.alpha = 1
                    self.logoRightLabel.text = String(newText.prefix(1).capitalized)
                    self.logoRightView.backgroundColor = UIColor(red: CGFloat(Int.random(in: 2...255)) / 255, green: CGFloat(Int.random(in: 1...255)) / 255, blue: CGFloat(Int.random(in: 1...255)) / 255, alpha: 1)
                }
            }, completion: nil)
            
        } else {
            UILabel.animate(withDuration: 0.1, animations: {
                self.chosenLabel.alpha = 0
                self.chosenLabel.frame.origin.x = 40
                self.chosenLabel.frame.origin.y = 15
                if self.chosenLabel == self.titleLabel {
                    self.logoRightLabel.alpha = 0
                    self.logoRightView.backgroundColor = .white
                }
            }, completion: nil)
        }
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
