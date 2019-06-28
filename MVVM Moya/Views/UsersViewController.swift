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
    
    fileprivate let viewModel = UsersViewModel()
    
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
        viewModel.fetchUsers { state in
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
        guard let errorMessage = viewModel.message else {
            return
        }
        print(errorMessage)
        
        // TODO: - showing AlertController
        // ...
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
    
}

// MARK: - UITableViewDataSource

extension UsersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let user = viewModel.users[indexPath.row]
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
        let user = viewModel.users[indexPath.row]
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
