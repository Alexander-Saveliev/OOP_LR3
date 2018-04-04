//
//  Command.swift
//  LR31
//
//  Created by Marty on 27/03/2018.
//  Copyright © 2018 Marty. All rights reserved.
//

import Foundation

enum Command {
    case info
    case exit
    case engineOn
    case engineOff
    case setGear(Int)
    case setSpeed(Int)
    case undefined
    
    
    mutating func defineCommand(_ str: String) {
        let delimiter = " "
        
        var words = [String]()
        for word in str.components(separatedBy: delimiter) where !word.isEmpty {
            words.append(word)
        }
        
        guard words.count > 0 && words.count <= 2 else {
            self = .undefined
            return
        }

        // set gear or speed
        if words.count == 2, let value = Int(words[1]) {
            switch words[0] {
            case "SetGear":
                self = .setGear(value)
            case "SetSpeed":
                self = .setSpeed(value)
            default:
                self = .undefined
            }
            return
        }

        switch words[0] {
        case "Info":
            self = .info
        case "Exit":
            self = .exit
        case "EngineOn":
            self = .engineOn
        case "EngineOff":
            self = .engineOff
        default:
            self = .undefined
        }
    }
}
