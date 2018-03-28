//
//  Direction.swift
//  LR31
//
//  Created by Marty on 26/03/2018.
//  Copyright © 2018 Marty. All rights reserved.
//

enum Direction: String {
    case forward
    case backward
    case stand
    
    mutating func setWithSpeed(_ speed: Int, andGear gear: Int) {
        let standSpeed = 0
        let rewGear    = -1
        
        if speed == standSpeed {
            self = .stand
        } else {
            self = gear == rewGear ? .backward : .forward
        }
    }
}
