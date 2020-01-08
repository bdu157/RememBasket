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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
            self.showEmailSentAlert()
        default:
            print("default")
        }
        controller.dismiss(animated: true, completion: nil)
    }
    
    private func showEmailSentAlert() {
        let alert = UIAlertController(title: "Email Sent", message: "We will get back to you shortly", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(okayAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
    
    private func showNoEmailAlert() {
        let alert = UIAlertController(title: "No Email Available", message: "Please contact us at dongwoopae@gmail.com", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(okayAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
}
