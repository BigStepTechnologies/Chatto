//
//  QuoteMessageView.swift
//  ChattoAdditions
//
//  Created by bigstep_macbook_air on 03/10/18.
//  Copyright © 2018 Badoo. All rights reserved.
//

import Foundation
import UIKit
class QuoteMessageView: UIView
{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBubble()
    }
    
 
    func setupBubble(){
        addSubview(indicatorView)
        addConstraintsWithFormat(format: "H:|-10-[v0(3)]", views: indicatorView)
        addConstraintsWithFormat(format: "V:|-5-[v0]-5-|", views: indicatorView)
        setupContainerView()
    }
    
    func setupContainerView(){
        
        addSubview(containerView)
        addConstraintsWithFormat(format: "H:|-15-[v0]-15-|", views: containerView)
        addConstraintsWithFormat(format: "V:|-5-[v0]-5-|", views: containerView)
        
        containerView.addSubview(nameView)
        containerView.addConstraintsWithFormat(format: "H:|-5-[v0]-50-|", views: nameView)
        containerView.addConstraintsWithFormat(format: "V:|-5-[v0(20)]|", views: nameView)
        
        containerView.addSubview(messageView)
        containerView.addConstraintsWithFormat(format: "H:|[v0]-50-|", views: messageView)
        containerView.addConstraintsWithFormat(format: "V:|-25-[v0(20)]|", views: messageView)
        
        containerView.addSubview(messageImageView)
        containerView.addConstraintsWithFormat(format: "H:|[v0]-5-[v1]-5-|", views: nameView, messageImageView)
        containerView.addConstraintsWithFormat(format: "V:|-5-[v0]-5-|", views: messageImageView)
        
    }
    
    
    let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    let nameView:  UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Mohd Kaleem"
        label.textColor = UIColor.white
        return label
    }()
    
    let messageView: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        label.text = "How are you?"
        return label
    }()
    
    let messageImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pic-test-2")
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        return view
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...){
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated(){
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
