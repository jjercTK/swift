//
//  ViewController.swift
//  ControlEvents
//
//  Created by Juanjo on 10/20/16.
//  Copyright © 2016 Tektonlabs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private var actions: Dictionary<String,Int> = [
        "touchDown": 0,
        "touchDownRepeat": 0,
        "touchDragInside": 0,
        "touchDragOutside": 0,
        "touchDragEnter": 0,
        "touchDragExit": 0,
        "touchUpInside": 0,
        "touchUpOutside": 0,
        "touchCancel": 0,
        "primaryActionTriggered": 0
    ]
    
    private func print2(_ action: String) {
        print("\(action)  \(actions[action]!)")
        actions[action] = actions[action]! + 1
    }
    
    

    @IBAction func touchDown(_ sender: UIButton) {
        print2("touchDown")
    }

    @IBAction func touchDownRepeat(_ sender: UIButton) {
        print2("touchDownRepeat")
    }
    
    @IBAction func touchDragInside(_ sender: AnyObject) {
        print2("touchDragInside")
    }
    
    @IBAction func touchDragOutside(_ sender: UIButton) {
        print2("touchDragOutside")
    }
    
    @IBAction func touchDragEnter(_ sender: UIButton) {
        print2("touchDragEnter")
    }
    
    @IBAction func touchDragExit() {
        print2("touchDragExit")
    }
    
    @IBAction func touchUpInside(_ sender: UIButton) {
        print2("touchUpInside")
    }
    
    @IBAction func touchUpOutside(_ sender: UIButton) {
        print2("touchUpOutside")
    }
    
    @IBAction func touchCancel(_ sender: UIButton) {
        print2("touchCancel")
    }
    
    @IBAction func primaryActionTriggered(_ sender: UIButton) {
        print2("primaryActionTriggered")
    }
    
}

