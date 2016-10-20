//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Juanjo on 10/5/16.
//  Copyright © 2016 Tektonlabs. All rights reserved.
//

import UIKit

class RatingControl: UIView {
    // MARK: Properties
    var rating = 0
    var ratingButtons = [UIButton]()
    let spacing = 5
    let starCount = 5
    let buttonSize = 44
    
    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        for _ in 0..<starCount {
            let button = UIButton()
            button.backgroundColor = UIColor.red
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped), for: .touchDown)
            ratingButtons += [button]
            addSubview(button)
        }
    }
    
    override var intrinsicContentSize : CGSize {
        let width = (buttonSize * starCount) + (spacing * (starCount - 1))
        return CGSize(width: width, height: buttonSize)
    }
    
    override func layoutSubviews() {
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        for (index, button) in ratingButtons.enumerated() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
    }
    
    // MARK: Button Action
    func ratingButtonTapped(button: UIButton) {
        print("Button pressed 👍")
    }

}
