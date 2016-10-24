//
//  CassiniViewController.swift
//  Cassini
//
//  Created by Juanjo on 10/24/16.
//  Copyright © 2016 Tektonlabs. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController {
    
    private struct Storyboard {
        static let ShowImageSegue = "Show image"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.ShowImageSegue {
            if let ivc = (segue.destination.content as? ImageViewController) {
                let imageName = (sender as? UIButton)?.currentTitle
                ivc.imageURL = DemoURL.NASAImageNamed(imageName: imageName)
                ivc.title = imageName
            }
        }
    }
}

extension UIViewController {
    var content: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        } else {
            return self
        }
    }
}



