//
//  Calculator.swift
//  LR32
//
//  Created by Marty on 06/05/2018.
//  Copyright © 2018 Marty. All rights reserved.
//

import Foundation

class Calculator {
    var listOfIdentifiers = [Identifier]()
    
    private func getElementByName(_ name: String) -> Identifier? {
        if let index = listOfIdentifiers.index(where: { $0.getName() == name }) {
            return listOfIdentifiers[index]
        } else {
            return nil
        }
    }
    
    private func isIdentifierExist(_ name: String) -> Bool {
        return listOfIdentifiers.index(where: { $0.getName() == name }) != nil
    }
    
    private func printElementsOfType(_ neededType: Identifier.Type) {
        for element in listOfIdentifiers.sorted(by: { $0.getName() < $1.getName() }) where type(of: element) == neededType {
            print(element.getName(), ": ", element.getValueToString())
        }
    }
    
    func printAllFuncs() {
        printElementsOfType(Function.self)
    }
    
    func printAllVars() {
        printElementsOfType(Var.self)
    }
    
    func getValueOfIdentifier(_ name: String) -> Double? {
        return getElementByName(name)?.calculate()
    }
    
    func getValueOfIdentifierToString(_ name: String) -> String {
        return getElementByName(name)?.getValueToString() ?? "unknown identifier"
    }
    
    
    // MARK: - Var -
    private func setVar(_ name: String, value: Double) -> Bool {
        if let element = getElementByName(name) {
            if let variable = element as? Var {
                variable.setValue(value)
            } else {
                return false
            }
        } else {
            listOfIdentifiers.append(Var(withName: name, andValue: value))
        }
        return true
    }
    
    func addVariable(_ variable: Var) -> Bool {
        if isIdentifierExist(variable.getName()) {
            return false
        } else {
            listOfIdentifiers.append(variable)
            return true
        }
    }
    
    func addVarWithName(_ name: String) -> Bool {
        if isIdentifierExist(name) {
            return false
        } else {
            listOfIdentifiers.append(Var(withName: name))
            return true
        }
    }
    
    func setVarWithName(_ name: String, value: Double) -> Bool {
        return setVar(name, value: value)
    }
    
    func setVarWithName(_ name: String, variableName: String) -> Bool {
        if let elenent = getElementByName(variableName),
           let result = elenent.calculate() {
            return setVar(name, value: result)
        } else {
            return false
        }
    }
    
    // MARK: - Function -
    func addFuncWithName(_ name: String, equalToIdentifier identifier: Identifier) -> Bool {
        guard isIdentifierExist(identifier.getName()) && !isIdentifierExist(name) else {
            return false
        }
        
        listOfIdentifiers.append(Function(withName: name, left: identifier))
        return true
    }
    
    func addFuncWithName(_ name: String, leftIdentifier: Identifier, rightIdentifier: Identifier, operation: Operation) -> Bool {
        guard isIdentifierExist(leftIdentifier.getName()) && isIdentifierExist(rightIdentifier.getName()) && !isIdentifierExist(name) else {
            return false
        }
        
        listOfIdentifiers.append(Function(withName: name, left: leftIdentifier, operation: operation, right: rightIdentifier))
        return true
    }
    
    func addFuncWithName(_ name: String, equalToIdentifier identifier: String) -> Bool {
        guard !isIdentifierExist(name) else {
            return false
        }
        
        guard let left = getElementByName(identifier) else {
            return false
        }
        
        listOfIdentifiers.append(Function(withName: name, left: left))
        return true
    }
    
    func addFuncWithName(_ name: String, leftIdentifier: String, rightIdentifier: String, operation: Operation) -> Bool {
        guard !isIdentifierExist(name) else {
            return false
        }
        
        guard let left  = getElementByName(leftIdentifier),
              let right = getElementByName(rightIdentifier) else {
                return false
        }
        
        listOfIdentifiers.append(Function(withName: name, left: left, operation: operation, right: right))
        return true
    }
}
