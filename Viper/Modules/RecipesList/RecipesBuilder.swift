//
//  RecipesListConfigurator.swift
//  Viper
//
//  Created by Ilya Slipak on 10/4/19.
//  Copyright © 2019 Ilya Slipak. All rights reserved.
//

import Foundation
import UIKit

protocol RecipesBuilderProtocol: class {
    
    func configure(with viewController: RecipesViewController)
}

final class RecipesBuilder: RecipesBuilderProtocol {
    
    var presenter: RecipesPresenter!
    var interactor: RecipesInteractor!
    var router: RecipesRouter!

   private func assembleServices() {
    
        interactor.validationService = ValidationService()
        interactor.databaseService = DatabaseService()
        interactor.recipesService = RecipesService()
    }
    
    func configure(with viewController: RecipesViewController) {
        
        presenter = RecipesPresenter(view: viewController)
        interactor = RecipesInteractor(presenter: presenter)
        router = RecipesRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        
        assembleServices()
    }
}
