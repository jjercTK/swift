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
            if let ivc = (segue.destination as? ImageViewController) {
                let imageName = (sender as? UIButton)?.currentTitle
                ivc.imageURL = DemoURL.NASAImageNamed(imageName: imageName)
                ivc.title = imageName
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("holi")
    }
 

}
