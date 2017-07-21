//
//  ViewController.swift
//  SimpleCounter
//
//  Created by Juanjo on 10/19/16.
//  Copyright © 2016 Tektonlabs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    private var timer: Timer!
   
    private var counter: Int {
        set {
            display!.text = String(newValue)
        }
        get {
            return Int(display!.text!)!
        }
    }
    
    private var delay: Float = 0 {
        didSet {
            if (delay > 1){
                counter += 1
                delay = 0
            }
        }
    }

    @IBAction func OnHold(_ recognizer: UILongPressGestureRecognizer) {
        switch recognizer.state {
        case .began:
            print("inicio")
            timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(incrementDelay), userInfo: nil, repeats: true)
        case .ended:
            print("fin")
            timer.invalidate()
        default:
            print("otro")
            break;
        }
    }

    @IBAction func resetCounter(_ sender: UIButton) {
        counter = 0
    }
    
    @IBAction func incrementCounter(_ sender: UIButton) {
        counter += 1
    }
    
    @IBAction func incrementInside() {
        incrementDelay()
    }
    
    func incrementDelay(){
        delay += 0.1
    }
}

