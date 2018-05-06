//
//  Operation.swift
//  LR32
//
//  Created by Marty on 06/05/2018.
//  Copyright © 2018 Marty. All rights reserved.
//

enum Operation {
    case plus
    case minus
    case mult
    case div
    case unary
    
    func calculate(left: Double?, right: Double?) -> Double? {
        if self == .unary {
            return left
        } else {
            guard let leftOperand = left, let rightOperand = right else {
                return nil
            }
            
            switch self {
            case .plus:
                return leftOperand + rightOperand
            case .minus:
                return leftOperand - rightOperand
            case .mult:
                return leftOperand * rightOperand
            case .div:
                return leftOperand / rightOperand
            default:
                return nil
            }
        }
    }
    
    mutating func setOperation(withString str: String) {
        switch str {
        case "+":
            self = .plus
        case "-":
            self = .minus
        case "*":
            self = .mult
        case "/":
            self = .div
        default:
            self = .unary
        }
    }
}
