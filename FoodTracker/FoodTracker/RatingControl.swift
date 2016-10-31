//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Juanjo on 10/5/16.
//  Copyright © 2016 Tektonlabs. All rights reserved.
//

import UIKit

@IBDesignable
class RatingControl: UIView {
    // MARK: Properties
    var rating = 0 {
        didSet {
            //setNeedsLayout()
            updateButtonSelectionStates()
        }
    }
    var ratingButtons = [UIButton]()
    let spacing = 5
    let starCount = 5
    //let buttonSize = 44 <- this was added to the view as a constraint
    
    @IBInspectable var emptyImage: UIImage! = UIImage(named: "emptyStar") {
        didSet {
            for button in ratingButtons {
                button.setImage(emptyImage, for: .normal)
            }
        }
    }
    
    @IBInspectable var filledImage: UIImage! = UIImage(named: "filledStar") {
        didSet {
            for button in ratingButtons {
                button.setImage(filledImage, for: .selected)
                button.setImage(filledImage, for: [.selected, .highlighted])
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup(){
        for _ in 0..<starCount {
            let button = UIButton()
            //button.backgroundColor = UIColor.red
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped), for: .touchDown)
            //button.setImage(emptyImage, for: .normal)
            //button.setImage(filledImage, for: .selected)
            //button.setImage(filledImage, for: [.selected, .highlighted])
            button.adjustsImageWhenHighlighted = false
            ratingButtons += [button]
            addSubview(button)
        }
    }
    
    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override var intrinsicContentSize : CGSize {
        let buttonSize = Int(frame.size.height)
        let width = (buttonSize * starCount) + (spacing * (starCount - 1))
        
        return CGSize(width: width, height: buttonSize)
    }
    
    override func layoutSubviews() {
        let buttonSize = Int(frame.size.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        for (index, button) in ratingButtons.enumerated() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
    }
    
    // MARK: Button Action
    func ratingButtonTapped(button: UIButton) {
        rating = ratingButtons.index(of: button)! + 1
    }
    
    func updateButtonSelectionStates() {
        for (index,button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
    }

}
