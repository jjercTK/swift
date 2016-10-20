//
//  EmotionsViewController.swift
//  FaceIt
//
//  Created by Juanjo on 10/18/16.
//  Copyright © 2016 Tektonlabs. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {
    
    private let emotionalFaces: Dictionary<String,FacialExpression> = [
        "angry": FacialExpression(eyes: .Closed, mouth: .Frown, eyeBrows: .Furrowed),
        "happy": FacialExpression(eyes: .Open, mouth: .Smile, eyeBrows: .Normal),
        "worried": FacialExpression(eyes: .Open, mouth: .Smirk, eyeBrows: .Relaxed),
        "mischievious": FacialExpression(eyes: .Open, mouth: .Grin, eyeBrows: .Furrowed),
    ]

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationvc = segue.destination
        if let navcon = destinationvc as? UINavigationController {
            destinationvc = navcon.visibleViewController ?? destinationvc
        }
        if let facevc = destinationvc as? FaceViewController {
            if let identifier = segue.identifier {
                if let expression = emotionalFaces[identifier] {
                    facevc.expression = expression
                    if let sendingButton = sender as? UIButton? {
                        facevc.navigationItem.title = sendingButton?.currentTitle
                    }
                }
            }
        }
    }

}
