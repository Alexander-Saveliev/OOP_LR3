//
//  Var.swift
//  LR32
//
//  Created by Marty on 06/05/2018.
//  Copyright © 2018 Marty. All rights reserved.
//

import Foundation

class Var: Identifier {
    init(withName name: String) {
        self.name = name
    }
    
    init(withName name: String, andValue value: Double) {
        self.name = name
        self.value = value
    }
    
    init(withName name: String, andVar variable: Var) {
        self.name = name
        self.value = variable.calculate()
    }
    
    var dependencies = [Function]()
    
    func calculate() -> Double? {
        return value
    }
    
    func getName() -> String {
        return name
    }
    
    func getValueToString() -> String {
        if let value = self.value {
            return String(format: "%.02f", value)
        } else {
            return "nan"
        }
    }
    
    func setValue(_ value: Double) {
        self.value = value
    }
    
    private let name: String
    private var value: Double? {
        didSet {
            if oldValue != value {
                for dependence in dependencies {
                    dependence.setToNil()
                }
            }
        }
    }
}
