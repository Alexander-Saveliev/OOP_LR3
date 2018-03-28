//
//  car_tools.swift
//  LR31
//
//  Created by Marty on 27/03/2018.
//  Copyright © 2018 Marty. All rights reserved.
//

func showInfoOfCar(_ car: Car) {
    let engineStatus = car.isEngineWork() ? "on" : "off"
    let direction    = car.getDirection().rawValue
    let speed        = car.getSpeed()
    let gear         = car.getGear()
    
    
    print("Engine status: ", engineStatus)
    print("Direction:     ", direction)
    print("Speed:         ", speed)
    print("Gear:          ", gear)
}
