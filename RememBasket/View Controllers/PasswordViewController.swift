//
//  PasswordViewController.swift
//  RememBasket
//
//  Created by Dongwoo Pae on 11/14/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController, UIViewControllerTransitioningDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    let transition = transitionAnimation()
    
    let passwordController = PasswordController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        menuButton.layer.cornerRadius = menuButton.frame.size.width / 2
        
        self.observeShouldReloadData()
    }
    
    //observer to reload data
    func observeShouldReloadData() {
        NotificationCenter.default.addObserver(self, selector: #selector(refreshViews(notification:)), name: .needtoReloadData, object: nil)
    }
    
    @objc func refreshViews(notification: Notification) {
        self.tableView.reloadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    //tableView data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.passwordController.passwords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PasswordCell", for: indexPath)
        let password = passwordController.passwords[indexPath.row]
        cell.textLabel?.text = password.title
        cell.detailTextLabel?.text = password.username
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let password = self.passwordController.passwords[indexPath.row]
            self.passwordController.deletePassword(for: password)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! PasswordDetailViewController
        detailVC.transitioningDelegate = self
        detailVC.modalPresentationStyle = .custom
        
        if segue.identifier == "ToUpdatePassword" {
            guard let selectedRow = tableView.indexPathForSelectedRow else {return}
            let password = self.passwordController.passwords[selectedRow.row]
            detailVC.password = password
            detailVC.passwordController = self.passwordController
        } else if segue.identifier == "ToAddPassword" {
            let detailVC = segue.destination as! PasswordDetailViewController
            detailVC.passwordController = self.passwordController
        }
    }
    
    
    //transition animation
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = menuButton.center
        transition.circleColor = menuButton.backgroundColor!
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = menuButton.center
        transition.circleColor = menuButton.backgroundColor!
        return transition
    }
}
