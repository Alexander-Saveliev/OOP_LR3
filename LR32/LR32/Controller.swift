//
//  Controller.swift
//  LR32
//
//  Created by Marty on 06/05/2018.
//  Copyright © 2018 Marty. All rights reserved.
//

class Controller {
    private let calculator = Calculator()
    
    private func excecuteFnWith4args(withElements elements: [String]) {
        let equalSign = "="
        let operand   = elements[3]
        let funcName  = elements[1]
        
        guard elements[2] == equalSign else {
            print("Unexpected element: \(elements[2]). Expected: \(equalSign)")
            return
        }
        
        if !calculator.addFuncWithName(funcName, equalToIdentifier: operand) {
            print("Operation failed")
        }
    }
    
    private func excecuteFnWith6args(withElements elements: [String]) {
        let equalSign = "="
        let signs     = "'+',  '-', '*', '/'"
        
        var operation = Operation.unary
        let funcName  = elements[1]
        let left      = elements[3]
        let right     = elements[5]
        
        operation.setOperation(withString: elements[4])
        
        guard elements[2] == equalSign else {
            print("Unexpected element: \(elements[2]). Expected: \(equalSign)")
            return
        }
        
        guard operation != .unary else {
            print("Unexpected element: \(elements[4]). Expected: \(signs)")
            return
        }
        
        if !calculator.addFuncWithName(funcName, leftIdentifier: left, rightIdentifier: right, operation: operation) {
            print("Operation failed")
        }
    }
    
    private func executeFn(withElements elements: [String]) {
        if elements.count == 4 {
            excecuteFnWith4args(withElements: elements)
        } else if elements.count == 6 {
            excecuteFnWith6args(withElements: elements)
        } else {
            print("Incorrect 'fn' command")
            print("Try this: fn <identifier1> = <identifier2>")
            print("Or this : fn <identifier1> = <identifier2> <operation> <identifier3>")
        }
    }
    
    private func executeLet(withElements elements: [String]) {
        guard elements.count == 4 else {
            print("Incorrect command")
            print("Try this: let <identifier1> = <identifier2>")
            print("Or this : let <identifier1> = <double>")
            return
        }
        
        let equalSign = "="
        let operand   = elements[3]
        let letName   = elements[1]
        
        guard elements[2] == equalSign else {
            print("Unexpected element: \(elements[2]). Expected: \(equalSign)")
            return
        }
        
        if let toDouble = Double(operand) {
            if !calculator.setVarWithName(letName, value: toDouble) {
                print("Operation failed")
            }
        } else {
            if !calculator.setVarWithName(letName, variableName: operand) {
                print("Operation failed")
            }
        }
    }
    
    private func executeСommand(_ words: [String]) {
        guard words.count > 0 && words.count < 7 else {
            print("Incorrect command")
            return
        }
        
        switch words[0] {
        case "var" where words.count == 2:
            if !calculator.addVarWithName(words[1]) {
                print("Operation failed")
            }
        case "let":
            executeLet(withElements: words)
        case "fn":
            executeFn(withElements: words)
        case "print" where words.count == 2:
            print(calculator.getValueOfIdentifierToString(words[1]))
        case "printvars" where words.count == 1:
            calculator.printAllVars()
        case "printfns"  where words.count == 1:
            calculator.printAllFuncs()
        case "exit":
            return
        default:
            print("Incorrect command")
        }
        
    }
    
    func mainLoop() {
        let exitCommand = "exit"
        var command     = ""
        
        repeat {
            command = readLine() ?? exitCommand
            
            let words = command.components(separatedBy: " ")
            executeСommand(words)
        } while command != exitCommand
    }
}
