//
//  UIViewController+Alert.swift
//  MVVM Moya
//
//  Created by Arifin Firdaus on 7/1/19.
//  Copyright © 2019 Arifin Firdaus. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlertController(withTitle title: String, message: String, completion: (() -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Oke", style: .default) { action in
            completion?()
        }
        alertController.addAction(OKAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
