//
//  RecipesListInteractor.swift
//  Viper
//
//  Created by Ilya Slipak on 10/4/19.
//  Copyright © 2019 Ilya Slipak. All rights reserved.
//

import Foundation

protocol RecipesInteractorProtocol: class {
    
    func getRecipesFromAPI(searchString: String, completion: @escaping RecipesModelCompletion)
    func getLocalRecipes(searchString: String) -> [Recipe]
    func saveRecipes(recipes: [Recipe])
}

final class RecipesInteractor {
    
    // MARK: - Properties
    
    weak var presenter: RecipesPresenterProtocol!
    var recipesService: RecipesServiceProtocol!
    var recipesDatabase: RecipesDatabaseProtocol!
    var validationService: ValidationServiceProtocol!
    
    init(presenter: RecipesPresenterProtocol) {
        self.presenter = presenter
    }
}

// MARK: - RecipesInteractorProtocol

extension RecipesInteractor: RecipesInteractorProtocol {
    
    func getRecipesFromAPI(searchString: String, completion: @escaping RecipesModelCompletion) {
        
        guard !validationService.emptyStringValidation(string: searchString) else {
            recipesService.getRecipes(searchString: "", completion: completion)
            return
        }
        recipesService.getRecipes(searchString: searchString, completion: completion)
    }
    
    func getLocalRecipes(searchString: String) -> [Recipe] {
        
        guard !validationService.emptyStringValidation(string: searchString) else {
            
            return recipesDatabase.getRecipes(searchString: "")
        }
        
        return recipesDatabase.getRecipes(searchString: searchString)
    }
    
    func saveRecipes(recipes: [Recipe]) {
        
        recipesDatabase.saveRecipes(recipes: recipes)
    }
}
