//
//  UsersViewController.swift
//  MVVM Moya
//
//  Created by Arifin Firdaus on 6/24/19.
//  Copyright © 2019 Arifin Firdaus. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    
    @IBOutlet fileprivate var tableView: UITableView!
    
    fileprivate let usersViewModel = UsersViewModel()
    fileprivate let postViewModel = PostViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        attemptFetchUsers()
    }
    
    fileprivate func attemptFetchUsers() {
        usersViewModel.fetchUsers { state in
            switch state {
            case .success: self.handleUIForSuccessFetchUsers()
            case .failure: self.showAlert()
            }
        }
    }
    
    fileprivate func handleUIForSuccessFetchUsers() {
        self.tableView.reloadData()
    }
    
    fileprivate func showAlert() {
        guard let errorMessage = usersViewModel.message else {
            return
        }
        showAlertController(withTitle: "Error", message: errorMessage, completion: nil)
    }
    
    fileprivate func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        setupCell()
    }
    
    fileprivate func setupCell() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    fileprivate func setupNavBar() {
        title = "Users"
    }
    
    @IBAction fileprivate func addNewPost(_ sender: UIBarButtonItem) {
        attemptAddPost()
    }
    
    fileprivate func attemptAddPost() {
        let title = "foo"
        let body = "bar"
        let userId = 1
        postViewModel.addPost(with: title, body: body, userId: userId) { state in
            switch state {
            case .success: self.showSuccessAddPostAlert()
            case .failure: self.showPostErrorAlert()
            }
        }
    }
    
    fileprivate func showSuccessAddPostAlert() {
        guard let message = postViewModel.sucessMessage else { return }
        showAlertController(withTitle: "Success", message: message, completion: nil)
    }
    
    fileprivate func showPostErrorAlert() {
        guard let errorMessage = postViewModel.message else {
            return
        }
        showAlertController(withTitle: "Error", message: errorMessage, completion: nil)
    }
    
}

// MARK: - UITableViewDataSource

extension UsersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersViewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let user = usersViewModel.users[indexPath.row]
        cell.textLabel?.text = user.name
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension UsersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = usersViewModel.users[indexPath.row]
        guard let id = user.id else { return }
        showUser(with: id)
    }
    
    func showUser(with id: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "UserViewController") as? UserViewController else {
            return
        }
        viewController.userId = id
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
