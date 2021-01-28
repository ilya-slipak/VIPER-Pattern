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
    
    func getObjects<T: Object>(_ type: T.Type, predicate: NSPredicate?) -> Results<T>
    func saveObjects<T: Object>(objects: [T])
}

final class DatabaseService {
    
    static let shared = DatabaseService()
    private let realm = try! Realm()
}

extension DatabaseService: DatabaseServiceProtocol {
    
    func getObjects<T: Object>(_ type: T.Type, predicate: NSPredicate?) -> Results<T> {
        
        guard let predicate = predicate else {
            return realm.objects(T.self)
        }
        
        let filteredObjects = realm.objects(T.self).filter(predicate)
        
        return filteredObjects
    }
    
    func saveObjects<T: Object>(objects: [T]) {
        
        objects.forEach { object in
            do {
                try realm.write {
                    realm.create(T.self, value: object, update: .all)
                    print("SUCCESFULLY saved to databse")
                }
            } catch {
                print("FAIILED SAVE TO DATABASE \(error.localizedDescription)")
            }
        }
    }
}
