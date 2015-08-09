//
//  ViewController.swift
//  calculator
//
//  Created by 王利祥 on 15/2/4.
//  Copyright (c) 2015年 王利祥. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    var userIsInTheMiddleTypingNum = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleTypingNum
        {
            display.text=display.text!+digit
        }else
        {
            display.text=digit
            userIsInTheMiddleTypingNum=true
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func displayAns() {
        userIsInTheMiddleTypingNum=false
        operandStack.append(displayValue)

    }
    var operation = "nil"
    
    @IBAction func operate(sender: UIButton) {
        displayAns()
        switch operation{
        case "nil": displayAns()
        case "+": performOperation({$0+$1})
        case "−": performOperation({$1-$0})
        case "×": performOperation({$0*$1})
        case "÷": performOperation({$1/$0})
        case "√": performOperation({sqrt($0)})
        case "1/x":performOperation({1/$0})
        case "←": break
        case "=": break
        case "AC": initvar()
        default: break
        }
        operation=sender.currentTitle!

    }
    func initvar()
    {
        operandStack.removeAll(keepCapacity: true)
        operation="nil"
        displayValue=0
    }
    
    func performOperation(operation:(Double,Double)->Double)
    {
        if operandStack.count>=2
        {
            displayValue=operation(operandStack.removeLast(),operandStack.removeLast())
        
        }
        displayAns()
    }
    func performOperation(operation:Double->Double)
    {
        if operandStack.count>=1
        {
            displayValue=operation(operandStack.removeLast())
        }
        displayAns()
    }

    var displayValue :Double{
        set
        {
            display.text = "\(newValue)"
            userIsInTheMiddleTypingNum = false
        }
        get
        {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
    }

}

