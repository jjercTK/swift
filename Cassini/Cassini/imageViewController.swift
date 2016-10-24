//
//  ImageViewController.swift
//  Cassini
//
//  Created by Juanjo on 10/21/16.
//  Copyright © 2016 Tektonlabs. All rights reserved.
//

import UIKit

var threadCount = 0
var lifeCount = 0

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    var imageURL: URL? {
        didSet {
            image = nil
            if view.window != nil { //this means you are on screen
                fetchImage()
            }
        }
    }
    
    private var imageView = UIImageView()
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
            spinner?.stopAnimating()
        }
    }
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.contentSize = imageView.frame.size
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 1.0
        }
    }
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    private func fetchImage() {
        if let url = imageURL {
            spinner?.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async {
                let contentsOfURL = NSData(contentsOf: url)
                threadCount += 1
                //print("load \(threadCount)")
                DispatchQueue.main.async {
                    //print("main \(threadCount)")
                    if url == self.imageURL {
                        if let imageData = contentsOfURL {
                            self.image = UIImage(data: imageData as Data)
                        } else {
                            print("weird")
                            self.spinner?.stopAnimating()
                        }
                    } else {
                        //print("ignored data \(threadCount)")
                    }
                }
            }
            
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil {
            fetchImage()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lifeCount += 1
        print("start \(lifeCount)")
        scrollView.addSubview(imageView)
    }
    
    deinit {
        lifeCount -= 1
        print("end \(lifeCount)")
    }
    
}
