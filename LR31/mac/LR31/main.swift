//
//  main.swift
//  LR31
//
//  Created by Marty on 26/03/2018.
//  Copyright © 2018 Marty. All rights reserved.
//

func main() {
    let car = Car()
    
    let welcome = """
    Welcome, my dear user

    You can test this car here
    List of instructions:
        * Info
        * EngineOn
        * EngineOff
        * SetGear <gear>
        * SetSpeed <speed>
        * Exit
    """
    
    print(welcome)
    
    var command = Command.undefined
    
    while true {
        print()
        print("->", terminator: "")
        command.defineCommand(readLine() ?? "Exit")
        
        switch command {
        case .info:
            showInfoOfCar(car)
        case .exit:
            return
        case .engineOn:
            if !car.turnOnEngine() {
                print("I can't turn on engine")
            }
        case .engineOff:
            if !car.turnOffEngine() {
                print("I can't turn off engine")
            }
        case .setGear(let gear):
            if !car.setGear(gear) {
                print("I can't set this gear")
            }
        case .setSpeed(let speed):
            if !car.setSpeed(speed) {
                print("I can't set this speed")
            }
        case .undefined:
            print("Incorrect instruction")
            break
        }
    }
}


main()
