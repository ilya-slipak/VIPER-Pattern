//
//  RecipesListInteractor.swift
//  Viper
//
//  Created by Ilya Slipak on 10/4/19.
//  Copyright © 2019 Ilya Slipak. All rights reserved.
//

import Foundation

protocol RecipesInteractorProtocol: class {

    func performGetRecipes(completion: @escaping RecipesModelCompletion)
    func performGetSearchRecipes(searchString: String, completion: @escaping RecipesModelCompletion)
}

final class RecipesInteractor {
    
    weak var presenter: RecipesPresenterProtocol!
    var recipesService: RecipesServiceProtocol!
    var databaseService: DatabaseServiceProtocol!
    var validationService: ValidationServiceProtocol!
    
    init(presenter: RecipesPresenterProtocol) {
        self.presenter = presenter
    }
}

extension RecipesInteractor: RecipesInteractorProtocol {
    
    // MARK: - Methods
    
    func performGetRecipes(completion: @escaping RecipesModelCompletion) {
        recipesService.getRecipes(completion: completion)
    }
    
    func performGetSearchRecipes(searchString: String, completion: @escaping RecipesModelCompletion) {
        
        if !validationService.emptyStringValidation(string: searchString) {
            recipesService.getSearchRecipes(searchString: searchString, completion: completion)
        } else {
            recipesService.getRecipes(completion: completion)
        }
    }
}
