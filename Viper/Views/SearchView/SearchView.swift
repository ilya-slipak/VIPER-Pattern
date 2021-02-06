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
    
    // MARK: - IBOutlet Properties

    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    
    // MARK: - Public Properties
        
    let validationService: ValidationServiceProtocol = ValidationService()
    let stackViewWidth: CGFloat = 75
    let leadingPadding: CGFloat = 8
    weak var delegate: SearchViewDelegate?
    
    // MARK: - Lifecycle Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        self.makeFromNib()
        self.searchBarView.layer.cornerRadius = 8
        self.searchTextField.delegate = self
    }
    
    // MARK: - Setup Methods
    
    func setupView(delegate: SearchViewDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Action Methods
    
    @IBAction func searchAction(_ sender: Any) {
        delegate?.searchAction(searchText:self.searchTextField.text)
    }
}

extension SearchView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.delegate?.searchAction(searchText: textField.text)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        if self.validationService.emptyStringValidation(string: text) {
            textField.text = ""
        }
    }
}
