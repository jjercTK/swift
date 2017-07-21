//
//  FeedViewController.swift
//  Facebook
//
//  Created by Juan José Ramírez on 7/20/17.
//  Copyright © 2017 Juan José Ramírez. All rights reserved.
//

import UIKit

let cellId = "cellId"

class FeedViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Facebook Feed"
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }

}

class FeedCell: UICollectionViewCell {
    
    let nameLabel: UILabel = {
        let paragraphedStyle = NSMutableParagraphStyle()
        paragraphedStyle.lineSpacing = 4
        
        let attachment = NSTextAttachment()
        attachment.image = #imageLiteral(resourceName: "world").tintColor(color: UIColor.rgb(red: 155, green: 161, blue: 171))
        attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
        
        
        let attributedText = NSMutableAttributedString(string: "Juan José Ramírez Calderón",
                                                attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "\nJulio 20  •  Lima  •  ",
                              attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 12),
                                           NSForegroundColorAttributeName: UIColor.rgb(red: 155, green: 161, blue: 171)]))
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphedStyle, range: NSMakeRange(0, attributedText.string.characters.count))
        attributedText.append(NSAttributedString(attachment: attachment))
        
        
        let label = UILabel()
        label.numberOfLines = 2
        label.attributedText = attributedText
        return label
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "profile")
        imageView.backgroundColor = UIColor.red
        return imageView
    }()
    
    let postTextView: UITextView = {
        let textView = UITextView()
        textView.text = "El concierto de Linkin Park en Lima 😭"
        textView.font = UIFont.systemFont(ofSize: 14)
        return textView
    }()
    
    let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "post")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let likesLabel: UILabel = {
        let label = UILabel()
        label.text = "448 Likes   10.7K Comments"
        label.textColor = UIColor.rgb(red: 155, green: 161, blue: 171)
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 226, green: 228, blue: 232)
        return view
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        setupView()
        print(subviews)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        backgroundColor = UIColor.white
        
        addSubviewWithConstraints(format: "H:|-8-[v0(44)]-8-[v1]|", views: profileImageView, nameLabel)
        addSubviewWithConstraints(format: "H:|-4-[v0]-4-|", views: postTextView)
        addSubviewWithConstraints(format: "H:|[v0]|", views: postImageView)
        addSubviewWithConstraints(format: "H:|-4-[v0]", views: likesLabel)
        addSubviewWithConstraints(format: "H:|-12-[v0]-12-|", views: dividerLineView)
        
        addSubviewWithConstraints(format: "V:|-12-[v0]", views: nameLabel)
        addSubviewWithConstraints(
            format: "V:|-8-[v0(44)]-4-[v1(30)]-4-[v2]-4-[v3(24)]-4-[v4(2)]-4-|",
            views: profileImageView, postTextView, postImageView, likesLabel, dividerLineView
        )
        
    }
    
    
}

extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
}

extension UIView {
    
    func addSubviewWithConstraints(format: String, views: UIView...){
        var viewDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewDictionary))
    }
    
}

extension UIImage {
    
    func tintColor(color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        context.setBlendMode(.normal)
        guard cgImage != nil else {
            return nil
        }
        context.draw(cgImage!, in: rect)
        context.setBlendMode(.sourceIn)
        color.setFill()
        context.fill(rect)
        
        guard let coloredCgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            return nil
        }
        UIGraphicsEndImageContext()
        
        return UIImage(cgImage: coloredCgImage)
    }
    
}

