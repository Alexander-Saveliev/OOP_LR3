//
//  Function.swift
//  LR32
//
//  Created by Marty on 06/05/2018.
//  Copyright © 2018 Marty. All rights reserved.
//

class Function: Identifier {
    private let name: String
    private var value: Double? {
        didSet {
            if value == nil {
                for dependence in dependencies {
                    dependence.setToNil()
                }
            }
        }
    }
    var dependencies = [Function]()
    
    private var leftOperand : Identifier?
    private var rightOperand: Identifier?
    private var operation   : Operation
    
    func calculate() -> Double? {
        if value == nil {
            value = operation.calculate(left: leftOperand?.calculate(), right: rightOperand?.calculate())
        }
        
        return value
    }
    
    func getName() -> String {
        return name
    }
    
    func getValueToString() -> String {
        return String(format: "%.02f", calculate() ?? "nan")
    }
    
    func setToNil() {
        value = nil
    }
    
    init(withName name: String, left: Identifier, operation: Operation, right: Identifier) {
        leftOperand = left
        rightOperand = right
        self.operation = operation
        self.name = name
        
        left.dependencies.append(self)
        right.dependencies.append(self)
    }
    
    init(withName name: String, left: Identifier) {
        leftOperand = left
        operation = .unary
        self.name = name
        
        left.dependencies.append(self)
    }
}
