//
//  UserViewController.swift
//  MVVM Moya
//
//  Created by Arifin Firdaus on 6/28/19.
//  Copyright © 2019 Arifin Firdaus. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var userId: Int?
    
    fileprivate let viewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let id = userId else { return }
        attemptFetchUser(with: id)
    }
    
    fileprivate func attemptFetchUser(with id: Int) {
        viewModel.fetchUser(with: id) { state in
            switch state {
            case .success: self.updateViews()
            case .failure: print("failure")
            }
        }
    }
    
    fileprivate func updateViews() {
        title = viewModel.getUsername()
        nameLabel.text = viewModel.user?.name
        addressLabel.text = viewModel.getAddress()
    }
    
}
