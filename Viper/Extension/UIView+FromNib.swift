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
    func makeFromNib<T: UIView>(named: String? = nil) -> T? {
        
        let nibNamed = named ?? String(describing: type(of: self))
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(nibNamed, owner: self, options: nil)?.first as? T else {
            // xib not loaded, or its top self is of the wrong type
            return nil
        }
        
        backgroundColor = .clear
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            contentView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            contentView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0)
        ])
        
        return contentView
    }
}
