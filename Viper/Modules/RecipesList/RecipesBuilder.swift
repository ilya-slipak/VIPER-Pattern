//
//  RecipesListConfigurator.swift
//  Viper
//
//  Created by Ilya Slipak on 10/4/19.
//  Copyright © 2019 Ilya Slipak. All rights reserved.
//

import UIKit

protocol RecipesBuilderProtocol {
    
    mutating func configure(with viewController: RecipesViewController)
}

struct RecipesBuilder: RecipesBuilderProtocol {
    
    var presenter: RecipesPresenter!
    var interactor: RecipesInteractor!
    var router: RecipesRouter!
    
    mutating func configure(with viewController: RecipesViewController) {
        
        presenter = RecipesPresenter(view: viewController)
        interactor = RecipesInteractor(presenter: presenter)
        router = RecipesRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        
        assembleServices()
    }
    
    private func assembleServices() {
        
        interactor.validationService = ValidationService()
        interactor.recipesDatabase = RecipeDatabase()
        interactor.recipesService = RecipesAPIClient()
    }
}
