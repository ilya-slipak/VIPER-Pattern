//
//  Results+ToArray.swift
//  Viper
//
//  Created by Ilya Slipak on 28.01.2021.
//  Copyright © 2021 Ilya Slipak. All rights reserved.
//

import RealmSwift

extension Results {
    
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()

        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }

        return array
    }
}
