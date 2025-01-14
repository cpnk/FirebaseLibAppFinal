//
//  UsersEditTableViewController.swift
//  FirebaseLibApp
//
//  Created by Илья Валевич on 5/6/19.
//  Copyright © 2019 IlyaValevich. All rights reserved.
//

import UIKit
import Firebase

class UsersTableViewController: UITableViewController {
    
    var users = [UserProfile]()
    
    var searchedUsers = [UserProfile]()
    
    var searching = false
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var activityView:UIActivityIndicatorView! = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self
        activityView.frame = CGRect(x: 0, y: 0, width: 100.0, height: 100.0)
        activityView.style = .whiteLarge
        activityView.backgroundColor = .green
        activityView.layer.cornerRadius = activityView.bounds.height / 2
        activityView.center = self.view.center
        activityView.hidesWhenStopped = true
        view.addSubview(activityView)
        activityView.startAnimating()
        Database.database().reference().child("users").observe(DataEventType.value, with: { snapshot in
            self.users = []
            
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapshots {
                    
                    if let userDictionary = snap.value as? Dictionary<String, AnyObject> {
                        let id = snap.key
                        let user = UserProfile.parse(snap.key, userDictionary)
                        
                        self.users.insert(user!, at: 0)
                    }
                }
                
            }
            self.activityView.stopAnimating()
            self.searchedUsers = self.users
            self.tableView.reloadData()
            
        })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedUsers.count // return the total items in the items array
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let user = searchedUsers[indexPath.row]
        
        // We are using a custom cell.
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as? UserTableViewCell {
            
            
            
            cell.set(user: user)
            
            return cell
            
        } else {
            print("cell fail")
            return UserTableViewCell()
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = UserProfileViewController.makeUserProfileViewController(user: user)
        vc.modelController = UserController()
        
        self.present(vc, animated: true, completion: nil)
    }
}

extension UsersTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedUsers = users.filter({$0.name.lowercased().prefix(searchText.count) == searchText.lowercased() || $0.surname.lowercased().prefix(searchText.count) == searchText.lowercased() })
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
    
}
