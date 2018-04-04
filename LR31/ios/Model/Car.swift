//
//  Car.swift
//  LR31
//
//  Created by Marty on 26/03/2018.
//  Copyright © 2018 Marty. All rights reserved.
//

class Car {
    private var isEngineOn = false
    private var direction  = Direction.stand
    private var speed      = 0
    private var gear       = 0
    
    private var possibleSpeedForGear = [
        -1 : 0...20,
        0  : 0...299_792_458,
        1  : 0...30,
        2  : 20...50,
        3  : 30...60,
        4  : 40...90,
        5  : 50...150
    ]
    
    
    func turnOnEngine() -> Bool {
        let standSpeed = 0
        let standGear  = 0
        
        guard !isEngineOn && speed == standSpeed && gear == standGear  else {
            return false
        }
        
        isEngineOn = true
        return true
    }
    
    
    func turnOffEngine() -> Bool {
        let standGear  = 0
        
        guard isEngineOn && direction == .stand && gear == standGear  else {
            return false
        }
        
        isEngineOn = false
        return true
    }
    
    
    func setGear(_ gear: Int) -> Bool {
        let revGear = -1
        let maxGear =  5
        let standGear  = 0
        
        // set self gear
        guard gear != self.gear else {
            return true
        }
        
        guard isEngineOn || gear == standGear else {
            return false
        }
        
        guard gear >= revGear && gear <= maxGear && possibleSpeedForGear[gear]!.contains(speed) else {
            return false
        }

        // attempt to set the transmission forward, moving backwards
        if direction == .backward && gear != standGear {
            return false
        }
        
        // attempt to set the reverse gear, moving forward
        if direction == .forward && gear == revGear {
            return false
        }
        
        self.gear = gear
        return true
    }
    
    
    func setSpeed(_ speed: Int) -> Bool {
        let neutralTransmission = 0
        
        guard isEngineOn else {
            return false
        }
        
        guard possibleSpeedForGear[gear]!.contains(speed) else {
            return false
        }
        
        // attempt to accelerate in neutral transmission
        if gear == neutralTransmission && speed > self.speed {
            return false
        }
        
        self.speed = speed
        direction.setWithSpeed(speed, andGear: gear)
        return true
    }
    
    
    func isEngineWork() -> Bool {
        return isEngineOn
    }
    
    
    func getDirection() -> Direction {
        return direction
    }
    
    
    func getSpeed() -> Int {
        return speed
    }
    
    
    func getGear() -> Int {
        return gear
    }
}
