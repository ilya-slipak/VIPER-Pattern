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
    
    private func handleResult(result: ResponseResult<RecipesModel>) {
        switch result {
        case .success(let recipesModel):
            recipes = recipesModel.recipes
            view.updateTableView()
        case .noInternet(let recipes):
            
            guard !recipes.isEmpty else {
                view.showAlert("OK", nil, "No internet connection", nil, completion: nil)
                return
            }
            updateRecipes(inputRecipes: Array(recipes))
            view.updateTableView()
        case .failure(let error):
            view.showAlert("OK", nil, error.localizedDescription, nil, completion: nil)
        }
    }
    
    private func updateRecipes(inputRecipes: [Recipe]) {
        
        recipes.removeAll()
        recipes = inputRecipes
    }
    
    private func reloadUI() {
        
        view.setupTableViewHiddenState(isHidden: true)
        view.setNoResultLabel(isHidden: true)
    }
    
    private func checkIfDataSourceIsEmpty() {
        
        if recipes.count == 0 {
            view.setupTableViewHiddenState(isHidden: true)
            view.setNoResultLabel(isHidden: false)
        } else {
            view.setupTableViewHiddenState(isHidden: false)
            view.setNoResultLabel(isHidden: true)
        }
    }
    
    private func getRecipes() {
        
        reloadUI()
        view.dismissKeyboard()
        view.showSpinner()
        interactor.performGetRecipes { [weak self] (result) in
            guard let self = self else { return }
            self.view.hideSpinner()
            self.handleResult(result: result)
            self.checkIfDataSourceIsEmpty()
        }
    }
    
    private func getSearchRecipes(searchString: String) {
        
        reloadUI()
        view.dismissKeyboard()
        view.showSpinner()
        interactor.performGetSearchRecipes(searchString: searchString) { [weak self] (result) in
            guard let self = self else { return }
            self.view.hideSpinner()
            self.handleResult(result: result)
            self.checkIfDataSourceIsEmpty()
        }
    }
}

// MARK: - RecipesPresenterProtocol

extension RecipesPresenter: RecipesPresenterProtocol {
    
    func viewDidLoad() {
        
        view.setupUI()
        getRecipes()
    }
    
    func searchAction(searchString: String) {
        
        getSearchRecipes(searchString: searchString)
    }
    
    func dismissKeyboardAction() {
        
        view.dismissKeyboard()
    }
}
