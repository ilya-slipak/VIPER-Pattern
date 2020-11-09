//
//  UIView+FromNib.swift
//  Viper
//
//  Created by Ilya Slipak on 10/4/19.
//  Copyright © 2019 Ilya Slipak. All rights reserved.
//

import UIKit

extension UIView {
    @discardableResult
    func fromNib<T: UIView>(named: String? = nil) -> T? {
        let nibNamed = named ?? String(describing: type(of: self))
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(nibNamed, owner: self, options: nil)?.first as? T else {
            // xib not loaded, or its top self is of the wrong type
            return nil
        }
        self.backgroundColor = .clear
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            contentView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            contentView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0)
            ])
        
        return contentView
    }
}
