//
//  RecipesListRouter.swift
//  Viper
//
//  Created by Ilya Slipak on 10/4/19.
//  Copyright © 2019 Ilya Slipak. All rights reserved.
//

import UIKit

protocol RecipesRouterProtocol: class {
    
}

final class RecipesRouter: RecipesRouterProtocol {
    
    weak var viewController: RecipesViewController!
    
    init(viewController: RecipesViewController) {
        
        self.viewController = viewController
    }
}
