//
//  SearchView.swift
//  Viper
//
//  Created by Ilya Slipak on 10/4/19.
//  Copyright © 2019 Ilya Slipak. All rights reserved.
//

import UIKit

protocol SearchViewDelegate: class {
    func searchAction(searchText: String?)
}

final class SearchView: UIView {
    weak var delegate: SearchViewDelegate?

    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!

    @IBOutlet weak var leadingStackViewConstraint: NSLayoutConstraint!
    
    @IBAction func searchAction(_ sender: Any) {
        delegate?.searchAction(searchText:self.searchTextField.text)
    }
    
    var validationService: ValidationServiceProtocol = ValidationService()
    let stackViewWidth: CGFloat = 75
    let leadingPadding: CGFloat = 8
    
    var viewIsLoaded: Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
        self.fromNib()
        self.searchBarView.layer.cornerRadius = 8
        self.searchTextField.delegate = self
    }
    
    func setupView(delegate: SearchViewDelegate) {
        self.delegate = delegate
    }
    
    //I tried to make a change in search position with one method, but something went wrong:)
    func setupLeftContraint() {
        self.leadingStackViewConstraint.constant = (self.searchBarView.frame.width - 100 - leadingPadding) / 2
    }
    
    private func updateLeftConstaint(isSearshState: Bool) {
        if isSearshState {
            self.leadingStackViewConstraint.constant = 8
        } else {
            self.leadingStackViewConstraint.constant = (self.searchBarView.frame.width - stackViewWidth - leadingPadding) / 2
        }
        UIView.animate(withDuration: 0.7) {
            self.layoutIfNeeded()
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !viewIsLoaded {
            self.setupLeftContraint()
            self.viewIsLoaded = true
        }
    }
        
}

extension SearchView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.delegate?.searchAction(searchText: textField.text)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.updateLeftConstaint(isSearshState: true)
        textField.text = ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        if self.validationService.emptyStringValidation(string: text) {
            self.updateLeftConstaint(isSearshState: false)
            textField.text = ""
        }
    }
    
}
