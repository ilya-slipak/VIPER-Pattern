//
//  RecipesListPresenter.swift
//  Viper
//
//  Created by Ilya Slipak on 10/4/19.
//  Copyright © 2019 Ilya Slipak. All rights reserved.
//

import Foundation

protocol RecipesPresenterProtocol: class {
    
    // MARK: - Properties
    
    var recipes: [Recipe] { get }
    
    // MARK: - Methods
    
    func viewDidLoad()
    func searchAction(searchString: String)
}

final class RecipesPresenter {
    
    // MARK: - Properties
    
    weak var view: (RecipesViewProtocol & AlertShowable)!
    var interactor: RecipesInteractorProtocol!
    var router: RecipesRouterProtocol!
    
    var recipes = [Recipe]()
    
    init(view: RecipesViewProtocol & AlertShowable) {
        self.view = view
    }
    
    // MARK: - Private Methods
        
    private func reloadUI() {
        
        view.setupTableViewHiddenState(isHidden: true)
        view.setNoResultLabel(isHidden: true)
    }
    
    private func checkIfDataSourceIsEmpty() {
        
        guard recipes.isEmpty else {
            
            view.setupTableViewHiddenState(isHidden: false)
            view.setNoResultLabel(isHidden: true)
            return
        }
        
        view.setupTableViewHiddenState(isHidden: true)
        view.setNoResultLabel(isHidden: false)
    }
        
    private func getRecipes(searchString: String) {
        
        reloadUI()
        view.dismissKeyboard()
        view.showSpinner()
        interactor.getRecipesFromAPI(searchString: searchString) { [weak self] result in
            
            guard let self = self else { return }
            
            self.view.hideSpinner()
            switch result {
            case .success(let recipesModel):
                self.recipes = recipesModel.recipes
                self.interactor.saveRecipes(recipes: self.recipes)
            case .noInternet:
                
                self.recipes = self.interactor.getLocalRecipes(searchString: searchString)
                if self.recipes.isEmpty {
                    self.view.showAlert("OK", nil, "No internet connection", nil, completion: nil)
                }
            case .failure(let error):
                self.view.showAlert("OK", nil, error.localizedDescription, nil, completion: nil)
            }
            self.view.updateTableView()
            self.checkIfDataSourceIsEmpty()
        }
    }
}

// MARK: - RecipesPresenterProtocol

extension RecipesPresenter: RecipesPresenterProtocol {
    
    func viewDidLoad() {
        
        view.setupUI()
        getRecipes(searchString: "")
    }
    
    func searchAction(searchString: String) {
        
        getRecipes(searchString: searchString)
    }
    
    func dismissKeyboardAction() {
        
        view.dismissKeyboard()
    }
}
