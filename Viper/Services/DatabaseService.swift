//
//  DatabaseService.swift
//  Viper
//
//  Created by Ilya Slipak on 10/4/19.
//  Copyright © 2019 Ilya Slipak. All rights reserved.
//

import Foundation
import RealmSwift

protocol DatabaseServiceProtocol: class {
    
    func getRecipes() -> Results<Recipe>
    func getSearchRecipes(searchString: String) -> Results<Recipe>
    func saveRecipes(recipes: [Recipe])
    func saveSearchRecipes(recipes: [Recipe])
}

final class DatabaseService: DatabaseServiceProtocol {
    
    let realm = try! Realm()
    
    func getRecipes() -> Results<Recipe> {
        
        return realm.objects(Recipe.self)
    }
    
    func getSearchRecipes(searchString: String) -> Results<Recipe> {
        
        let predicate = NSPredicate(format: "title == %@", searchString)
        let filteredRecipes = realm.objects(Recipe.self).filter(predicate)
        
        return filteredRecipes
    }
    
    func saveRecipes(recipes: [Recipe]) {
        
        recipes.forEach { recipe in
            do {
                try realm.write {
                    realm.create(Recipe.self, value: recipe, update: .all)
                    print("SUCCESFULLY saved to databse")
                }
            } catch {
                print("FAIILED SAVE TO DATABASE \(error.localizedDescription)")
            }
        }
    }

    func saveSearchRecipes(recipes: [Recipe]) {
        
        recipes.forEach { recipe in
            do {
                try realm.write {
                    realm.create(Recipe.self, value: recipe, update: .all)
                    print("SUCCESFULLY saved to databse")
                }
            } catch {
                print("FAIILED SAVE TO DATABASE \(error.localizedDescription)")
            }
        }
    }
}
