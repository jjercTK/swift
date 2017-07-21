//
//  CassiniViewController.swift
//  Cassini
//
//  Created by Juanjo on 10/24/16.
//  Copyright © 2016 Tektonlabs. All rights reserved.
//

import UIKit

var cassinis = 0

class CassiniViewController: UIViewController, UISplitViewControllerDelegate {
    
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
    
    @IBAction func showImage(_ sender: UIButton) {
        if let ivc = splitViewController?.viewControllers.last?.content as? ImageViewController {
            let imageName = sender.currentTitle
            ivc.imageURL = DemoURL.NASAImageNamed(imageName: imageName)
            ivc.title = imageName
        } else {
            performSegue(withIdentifier: Storyboard.ShowImageSegue, sender: sender)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splitViewController?.delegate = self
        //        splitViewController?.addObserver(self, forKeyPath: "viewControllers", options: [], context: nil)
        cassinis += 1
        //print("start \(cassinis)")
    }
    
    //    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    //        if let spv = object as? UISplitViewController {
    //            for vc in spv.viewControllers {
    //                print(vc)
    //            }
    //        }
    //    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if primaryViewController.content == self {
            if let ivc = secondaryViewController as? ImageViewController, ivc.imageURL == nil {
                return false
            }
        }
        return true
    }
    
    deinit {
        cassinis -= 1
        //print("end \(cassinis)")
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



