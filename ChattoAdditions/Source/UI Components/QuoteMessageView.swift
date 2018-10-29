//
//  QuoteMessageView.swift
//  ChattoAdditions
//
//  Created by bigstep_macbook_air on 03/10/18.
//  Copyright © 2018 Badoo. All rights reserved.
//

import Foundation
import UIKit
open class QuoteMessageView: UIView
{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContainerView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContainerView()
    {
        
        containerView.addSubview(nameView)
        nameView.frame = CGRect(x: 0, y: 5, width: containerView.frame.width - 55, height: 20)
        
        containerView.addSubview(messageView)
        messageView.frame = CGRect(x: 0, y: nameView.frame.height + nameView.frame.origin.y, width: containerView.frame.width - 55, height: 20)
        
        containerView.addSubview(messageImageView)
        messageImageView.frame = CGRect(x: containerView.frame.width - 50, y: 0, width: 50, height: containerView.frame.height)
    }
    
    open var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    open var nameView:  UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    open var messageView: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    open var messageImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    open var indicatorView: UIView = {
        let view = UIView()
        return view
    }()
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        addSubview(indicatorView)
        indicatorView.frame = CGRect(x: 15, y: 5, width: 3, height: self.bounds.height - 10)
        addSubview(containerView)
        containerView.frame = CGRect(x: 25, y: 5, width: self.bounds.width - 45, height: self.bounds.height - 10)
        setupContainerView()
    }
    
}
