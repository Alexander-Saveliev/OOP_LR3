//
//  car_simulatorTests.swift
//  car_simulatorTests
//
//  Created by Marty on 01/04/2018.
//  Copyright © 2018 Marty. All rights reserved.
//

import XCTest

class car_simulatorTests: XCTestCase {
    // MARK: - Engine with standing car -
    func testTurnOnEngine() {
        let car = Car()
        
        XCTAssertTrue(car.turnOnEngine())
    }
    
    func testTurnOnWorkingEngine() {
        let car = Car()
        
        XCTAssertTrue(car.turnOnEngine())
        
        XCTAssertFalse(car.turnOnEngine())
    }
    
    func testTurnOffEngine() {
        let car = Car()
        
        XCTAssertTrue(car.turnOnEngine())
        
        XCTAssertTrue(car.turnOffEngine())
    }
    
    func testTurnOffTurnOffEngine() {
        let car = Car()
        
        XCTAssertFalse(car.turnOffEngine())
    }
    
    
    // MARK: - Gear with standing car -
    func testNeutralGearWithTurnOffEngine() {
        let car = Car()
        
        XCTAssertTrue(car.setGear(0))
    }
    
    func testNeutralGearWithWorkingEngine() {
        let car = Car()
        XCTAssertTrue(car.turnOnEngine())
        
        XCTAssertTrue(car.setGear(0))
    }
    
    func testFirstGearWithWorkingEngine() {
        let car = Car()
        XCTAssertTrue(car.turnOnEngine())
        
        XCTAssertTrue(car.setGear(1))
    }
    
    func testFirstGearWithTurnOffEngine() {
        let car = Car()
        
        XCTAssertFalse(car.setGear(1))
    }
    
    func testReverseGearWithTurnOffEngine() {
        let car = Car()
        
        XCTAssertFalse(car.setGear(-1))
    }
    
    func testReverseGearWithWorkingEngine() {
        let car = Car()
        XCTAssertTrue(car.turnOnEngine())
        
        XCTAssertTrue(car.setGear(-1))
    }
    
    func testSecondGearWithWorkingEngine() {
        let car = Car()
        XCTAssertTrue(car.turnOnEngine())
        
        XCTAssertFalse(car.setGear(2))
    }
    
    
    // MARK: - Speed -
    func testSetZeroSpeedWithTurnOffEngine() {
        let car = Car()
        
        XCTAssertFalse(car.setSpeed(0))
    }
    
    func testSetZeroSpeedWithTurnOnEngine() {
        let car = Car()
        XCTAssertTrue(car.turnOnEngine())
        
        XCTAssertTrue(car.setSpeed(0))
    }
    
    func testSetZeroSpeedInNeutral() {
        let car = Car()
        XCTAssertTrue(car.turnOnEngine())
        
        XCTAssertTrue(car.setSpeed(0))
    }
    
    func testSetSpeedOfFirstGearInNeutral() {
        let car = Car()
        XCTAssertTrue(car.turnOnEngine())
        
        XCTAssertFalse(car.setSpeed(15))
    }
    
    func testSetSpeedOfFirstGear() {
        let car = Car()
        XCTAssertTrue(car.turnOnEngine())
        XCTAssertTrue(car.setGear(1))
        
        XCTAssertTrue(car.setSpeed(15))
        XCTAssertTrue(car.setSpeed(10))
        XCTAssertTrue(car.setSpeed(0))
        XCTAssertTrue(car.setSpeed(30))
        XCTAssertFalse(car.setSpeed(31))
        XCTAssertFalse(car.setSpeed(-1))
    }
    
    func testSetSpeedOfSecondGear() {
        let car = Car()
        XCTAssertTrue(car.turnOnEngine())
        XCTAssertTrue(car.setGear(1))
        XCTAssertTrue(car.setSpeed(20))
        XCTAssertTrue(car.setGear(2))
        
        XCTAssertTrue(car.setSpeed(20))
        XCTAssertTrue(car.setSpeed(25))
        XCTAssertTrue(car.setSpeed(50))
        XCTAssertTrue(car.setSpeed(20))
        XCTAssertFalse(car.setSpeed(51))
        XCTAssertFalse(car.setSpeed(19))
        XCTAssertFalse(car.setSpeed(0))
    }
    
    func testSetSpeedOfFifthGear() {
        let car = Car()
        XCTAssertTrue(car.turnOnEngine())
        XCTAssertTrue(car.setGear(1))
        XCTAssertTrue(car.setSpeed(20))
        XCTAssertTrue(car.setGear(2))
        XCTAssertTrue(car.setSpeed(50))
        XCTAssertTrue(car.setGear(5))
        
        XCTAssertTrue(car.setSpeed(50))
        XCTAssertTrue(car.setSpeed(70))
        XCTAssertTrue(car.setSpeed(150))
        XCTAssertTrue(car.setSpeed(120))
        XCTAssertFalse(car.setSpeed(151))
        XCTAssertFalse(car.setSpeed(49))
        XCTAssertFalse(car.setSpeed(0))
    }
    
    func testSetSpeedOfReverseGear() {
        let car = Car()
        XCTAssertTrue(car.turnOnEngine())
        XCTAssertTrue(car.setGear(-1))
        
        XCTAssertTrue(car.setSpeed(20))
        XCTAssertTrue(car.setSpeed(10))
        XCTAssertTrue(car.setSpeed(0))
        XCTAssertTrue(car.setSpeed(7))
        XCTAssertFalse(car.setSpeed(-1))
        XCTAssertFalse(car.setSpeed(21))
        XCTAssertFalse(car.setSpeed(50))
    }
    
    // MARK: - Gear -
    func testFirstGear() {
        let car = Car()
        XCTAssertTrue(car.turnOnEngine())
        
        XCTAssertTrue(car.setGear(1))
        XCTAssertTrue(car.setGear(0))
        XCTAssertTrue(car.setGear(1))
        
        XCTAssertTrue(car.setSpeed(1))
        XCTAssertTrue(car.setGear(0))
    }
    
    func testSecondGear() {
        let car = Car()
        XCTAssertTrue(car.turnOnEngine())
        XCTAssertTrue(car.setGear(1))
        
        XCTAssertFalse(car.setGear(2))
        XCTAssertTrue(car.setSpeed(30))
        
        XCTAssertTrue(car.setGear(2))
        XCTAssertTrue(car.setGear(1))
        
        XCTAssertTrue(car.setGear(2))
        XCTAssertTrue(car.setSpeed(50))
        
        XCTAssertFalse(car.setGear(1))
        
        XCTAssertTrue(car.setGear(0))
    }
    
    func testReverseSpeed() {
        let car = Car()
        XCTAssertTrue(car.turnOnEngine())
        
        XCTAssertTrue(car.setGear(-1))
        XCTAssertTrue(car.setSpeed(10))
        XCTAssertTrue(car.setGear(-1))
        XCTAssertTrue(car.setGear(0))
        XCTAssertFalse(car.setGear(-1))
        XCTAssertFalse(car.setGear(1))
    }
}
