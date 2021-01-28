//
//  RecipesService.swift
//  Viper
//
//  Created by Ilya Slipak on 10/4/19.
//  Copyright © 2019 Ilya Slipak. All rights reserved.
//

import Foundation
import Moya

typealias RecipesModelCompletion = (ResponseResult<RecipesModel>) -> Void

enum ResponseResult<T> {
    
    case success(T)
    case noInternet
    case failure(Error)
}

protocol RecipesServiceProtocol: class {
    
    func getRecipes(searchString: String, completion: @escaping RecipesModelCompletion)
}

final class RecipesAPIClient {
    
    private let provider = MoyaProvider<RecipesAPI>()
    private let decoder = JSONDecoder()
}

// MARK: - RecipesServiceProtocol

extension RecipesAPIClient: RecipesServiceProtocol {
    
    func getRecipes(searchString: String, completion: @escaping RecipesModelCompletion) {
        
        provider.request(.getRecipes(searchString: searchString)) { [weak self] result in
            self?.handleResult(result, completion: completion)
        }
    }
    
    private func handleResult(_ result: Result<Response, MoyaError>, completion: @escaping RecipesModelCompletion) {
        
        switch result {
        case .success(let response):
            do {
                let result = try decoder.decode(RecipesModel.self, from: response.data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        case .failure(let error):
            if error.errorCode == 6 {
                completion(.noInternet)
            } else {
                completion(.failure(error))
            }
        }
    }
}
