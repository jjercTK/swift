//
//  ViewController.swift
//  Build UI Programtically
//
//  Created by Bob Lee on 3/7/17.
//  Copyright © 2017 BobtheDeveloper. All rights reserved.
//

import UIKit

class FirstVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createButton()
    }
    
    func createButton() {
        
        // Define size of the button
        let buttonSize = CGRect(x: 0,
                                y: screenHeight - 200,
                                width: screenWidth,
                                height: 200)
        
        // Create an instance/object
        let firstButton = UIButton(frame: buttonSize)
        firstButton.backgroundColor = mediumColor
        
        
        // Add firstButton to the root view
        view.addSubview(firstButton)
        
        // Call a function when pressed
        firstButton.addTarget(self,
                              action: #selector(goToNextVC),
                              for: .touchUpInside)
    }
    
    
    func goToNextVC() {
        self.present(SecondVC(), animated: true) { print("Next VC Appeared") }
    }
    
    
    
}
