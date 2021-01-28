//
//  RecipesAPI.swift
//  Viper
//
//  Created by Ilya Slipak on 10/4/19.
//  Copyright © 2019 Ilya Slipak. All rights reserved.
//

import UIKit
import Moya

enum RecipesAPI {
    
    case getRecipes(searchString: String)
}

extension RecipesAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: API.baseURL) else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    var path: String {
        return "api/"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getRecipes(let searchString):
            var parameters: [String: Any] = ["i": "onions,garlic",
                                             "q": "omelet",
                                             "p": 3]
            if !searchString.isEmpty {
                parameters["q"] = searchString
            }
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return [
            "Content-Type": "application/x-www-form-urlencoded",
            "Accept": "application/json"]
    }
}
