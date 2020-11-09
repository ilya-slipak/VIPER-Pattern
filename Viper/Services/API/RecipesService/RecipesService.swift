//
//  RecipesService.swift
//  Viper
//
//  Created by Ilya Slipak on 10/4/19.
//  Copyright © 2019 Ilya Slipak. All rights reserved.
//

import Foundation
import Moya
import RealmSwift

typealias RecipesModelCompletion = (ResponseResult<RecipesModel>) -> Void

enum ResponseResult<T> {
    
    case success(T)
    case noInternet(Results<Recipe>)
    case failure(Error)
}

protocol RecipesServiceProtocol: class {
    
    func getRecipes(completion: @escaping RecipesModelCompletion)
    func getSearchRecipes(searchString: String, completion: @escaping RecipesModelCompletion)
}

class RecipesService: RecipesServiceProtocol {
    
    let provider = MoyaProvider<RecipesAPI>()
    let databaseService: DatabaseServiceProtocol = DatabaseService()
    let decoder = JSONDecoder()
    
    func getRecipes(completion: @escaping RecipesModelCompletion) {
        
        provider.request(.getRecipes) { [unowned self] result in
            switch result {
            case .success(let response):
                do {
                    let result = try decoder.decode(RecipesModel.self, from: response.data)
                    self.databaseService.saveRecipes(recipes: result.recipes)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                if error.errorCode == 6 {
                    let localRecipes = self.databaseService.getRecipes()
                    completion(.noInternet(localRecipes))
                } else {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func getSearchRecipes(searchString: String, completion: @escaping RecipesModelCompletion) {
        
        provider.request(.getSearchRecipes(searchString: searchString)) { [unowned self] result in
            switch result {
            case .success(let response):
                do {
                    let result = try decoder.decode(RecipesModel.self, from: response.data)
                    self.databaseService.saveSearchRecipes(recipes: result.recipes)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                if error.errorCode == 6 {
                    let localSearchRecipes = self.databaseService.getSearchRecipes(searchString: searchString)
                    completion(.noInternet(localSearchRecipes))
                } else {
                    completion(.failure(error))
                }
            }
        }
    }
}
