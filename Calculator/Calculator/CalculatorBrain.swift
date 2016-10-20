//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Juan José Ramírez Calderón on 10/9/16.
//  Copyright © 2016 The Toby. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    // MARK: Properties
    
    internal var result: Double {
        get{
            return accumulator
        }
    }
    
    private var accumulator = 0.0
    private var internalProgram = [AnyObject]()
    
    typealias PropertyList = AnyObject
    internal var program: PropertyList {
        get {
            return internalProgram as CalculatorBrain.PropertyList
        }
        set {
            clear()
            if let arrayOfOps = newValue as? [AnyObject] {
                for op in arrayOfOps {
                    if let operand = op as? Double {
                        setOperand(operand: operand)
                    } else if let operation = op as? String {
                        performOperation(symbol: operation)
                    }
                }
            }
        }
    }
    
    func clear(){
        accumulator = 0.0
        pending = nil
        internalProgram.removeAll()
    }
    
    private var operations: Dictionary<String,Operation> = [
        "C" : Operation.Constant(0.0),
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "√" : Operation.UnaryOperation(sqrt),
        "sin" : Operation.UnaryOperation(sin),
        "cos" : Operation.UnaryOperation(cos),
        "*": Operation.BinaryOperation({$0 * $1}),
        "+": Operation.BinaryOperation({$0 + $1}),
        "-": Operation.BinaryOperation({$0 - $1}),
        "/": Operation.BinaryOperation({$0 / $1}),
        "tan": Operation.UnaryOperation(tan),
        "^2": Operation.UnaryOperation({pow($0,2)}),
        "±": Operation.UnaryOperation({-$0}),
        "=": Operation.Equals
    ]
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double,Double) -> Double)
        case Equals
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction: ((Double,Double) -> Double)
        var firstOperand: Double
    }
    
    // MARK: Methods
    
    internal func setOperand(operand: Double){
        accumulator = operand
        internalProgram.append(operand as AnyObject)
    }
    
    internal func performOperation(symbol: String){
        internalProgram.append(symbol as AnyObject)
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let foo):
                accumulator = foo(accumulator)
            case .BinaryOperation(let foo):
                executeBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: foo,firstOperand: accumulator)
            case .Equals:
                executeBinaryOperation()
            }
        }
    }
    
    private func executeBinaryOperation(){
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    
}
