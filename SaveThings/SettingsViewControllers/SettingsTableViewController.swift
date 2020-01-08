//
//  SettingsTableViewController.swift
//  SaveThings
//
//  Created by Dongwoo Pae on 1/8/20.
//  Copyright © 2020 Dongwoo Pae. All rights reserved.
//

import UIKit
import StoreKit
import MessageUI

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet weak var rateUsButton: UIButton!
    @IBOutlet weak var emailSupportButton: UIButton!
    @IBOutlet weak var autoFaceIDSwitchButton: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateViews()
    }

    @IBAction func rateUsButtonTapped(_ sender: Any) {
        SKStoreReviewController.requestReview()
        self.rateUsButton.shake()
    }

    @IBAction func emailSupportButtonTapped(_ sender: Any) {
        //this needs to be ran on a device
        self.emailSupportButton.shake()
        self.showMailComposer()
    }
    
    private func showMailComposer() {
        
        guard MFMailComposeViewController.canSendMail() else {
            self.showNoEmailAlert()
            return
        }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["dongwoopae@gmail.com"])
        composer.setSubject("Support Request")
        
        present(composer, animated: true)
    }
    
    @IBAction func autoFaceIDSwitchButtonTapped(_ sender: UISwitch) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(sender.isOn, forKey: .shouldRunAutoFaceID)
    }
    
    //UpdateView - UISwitch
    private func updateViews() {
        let userDefaults = UserDefaults.standard
        if userDefaults.bool(forKey: .shouldRunAutoFaceID) {
            self.autoFaceIDSwitchButton.isOn = true
        } else {
            self.autoFaceIDSwitchButton.isOn = false
        }
    }
}

extension SettingsTableViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let _ = error {
            controller.dismiss(animated: true, completion: nil)
            return
        }
        
        switch result {
        case .cancelled:
            print("cancelled")
        case .failed:
            print("failed to send")
        case .saved:
            print("saved")
        case .sent:
            print("email sent")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.showEmailSentAlert()
            }
        default:
            print("default")
        }
        controller.dismiss(animated: true, completion: nil)
    }
    
    private func showEmailSentAlert() {
        let alert = UIAlertController(title: "Email Sent", message: "We will get back to you shortly", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(okayAction)
        self.present(alert, animated: true)
    }
    
    private func showNoEmailAlert() {
        let alert = UIAlertController(title: "No Email View Available", message: "Please contact us at dongwoopae@gmail.com", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(okayAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
}
