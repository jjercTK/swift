//
//  ImageViewController.swift
//  Cassini
//
//  Created by Juanjo on 10/21/16.
//  Copyright © 2016 Tektonlabs. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    var imageURL: URL? {
        didSet {
            image = nil
            fetchImage()
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
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    private func fetchImage() {
        if let url = imageURL {
            if let imageData = NSData(contentsOf: url) {
                image = UIImage(data: imageData as Data)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(imageView)
    }


}
