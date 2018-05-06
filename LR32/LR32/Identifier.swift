//
//  Identifier.swift
//  LR32
//
//  Created by Marty on 06/05/2018.
//  Copyright © 2018 Marty. All rights reserved.
//

protocol Identifier: class {
    var dependencies: [Function] {get set}
    
    func calculate() -> Double?
    func getName() -> String
    func getValueToString() -> String
}
