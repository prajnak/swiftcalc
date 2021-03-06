//
//  ViewController.swift
//  Calculator
//
//  Created by Prajna Kandarpa on 2015-06-16.
//  Copyright (c) 2015 Prajna Kandarpa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // we use an "!" here isntead of a ? because this property gets 
    // set when the app is launched, and if we'd created the property using \
    // <display: UILabel?> , we'd have to unwrap display everytime we use it
    // like <display!.text> etc. using<display: UILabel!> unwraps the label automatically and doesn't require us to use ! everytime we access the 
    // variable. This also sets the value to nil.
    // Implicitly unwrapped Optional uses "!"
    @IBOutlet weak var display: UILabel!
    var userIsInTheMiddleOfTypingText: Bool = false
    var brain = CalculatorBrain()
    
    //if this method had a return type, it would look like
    // func appendDigit(sender: UIButton) -> Double {
    @IBAction func appendDigit(sender: UIButton) {
        //let is same as var, but its a constant
        // so we immediately assign the digit of 
        // the button pressed to a constant
        
        //all variables have a type in Swift -- strongly typed
        // digit is an Optional that can be a String
        // because the return value of UIButton.currentTitle is
        // an Optional String ( String? )
        
        //use an exclamation point at the end to unwrap an Optional. Need to be
        //careful though, because unwrapping a Nil optional can cause a crash.
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingText {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingText = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingText {
            enterPressed()
        }
        // the following switch case statement passes a function as 
        // an argument to another function. since swift has strong type
        // inference, the argument types don't need to be spcified for op1 and op2.
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }
    
    @IBAction func enterPressed() {
        userIsInTheMiddleOfTypingText = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }
    
    // Computed Properties - use curly brances isntead of an
    // assignment operator. these propertuies get computed continuously upon
    // change. The set block has a magic variable newValue that is 
    // the value that displayValue is assigned to.
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingText = false
        }
    }
}

