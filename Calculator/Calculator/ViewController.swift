//
//  ViewController.swift
//  Calculator
//
//  Created by Juan José Ramírez Calderón on 10/8/16.
//  Copyright © 2016 The Toby. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet private weak var display: UILabel!
    private var userIsInTheMiddleOfTypying = false
    private var brain = CalculatorBrain()
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    // MARK: Actions

    @IBAction private func touchDigit(_ sender: UIButton) {
        if userIsInTheMiddleOfTypying {
            display.text! += sender.currentTitle!
        } else {
            display.text! = sender.currentTitle!
        }
        userIsInTheMiddleOfTypying = true
    }
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTypying {
            brain.setOperand(operand: displayValue)
            userIsInTheMiddleOfTypying = false
        }
        if let mathematicalSymbol = sender.currentTitle {
           brain.performOperation(symbol: mathematicalSymbol)
        }
        displayValue = brain.result
    }
    
    private var program:AnyObject?
    
    @IBAction func save() {
        program = brain.program
    }
    
    @IBAction func load() {
        if program != nil {
           brain.program = program!
            displayValue = brain.result
        }
    }
    

}

