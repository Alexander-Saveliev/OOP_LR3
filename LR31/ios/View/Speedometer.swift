//
//  Speedometer.swift
//  car_simulator
//
//  Created by Marty on 01/04/2018.
//  Copyright © 2018 Marty. All rights reserved.
//

import UIKit

@IBDesignable class Speedometer: UILabel {
    @IBInspectable var notichSize: CGFloat   = 1.0
    @IBInspectable var notichColor: UIColor  = UIColor.black
    @IBInspectable var notichRadius: CGFloat = 100
    @IBInspectable var notichLength: CGFloat = 10
    @IBInspectable var notichNumber: Int     = 36
    
    
    @IBInspectable var pointerColor: UIColor  = UIColor.orange
    @IBInspectable var pointerLength: CGFloat = 95
    @IBInspectable var pointerSize: CGFloat   = 2
    @IBInspectable var pointerAngle: CGFloat  = 0 {
        didSet {
            // redraw
            setNeedsDisplay()
        }
    }
    
    
    @IBInspectable var contrastZero: Int       = 3
    @IBInspectable var contrastStep: Int       = 6
    @IBInspectable var contrastColor: UIColor  = UIColor.orange
    @IBInspectable var contrastLength: CGFloat = 12
    @IBInspectable var contrastSize: CGFloat   = 2
    
    
    @IBInspectable var extraContrastZero: Int       = 0
    @IBInspectable var extraContrastStep: Int       = 6
    @IBInspectable var extraContrastColor: UIColor  = UIColor.red
    @IBInspectable var extraContrastLength: CGFloat = 15
    @IBInspectable var extraContrastSize: CGFloat   = 3
    
    
    func drawOneLine(startX: CGFloat, startY: CGFloat, endX: CGFloat, endY: CGFloat, color: UIColor, size: CGFloat) {
        let linePath = UIBezierPath()
        
        linePath.lineWidth = size
        
        linePath.move(to: CGPoint(x: startX, y: startY) )
        linePath.addLine(to: CGPoint(x: endX, y: endY) )
        
        linePath.close()
        
        color.setStroke()
        linePath.stroke()
    }
    
    
    func drawScale() {
        let centerX     = bounds.width * 0.5
        let centerY     = bounds.height * 0.9
        let PI          = Double.pi
        
        for i in 0...notichNumber {
            let alpha    = CGFloat( Double(i) * PI / Double(notichNumber) )
            let cosAlpha = cos(alpha)
            let sinAlpha = sin(alpha)
            
            let x0 = centerX - notichRadius * cosAlpha
            let y0 = centerY - notichRadius * sinAlpha
            
            var x1 = centerX - (notichRadius + notichLength) * cosAlpha
            var y1 = centerY - (notichRadius + notichLength) * sinAlpha
            
            var color = notichColor
            var size  = notichSize
            
            if extraContrastStep != 0 && (i - extraContrastZero) % extraContrastStep == 0 {
                // contrast notich
                x1    = centerX - (notichRadius + extraContrastLength) * cosAlpha
                y1    = centerY - (notichRadius + extraContrastLength) * sinAlpha
                color = extraContrastColor
                size  = extraContrastSize
            } else if contrastStep != 0 && (i - contrastZero) % contrastStep == 0 {
                // extra contrast notich
                x1    = centerX - (notichRadius + contrastLength) * cosAlpha
                y1    = centerY - (notichRadius + contrastLength) * sinAlpha
                color = contrastColor
                size  = contrastSize
            }
            
            drawOneLine(startX: x0, startY: y0, endX: x1, endY: y1, color: color, size: size)
        }
    }
    
    
    func drawPointer() {
        let PI          = Double.pi
        let centerX     = bounds.width * 0.5
        let centerY     = bounds.height * 0.9
        
        let alpha    = CGFloat( Double(pointerAngle) * PI / 180.0)
        let cosAlpha = cos(alpha)
        let sinAlpha = sin(alpha)
        
        let x1 = centerX - (pointerLength) * cosAlpha
        let y1 = centerY - (pointerLength) * sinAlpha
        
        drawOneLine(startX: centerX, startY: centerY, endX: x1, endY: y1, color: pointerColor, size: pointerSize)
    }
    
    
    override func draw(_ rect: CGRect) {
        drawScale()
        drawPointer()
    }
}
