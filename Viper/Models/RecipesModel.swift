//
//  RecipesModel.swift
//  Viper
//
//  Created by Ilya Slipak on 10/4/19.
//  Copyright © 2019 Ilya Slipak. All rights reserved.
//

import Foundation
import RealmSwift

struct RecipesModel:  Codable {
    
    var title: String
    var version: Double
    var href: String
    var recipes: [Recipe]
    
    enum CodingKeys: String, CodingKey {
        case title
        case version
        case href
        case recipes = "results"
    }
}

class Recipe: Object, Codable {
    
    @objc dynamic var title: String?
    @objc dynamic var href: String?
    @objc dynamic var ingredients: String?
    @objc dynamic var thumbnail: String?
    
    override static func primaryKey() -> String? {
        return "title"
    }
    
    convenience init(title: String, href: String, ingredients: String, thumbnail: String) {
        self.init()
        
        self.title = title
        self.href = href
        self.ingredients = ingredients
        self.thumbnail = thumbnail
    }
}
