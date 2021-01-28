//
//  RecipeDatabase.swift
//  Viper
//
//  Created by Ilya Slipak on 28.01.2021.
//  Copyright © 2021 Ilya Slipak. All rights reserved.
//

import Foundation
import RealmSwift

protocol RecipesDatabaseProtocol: class {
    
    func getRecipes(searchString: String) -> [Recipe]
    func saveRecipes(recipes: [Recipe])
}

final class RecipeDatabase {
    
}

extension RecipeDatabase: RecipesDatabaseProtocol {
    
    func getRecipes(searchString: String) -> [Recipe] {
        
        guard !searchString.isEmpty else {
            
            return DatabaseService.shared
                .getObjects(Recipe.self, predicate: nil)
                .toArray(ofType: Recipe.self)
        }
        
        let predicate = NSPredicate(format: "title == %@", searchString)
        
        return DatabaseService.shared
            .getObjects(Recipe.self, predicate: predicate)
            .toArray(ofType: Recipe.self)
    }
        
    func saveRecipes(recipes: [Recipe]) {
        
        DatabaseService.shared.saveObjects(objects: recipes)
    }
}
