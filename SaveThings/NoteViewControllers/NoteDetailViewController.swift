//
//  NoteDetailViewController.swift
//  SaveThings
//
//  Created by Dongwoo Pae on 12/28/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit
import Speech

class NoteDetailViewController: UIViewController, SFSpeechRecognizerDelegate {
    
    //MARK: Properties and Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    
    //Buttons
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var buttonsViewInUpdateView: UIView!
    
    //Date Labels
    @IBOutlet weak var createdDateLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var modifiedDateLabel: UILabel!
    @IBOutlet weak var modifiedLabel: UILabel!
    
    
    //MARK: Private Properties
    
    //Private Properties for setUpLogoImage
    private var logoRightLabel: UILabel = UILabel()
    private var logoRightView: UIView = UIView()
    private var rightViewBackgroundColor: UIColor!
    
    //Private Properties for textFields placeholder animation
    private var titleLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateViews()
        
        self.setUpButtonsUIView()
        self.setUpNotesTextView()
        self.setUpTextField()
        self.addDoneButtonToKeyboard()
        
        //navigationController?.navigationBar.prefersLargeTitles = true
        
        //TextField and textview delegates are set up through storyboard
        
        //add authorization here
        speechRecognizer.delegate = self
        
        self.speechImageView.alpha = 0.0
    }
    
    
    // MARK: Speech-to-text recognition authentication
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SFSpeechRecognizer.requestAuthorization {
            [unowned self] (authStatus) in
            DispatchQueue.main.async {
                switch authStatus {
                case .authorized:
                    self.recordButton.isEnabled = true
                    self.recordButton.alpha = 1.0
                case .denied:
                    self.recordButton.isEnabled = false
                    self.recordButton.alpha = 0.2
                    print("Speech recognition authorization denied")
                case .restricted:
                    self.recordButton.isEnabled = false
                    self.recordButton.alpha = 0.2
                    print("Not available on this device")
                case .notDetermined:
                    self.recordButton.isEnabled = false
                    self.recordButton.alpha = 0.2
                    print("Not determined")
                default:
                    self.recordButton.isEnabled = false
                    self.recordButton.alpha = 0.2
                }
            }
        }
    }
    
    var category: Category!
    
    var note: Note? {
        didSet {
            self.updateViews()
        }
    }
    
    var noteController: NoteController?
    
    //MARK: Save Button Action
    
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let title = self.titleTextField.text else {return}
        
        if title.isEmpty {
            self.titleTextField.shake()
        }
        
        guard let noteController = self.noteController,
            let content = self.notesTextView.text,
            let logoViewbgColor = self.rightViewBackgroundColor else {return}
        
        if !title.isEmpty {
            noteController.createNote(title: title, content: content, owner: self.category, logoViewbgColor: logoViewbgColor.rgbUIColorToHexString()) //convert UIColor(RGB) to String (Hex) for CoreData
            navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK: Update Button Action on UpdateView
    @IBAction func saveButtonFromUpdateView(_ sender: Any) {
        guard let title = self.titleTextField.text,
            let logoViewbgColor = self.rightViewBackgroundColor,
            let content = self.notesTextView.text,
            let note = self.note else {return}
        
        if title.isEmpty {
            self.titleTextField.shake()
        }
        
        if !title.isEmpty {
            noteController?.updateNote(for: note, changeTitleTo: title, changeContentTo: content, modifiedDate: Date(), logoViewbgColor: logoViewbgColor.rgbUIColorToHexString())//convert UIColor(RGB) to String (Hex) for CoreData
            NotificationCenter.default.post(name: .needtoReloadData, object: self)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    //MARK: Cancel Button Action on UpdateView
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: Private Methods
    private func updateViews() {
        if let note = self.note, isViewLoaded {
            
            self.titleTextField?.text = note.title
            self.notesTextView?.text = note.content
            
            //Date Formatter
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
            let dateFromCoreData = note.timestamp
            let createdDate = dateFormatter.string(from: dateFromCoreData!)
            dateFormatter.timeZone = NSTimeZone.local
            
            //Created Date
            self.createdDateLabel.text = createdDate
            
            //Labels UISetUp
            self.buttonsViewInUpdateView?.isHidden = false
            self.createdDateLabel?.isHidden = false
            self.createdLabel.isHidden = false
            self.modifiedDateLabel?.isHidden = true
            self.modifiedLabel?.isHidden = true
            
            //Handle Modified Date
            if note.modifiedDate != nil {
                
                //Labels UISetUp
                self.modifiedDateLabel?.isHidden = false
                self.modifiedLabel?.isHidden = false
                
                //DateFormatter
                let dateFormatterModified = DateFormatter()
                dateFormatterModified.dateFormat = "MM/dd/yyyy HH:mm:ss"
                let modifiedDateFromCoreData = note.modifiedDate
                let modifiedDate = dateFormatter.string(from: modifiedDateFromCoreData!)
                dateFormatter.timeZone = NSTimeZone.local
                
                //Modified Date
                self.modifiedDateLabel.text = modifiedDate
            }
            
            self.logoRightLabel.text = String(note.title!.prefix(1).capitalized)
            self.logoRightView.backgroundColor = UIColor(hexString: note.logoViewbgColor!)
            self.rightViewBackgroundColor = UIColor(hexString: note.logoViewbgColor!)
            
        } else {
            self.title = "Add Note"
            
            //Labels UISetUp
            self.buttonsViewInUpdateView?.isHidden = true
            self.createdDateLabel?.isHidden = true
            self.modifiedDateLabel?.isHidden = true
            self.createdLabel?.isHidden = true
            self.modifiedLabel?.isHidden = true
        }
    }
    
    
    //MARK: ButtonView Set Up
    //ButtonView SetUp
    private func setUpButtonsUIView() {
        self.buttonsViewInUpdateView.shapeButtonsViewInUpdateView()
        
        //record button layout
        self.recordButton.layer.borderColor = UIColor.systemBlue.cgColor
        self.recordButton.layer.borderWidth = 1.5
        self.recordButton.layer.backgroundColor = UIColor.clear.cgColor
        
        //shadow
        self.recordButton.layer.shadowOpacity = 0.6
        self.recordButton.layer.shadowOffset = CGSize.zero
        self.recordButton.layer.shadowColor = UIColor.darkGray.cgColor
        self.recordButton.layer.cornerRadius = 15
        
    }
    
    //MARK: Notes TextView Set Up
    //TextView SetUp
    private func setUpNotesTextView() {
        
        notesTextView.tintColor = .orange
        notesTextView.textColor = .black
        notesTextView.layer.cornerRadius = 8
        notesTextView.layer.borderWidth = 0.6
        
        //shadow
        notesTextView.layer.shadowOpacity = 0.6
        notesTextView.clipsToBounds = false
        notesTextView.layer.shadowOffset = CGSize.zero
        notesTextView.layer.shadowColor = UIColor.darkGray.cgColor
    }
    
    //MARK: TextFields Set Up
    private func setUpTextField() {
        
        //MARK: Title TextFields Set Up
        titleTextField.shapeTextField()
        //Placeholder SetUp
        titleLabel.frame = CGRect(x: 40, y: 15, width: 40, height: 40)
        titleLabel.setUpPlaceHolderLabels(for: "Title")
        self.titleTextField.addSubview(titleLabel)
        //RightLogoView SetUp
        self.addRightLogoView()
        //Title Image
        let titleIcon = UIImage(named: "title")!
        self.titleTextField.addLeftImage(image: titleIcon)
        
    }
    
    
    //Set Up Right LogoView in Title TextField
    private func addRightLogoView() {
        logoRightLabel.frame = CGRect(x: 12.0, y: 6.0, width: 30.0, height: 30.0)
        logoRightLabel.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
        logoRightLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        
        //give constraints for the label
        logoRightView.frame = CGRect(x: 0.0, y: 0.0, width: 40, height: 40)
        logoRightView.layer.cornerRadius = 10
        logoRightView.layer.borderWidth = 1.5
        logoRightView.layer.borderColor = UIColor.black.cgColor
        
        logoRightView.addSubview(logoRightLabel)
        
        //add padding by adding another uiview with bigger width
        let logoRightViewWithPadding: UIView = UIView(frame: CGRect(x: 0.0, y: 0, width: 50, height: 40))
        logoRightViewWithPadding.addSubview(logoRightView)
        
        self.titleTextField.rightView = logoRightViewWithPadding
        self.titleTextField.rightViewMode = .always
    }
    
    
    // MARK: Speech to text
    
    // MARK: Properties
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var speechImageView: UIImageView!
    
    // MARK: View Controller Lifecycle
    
    private func startRecording() throws {
        
        // Cancel the previous task if it's running.
        recognitionTask?.cancel()
        self.recognitionTask = nil
        
        // Configure the audio session for the app.
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        let inputNode = audioEngine.inputNode
        
        // Configure the microphone input.
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        // Create and configure the speech recognition request.
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else {
            print("unable to create recognitionRequest")
            return
        }
        recognitionRequest.shouldReportPartialResults = true
        
        // Keep speech recognition data on device
        if #available(iOS 13, *) {
            recognitionRequest.requiresOnDeviceRecognition = false
        }
        
        // Create a recognition task for the speech recognition session.
        // Keep a reference to the task so that it can be canceled.
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            
            //error is not nil all the time so either (result && error) || (error)
            if error != nil {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.recordButton.isEnabled = true
                //when there is no speech to convert into text, this will be called and the button will be changed
                //self.recordButton.setImage(UIImage(named: "speechtotext"), for: [])
                self.recordButton.setTitleColor(.systemBlue, for: .normal)
                self.recordButton.setTitle("Speech-to-Text", for: .normal)
                UIImageView.animate(withDuration: 0.4) {
                    self.speechImageView.alpha = 0.0
                }
                
                print("nothing to do speech-to-text here")
            } else {
                guard let result = result else {return}
                // Update the text view with the results.
                
                self.notesTextView.text = result.bestTranscription.formattedString
            }
        }
        
        audioEngine.prepare()
        try audioEngine.start()
        
        self.notesTextView.text = "Start your speech"
    }
    
    
    @IBAction func recordButtonTapped() {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            //this is key to reset
            self.recognitionTask?.cancel()
            
        } else {
            do {
                try startRecording()
                //recordButton.setImage(UIImage(named: "speechtotext"), for: .normal)
                self.recordButton.setTitleColor(.systemBlue, for: .normal)
                self.recordButton.setTitle("Stop", for: .normal)
                UIImageView.animate(withDuration: 0.4) {
                    self.speechImageView.alpha = 1.0
                }
                DispatchQueue.main.async {
                    self.speechImageView.pulse()
                }
            } catch {
                recordButton.setTitle("Recording Not Available", for: [])
            }
        }
    }
}


//MARK: UITextFieldDelegate Methods
extension NoteDetailViewController: UITextFieldDelegate {
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
    
    
    //When TextField is being edited
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let oldText = textField.text,
            let stringRange = Range(range, in: oldText) else {
                return false
        }
        
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        if !newText.isEmpty {
            
            UILabel.animate(withDuration: 0.1, animations: {
                self.titleLabel.alpha = 1
                self.titleLabel.frame.origin.x = 40
                self.titleLabel.frame.origin.y = -5
                
                self.logoRightView.alpha = 1
                self.logoRightLabel.alpha = 1
                self.logoRightLabel.text = String(newText.prefix(1).capitalized)
                self.logoRightView.backgroundColor = UIColor(red: CGFloat(Int.random(in: 0...255)) / 255, green: CGFloat(Int.random(in: 0...255)) / 255, blue: CGFloat(Int.random(in: 1...254)) / 255, alpha: 1)
                self.rightViewBackgroundColor = self.logoRightView.backgroundColor
            }, completion: nil)
        } else {
            UILabel.animate(withDuration: 0.1, animations: {
                self.titleLabel.alpha = 0
                self.titleLabel.frame.origin.x = 40
                self.titleLabel.frame.origin.y = 15
                self.logoRightLabel.text = nil
                self.logoRightView.backgroundColor = .white
                
                self.logoRightView.layer.borderColor = UIColor.black.cgColor
            }, completion: nil)
        }
        return true
    }
    
}


//MARK: UITextViewDelegate Methods
extension NoteDetailViewController: UITextViewDelegate {
    
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
        
        //MARK: Key Logic for keyboard appear/disappear with right positioning
        //self.view.frame.origin.y + space between textview and the bottom of the app
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
