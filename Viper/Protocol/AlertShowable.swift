//
//  AlertViewProtocol.swift
//  Viper
//
//  Created by Ilya Slipak on 10/4/19.
//  Copyright © 2019 Ilya Slipak. All rights reserved.
//

import UIKit

protocol AlertShowable: class {
    
    func showAlert(_ buttonOK: String, _ buttonCancel: String?, _ title: String?, _ message: String?, completion: (() -> Void)?)
}

extension AlertShowable where Self: UIViewController {
    
    func showAlert(_ buttonOK: String, _ buttonCancel: String?, _ title: String?, _ message: String?, completion: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonOK, style: .default, handler: { (_) in
            completion?()
        }))
        if let buttonCancel = buttonCancel {
            alert.addAction(UIAlertAction(title: buttonCancel, style: .default, handler: { (_) in
            }))
        }
        present(alert, animated: true, completion: nil)
    }
}
