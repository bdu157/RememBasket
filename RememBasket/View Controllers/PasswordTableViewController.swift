//
//  PasswordViewController.swift
//  RememBasket
//
//  Created by Dongwoo Pae on 11/14/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class PasswordTableViewController: UITableViewController {
    
    let passwordController = PasswordController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.placeholder = "Search Password"
        searchController.searchBar.tintColor = .orange
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    //tableView data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.passwordController.passwords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PasswordCell", for: indexPath) as! PasswordTableViewCell
        let password = passwordController.passwords[indexPath.row]
        cell.password = password
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let password = self.passwordController.passwords[indexPath.row]
            self.passwordController.deletePassword(for: password)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToUpdatePassword" {
            let detailVC = segue.destination as! PasswordDetailViewController
            guard let selectedRow = self.tableView.indexPathForSelectedRow else {return}
            let password = self.passwordController.passwords[selectedRow.row]
            detailVC.password = password
            detailVC.passwordController = self.passwordController
        } else if segue.identifier == "ToAddPassword" {
            let detailVC = segue.destination as! PasswordDetailViewController
            detailVC.passwordController = self.passwordController
        }
    }

}
