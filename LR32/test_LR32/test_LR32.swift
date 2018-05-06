//
//  test_LR32.swift
//  test_LR32
//
//  Created by Marty on 06/05/2018.
//  Copyright © 2018 Marty. All rights reserved.
//

import XCTest

class test_LR32: XCTestCase {
    
    // MARK: - Var -
    func testDoubleIncludingVar() {
        let calculator = Calculator()
        
        XCTAssertTrue(calculator.addVarWithName("a"))
        XCTAssertFalse(calculator.addVarWithName("a"))
    }
    
    func testGetUnknownVar() {
        let calculator = Calculator()

        XCTAssertEqual(calculator.getValueOfIdentifierToString("a"), "unknown identifier")
    }

    func testGetUndefinedVar() {
        let calculator = Calculator()

        XCTAssertTrue(calculator.addVarWithName("a"))
        XCTAssertEqual(calculator.getValueOfIdentifierToString("a"), "nan")
    }

    func testGetExistingVar() {
        let calculator = Calculator()

        calculator.setVarWithName("a", value: 2.32)
        XCTAssertEqual(calculator.getValueOfIdentifierToString("a"), "2.32")
    }

    func testGetExistingVarRoundedUp() {
        let calculator = Calculator()

        calculator.setVarWithName("a", value: 2.329)
        XCTAssertEqual(calculator.getValueOfIdentifierToString("a"), "2.33")
    }

    func testGetExistingVarRoundedDown() {
        let calculator = Calculator()

        calculator.setVarWithName("a", value: 2.324)
        XCTAssertEqual(calculator.getValueOfIdentifierToString("a"), "2.32")
    }

    func testVarIsEqualToNotExistVar() {
        let calculator = Calculator()

        calculator.setVarWithName("a", value: 2.324)
        XCTAssertFalse(calculator.setVarWithName("b", variableName: "c"))
    }

    func testVarIsEqualToVar() {
        let calculator = Calculator()

        calculator.setVarWithName("a", value: 2.324)
        XCTAssertTrue(calculator.setVarWithName("b", variableName: "a"))

        calculator.setVarWithName("a", value: 0)
        XCTAssertEqual(calculator.getValueOfIdentifierToString("a"), "0.00")
        XCTAssertEqual(calculator.getValueOfIdentifierToString("b"), "2.32")
    }
    
    
    // MARK: - Function -
    func testFuncWithOutdoarVar() {
        let calculator = Calculator()
        let variable: Identifier = Var(withName: "abc", andValue: 5)
        XCTAssertFalse(calculator.addFuncWithName("a", equalToIdentifier: variable))
    }
    
    func testFuncWithIndoarVar() {
        let calculator = Calculator()
        let b = Var(withName: "b", andValue: 10)
        XCTAssertTrue(calculator.addVariable(b))
        XCTAssertTrue(calculator.addFuncWithName("a", equalToIdentifier: b))
    }
    
    func testFuncWithIndoarVarWithTheSameName() {
        let calculator = Calculator()
        let b = Var(withName: "b", andValue: 10)
        XCTAssertTrue(calculator.addVariable(b))
        XCTAssertFalse(calculator.addFuncWithName("b", equalToIdentifier: b))
    }
    
    func testFuncCalculationWithOneElement() {
        let calculator = Calculator()
        let a = Var(withName: "a", andValue: 10)
        XCTAssertTrue(calculator.addVariable(a))
        XCTAssertTrue(calculator.addFuncWithName("same", equalToIdentifier: a))
        XCTAssertEqual(calculator.getValueOfIdentifierToString("same"), "10.00")
    }
    
    func testFuncCalculationWithTwoElement() {
        let calculator = Calculator()
        let a = Var(withName: "a", andValue: 10)
        XCTAssertTrue(calculator.addVariable(a))
        let b = Var(withName: "b", andValue: 20)
        XCTAssertTrue(calculator.addVariable(b))
        XCTAssertTrue(calculator.addFuncWithName("plus", leftIdentifier: a, rightIdentifier: b, operation: Operation.plus))
        XCTAssertEqual(calculator.getValueOfIdentifierToString("plus"), "30.00")
    }
    
    func testFuncCalculationWithTwoElementChanged() {
        let calculator = Calculator()
        let a = Var(withName: "a", andValue: 10)
        XCTAssertTrue(calculator.addVariable(a))
        let b = Var(withName: "b", andValue: 20)
        XCTAssertTrue(calculator.addVariable(b))
        XCTAssertTrue(calculator.addFuncWithName("plus", leftIdentifier: a, rightIdentifier: b, operation: Operation.plus))
        XCTAssertEqual(calculator.getValueOfIdentifierToString("plus"), "30.00")
        XCTAssertTrue(calculator.setVarWithName("a", value: 0))
        XCTAssertEqual(calculator.getValueOfIdentifierToString("plus"), "20.00")
    }
    
    func testCalculateRadius() {
        let calculator = Calculator()
        
        XCTAssertTrue(calculator.addVarWithName("radius"))
        XCTAssertTrue(calculator.setVarWithName("pi", value: 3.14159265))
        XCTAssertTrue(calculator.addFuncWithName("radiusSquared", leftIdentifier: "radius", rightIdentifier: "radius", operation: .mult))
        XCTAssertTrue(calculator.addFuncWithName("circleArea", leftIdentifier: "pi", rightIdentifier: "radiusSquared", operation: .mult))
        
        XCTAssertTrue(calculator.setVarWithName("radius", value: 10))
        
        XCTAssertEqual(calculator.getValueOfIdentifierToString("circleArea"), "314.16")
        
        XCTAssertTrue(calculator.setVarWithName("circle10Area", variableName: "circleArea"))
        
        XCTAssertTrue(calculator.setVarWithName("radius", value: 20))
        XCTAssertEqual(calculator.getValueOfIdentifierToString("circleArea"), "1256.64")
        XCTAssertEqual(calculator.getValueOfIdentifierToString("circle10Area"), "314.16")
    }
    
    
    /*
     
     // use it test in main func to check lazy calculation
     
     // add 'print("new calculating for \(self.getName())")' in Function class in calculate func when value recalculating
     let calculator = Calculator()
     
     
     calculator.setVarWithName("v0", value: 0)
     calculator.setVarWithName("v1", value: 1)
     
     calculator.addFuncWithName("fib0", equalToIdentifier: "v0")
     calculator.addFuncWithName("fib1", equalToIdentifier: "v1")
     
     calculator.addFuncWithName("fib2", leftIdentifier: "fib0", rightIdentifier: "fib1", operation: .plus)
     calculator.addFuncWithName("fib3", leftIdentifier: "fib1", rightIdentifier: "fib2", operation: .plus)
     calculator.addFuncWithName("fib4", leftIdentifier: "fib2", rightIdentifier: "fib3", operation: .plus)
     calculator.addFuncWithName("fib5", leftIdentifier: "fib3", rightIdentifier: "fib4", operation: .plus)
     calculator.addFuncWithName("fib6", leftIdentifier: "fib4", rightIdentifier: "fib5", operation: .plus)
     calculator.addFuncWithName("fib7", leftIdentifier: "fib5", rightIdentifier: "fib6", operation: .plus)
     calculator.addFuncWithName("fib8", leftIdentifier: "fib6", rightIdentifier: "fib7", operation: .plus)
     
     calculator.getValueOfIdentifierToString("fib0")
     calculator.getValueOfIdentifierToString("fib1")
     calculator.getValueOfIdentifierToString("fib2")
     calculator.getValueOfIdentifierToString("fib3")
     calculator.getValueOfIdentifierToString("fib4")
     calculator.getValueOfIdentifierToString("fib5")
     calculator.getValueOfIdentifierToString("fib6")
     calculator.getValueOfIdentifierToString("fib7")
     calculator.getValueOfIdentifierToString("fib8")
     
     print("=== all calculated ===")
     calculator.getValueOfIdentifierToString("fib8")
     
     print("=== update v0 & v1 ===")
     calculator.setVarWithName("v0", value: 0)
     calculator.setVarWithName("v1", value: 0)
     calculator.getValueOfIdentifierToString("fib8")
     
     print("=== all calculated again ===")
     calculator.getValueOfIdentifierToString("fib8")
 
    */
    
    func testFib() {
        let calculator = Calculator()
        
        XCTAssertTrue(calculator.setVarWithName("v0", value: 0))
        XCTAssertTrue(calculator.setVarWithName("v1", value: 1))
        
        XCTAssertTrue(calculator.addFuncWithName("fib0", equalToIdentifier: "v0"))
        XCTAssertTrue(calculator.addFuncWithName("fib1", equalToIdentifier: "v1"))
        
        XCTAssertTrue(calculator.addFuncWithName("fib2", leftIdentifier: "fib0", rightIdentifier: "fib1", operation: .plus))
        XCTAssertTrue(calculator.addFuncWithName("fib3", leftIdentifier: "fib1", rightIdentifier: "fib2", operation: .plus))
        XCTAssertTrue(calculator.addFuncWithName("fib4", leftIdentifier: "fib2", rightIdentifier: "fib3", operation: .plus))
        XCTAssertTrue(calculator.addFuncWithName("fib5", leftIdentifier: "fib3", rightIdentifier: "fib4", operation: .plus))
        XCTAssertTrue(calculator.addFuncWithName("fib6", leftIdentifier: "fib4", rightIdentifier: "fib5", operation: .plus))
        XCTAssertTrue(calculator.addFuncWithName("fib7", leftIdentifier: "fib5", rightIdentifier: "fib6", operation: .plus))
        XCTAssertTrue(calculator.addFuncWithName("fib8", leftIdentifier: "fib6", rightIdentifier: "fib7", operation: .plus))
        
        XCTAssertEqual(calculator.getValueOfIdentifierToString("fib0"), "0.00")
        XCTAssertEqual(calculator.getValueOfIdentifierToString("fib1"), "1.00")
        XCTAssertEqual(calculator.getValueOfIdentifierToString("fib2"), "1.00")
        XCTAssertEqual(calculator.getValueOfIdentifierToString("fib3"), "2.00")
        XCTAssertEqual(calculator.getValueOfIdentifierToString("fib4"), "3.00")
        XCTAssertEqual(calculator.getValueOfIdentifierToString("fib5"), "5.00")
        XCTAssertEqual(calculator.getValueOfIdentifierToString("fib6"), "8.00")
        XCTAssertEqual(calculator.getValueOfIdentifierToString("fib7"), "13.00")
        XCTAssertEqual(calculator.getValueOfIdentifierToString("fib8"), "21.00")
    }
    
    
    
    
}
