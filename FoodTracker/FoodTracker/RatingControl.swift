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
    
    @IBInspectable var rating: Int = 0 {
        didSet {
            //setNeedsLayout()
            updateButtonSelectionStates()
        }
    }
    var ratingButtons = [UIButton]()
    @IBInspectable var spacing: Int = 5 {
        didSet {
            setNeedsLayout()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            addRatingButtons()
            updateButtonSelectionStates()
            setNeedsLayout()
            invalidateIntrinsicContentSize() //re-calculate intrinsicContentSize
        }
    }
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
            addImages()
        }
    }

    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addRatingButtons()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addRatingButtons()
    }
    
    // MARK: Override Methods
    
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
    
    // MARK: Methods
    
    func updateButtonSelectionStates() {
        for (index,button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
    }
    
    func addImages(){
        for button in ratingButtons {
            button.setImage(emptyImage, for: .normal)
            button.setImage(filledImage, for: .selected)
            button.setImage(filledImage, for: [.selected, .highlighted])
        }
    }
    
    func addRatingButtons(){
        for button in ratingButtons {
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
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
        addImages()
    }

}
