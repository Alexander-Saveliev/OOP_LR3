//
//  ViewController.swift
//  car_simulator
//
//  Created by Marty on 01/04/2018.
//  Copyright © 2018 Marty. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var engineStatusLabel: UILabel!
    @IBOutlet weak var gearStatusLabel: UILabel!
    @IBOutlet weak var speedStatusLabel: UILabel!
    
    @IBOutlet weak var gearStepperValue: UIStepper!
    @IBOutlet weak var speedStepperValue: UIStepper!
    @IBOutlet weak var speedSliderValue: UISlider!
    
    @IBOutlet weak var speedometer: Speedometer!
    
    
    @IBAction func engineButton(_ sender: UIButton) {
        if ferrari.isEngineWork() {
            if ferrari.turnOffEngine() {
                engineStatusLabel.text = "OFF"
                engineStatusLabel.textColor = UIColor.black
            } else {
                engineStatusLabel.textColor = UIColor.red
            }
        } else {
            if ferrari.turnOnEngine() {
                engineStatusLabel.text = "ON"
                engineStatusLabel.textColor = UIColor.black
            } else {
                engineStatusLabel.textColor = UIColor.red
            }
        }
    }
    
    @IBAction func gearButton(_ sender: UIButton) {
        updateUIForGear(sender.tag)
    }
    
    @IBAction func gearStepper(_ sender: UIStepper) {
        updateUIForGear(Int(sender.value))
    }
    
    @IBAction func speedStepper(_ sender: UIStepper) {
        updateUIForSpeed(Int(sender.value))
    }
    
    @IBAction func speedSlider(_ sender: UISlider) {
        updateUIForSpeed(Int(sender.value))
    }
    

    let ferrari = Car()

    private func updateUIForGear(_ gear: Int) {
        var label = ""
        
        if ferrari.setGear(gear) {
            switch gear {
            case -1:
                label = "R"
            case 0:
                label = "N"
            default:
                label = String(gear)
            }
            
            gearStatusLabel.text = label
            gearStatusLabel.textColor = UIColor.black
        } else {
            gearStatusLabel.textColor = UIColor.red
        }
        
        gearStepperValue.value = Double(ferrari.getGear())
    }
    
    private func updateUIForSpeed(_ speed: Int) {
        if ferrari.setSpeed(speed) {
            speedStatusLabel.text = String(speed)
            speedStatusLabel.textColor = UIColor.black
        } else {
            speedStatusLabel.textColor = UIColor.red
        }
        
        speedStepperValue.value  = Double(ferrari.getSpeed())
        speedSliderValue.value   = Float(ferrari.getSpeed())
        speedometer.pointerAngle = CGFloat(ferrari.getSpeed())
    }

}

