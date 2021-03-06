//
//  ValidationService.swift
//  Viper
//
//  Created by Ilya Slipak on 10/4/19.
//  Copyright © 2019 Ilya Slipak. All rights reserved.
//

import Foundation

protocol ValidationServiceProtocol: class {
    
    func isEmpty(string: String) -> Bool
}

final class ValidationService: ValidationServiceProtocol {
    
    func isEmpty(string: String) -> Bool {
        
        return string.range(of: "^\\s*$", options: .regularExpression) != nil
    }
}
