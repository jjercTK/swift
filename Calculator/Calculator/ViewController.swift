//
//  ViewController.swift
//  Calculator
//
//  Created by Juan José Ramírez Calderón on 10/8/16.
//  Copyright © 2016 The Toby. All rights reserved.
//

import UIKit

var calculatorCount = 0

class ViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatorCount += 1
        print("Load up a new Calculator (count = \(calculatorCount))")
        brain.addUnaryOperation(symbol: "Z") { [unowned me = self] in
            me.display.textColor = UIColor.red
            return sqrt($0)
        }
    }
    
    deinit { // this method gets called just before an object leaves the heap
        calculatorCount -= 1
        print("Calculator left the heap (count = \(calculatorCount))")
    }

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

