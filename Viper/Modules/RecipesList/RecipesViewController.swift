//
//  ViewController.swift
//  Viper
//
//  Created by Ilya Slipak on 10/4/19.
//  Copyright © 2019 Ilya Slipak. All rights reserved.
//

import UIKit

protocol RecipesViewProtocol: class {
    
    func setupUI()
    func setupTableViewHiddenState(isHidden: Bool)
    func setNoResultLabel(isHidden: Bool)
    func showSpinner()
    func hideSpinner()
    func updateTableView()
    func dismissKeyboard()
}

final class RecipesViewController: UIViewController, AlertShowable {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var noResultsLabel: UILabel!
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchView: SearchView!
    
    // MARK: - Properties
    
    weak var presenter: RecipesPresenterProtocol!
    var builder: RecipesBuilderProtocol = RecipesBuilder()
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        builder.configure(with: self)
        presenter.viewDidLoad()
    }
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension RecipesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return presenter.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.recipesCell.identifier) as? RecipesCell else {
            return UITableViewCell()
        }
        
        let recipe = self.presenter.recipes[indexPath.row]
        cell.configure(recipesModel: recipe)
        
        return cell
    }
    
}

// MARK: - SearchViewDelegate

extension RecipesViewController: SearchViewDelegate {
    
    func searchAction(searchText: String?) {
        
        guard let searchText = searchText else {
            return
        }
        
        presenter.searchAction(searchString: searchText)
    }
}

// MARK: - RecipesViewProtocol

extension RecipesViewController: RecipesViewProtocol {
    
    func setupUI() {
        
        tableView.register(R.nib.recipesCell)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.keyboardDismissMode = .onDrag
        spinner.hidesWhenStopped = true
        searchView.delegate = self
        navigationItem.title = "Recipe labs"
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1728960574, green: 0.5330661535, blue: 0.01584105752, alpha: 1)
    }
    
    func updateTableView() {
        
        tableView.reloadData()
        tableView.setContentOffset(.zero, animated: false)
    }
    
    func setupTableViewHiddenState(isHidden: Bool) {
        
        tableView.isHidden = isHidden
    }
    
    func setNoResultLabel(isHidden: Bool) {
        
        noResultsLabel.isHidden = isHidden
    }
    
    func dismissKeyboard() {
        
        view.endEditing(true)
    }
    
    func showSpinner() {
        
        spinner.isHidden = false
        spinner.startAnimating()
    }
    
    func hideSpinner() {
        
        spinner.stopAnimating()
    }
}
