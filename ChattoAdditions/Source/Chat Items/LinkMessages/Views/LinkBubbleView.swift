//
//  LinkBubbleView.swift
//  ChattoAdditions
//
//  Created by Vidit Paliwal on 15/01/19.
//

import Foundation
import UIKit
import Chatto
import SDWebImage

public protocol LinkBubbleViewStyleProtocol {
    func textFont(viewModel: LinkMessageViewModelProtocol, isSelected: Bool) -> UIFont
    func textColor(viewModel: LinkMessageViewModelProtocol, isSelected: Bool) -> UIColor
    func textInsets(viewModel: LinkMessageViewModelProtocol, isSelected: Bool) -> UIEdgeInsets
    func linkPreviewTitleTextColor(viewModel: LinkMessageViewModelProtocol) -> UIColor
    func linkPreviewDescriptionTextColor(viewModel : LinkMessageViewModelProtocol) -> UIColor
    func linkPreviewBackgroundColor(viewModel: LinkMessageViewModelProtocol) -> UIColor
}

public class LinkBubbleView : UIView, MaximumLayoutWidthSpecificable, BackgroundSizingQueryable
{
    public var canCalculateSizeInBackground: Bool {
        return true
    }
    
    //public var canCalculateSizeInBackground: Bool
    public var preferredMaxLayoutWidth: CGFloat = 0.0
    public var viewContext: ViewContext = .normal
    public var animationDuration: CFTimeInterval = 0.33
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        self.autoresizesSubviews = false
        self.addSubview(placeHolderImageView)
        self.addSubview(previewImageView)
        self.addSubview(previewHeader)
        self.addSubview(previewDescription)
    }
    
    private var previewHeader : UILabel = {
        let label = UILabel()
        label.autoresizingMask = UIViewAutoresizing()
        return label
    }()
    
    private var previewDescription : UILabel = {
        let label = UILabel()
        label.autoresizingMask = UIViewAutoresizing()
        return label
    }()
    
    private var placeHolderImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.autoresizingMask = UIViewAutoresizing()
        return imageView
    }()
    
    private var previewImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.autoresizingMask = UIViewAutoresizing()
        return imageView
    }()
    
    public private(set) var isUpdating: Bool = false
    public var linkMessageViewModel: LinkMessageViewModelProtocol! {
        didSet {
            self.updateViews()
        }
    }
    
    public var linkMessageStyle: LinkBubbleViewStyleProtocol! {
        didSet {
            self.updateViews()
        }
    }
    
    
    open func updateViews() {
        if self.viewContext == .sizing { return }
        if isUpdating { return }
        guard self.linkMessageViewModel != nil, self.linkMessageStyle != nil else { return }
        self.updateImage()
        self.setNeedsLayout()
    }
    
    public func performBatchUpdates(_ updateClosure: @escaping () -> Void, animated: Bool, completion: (() -> Void)?) {
        self.isUpdating = true
        let updateAndRefreshViews = {
            updateClosure()
            self.isUpdating = false
            self.updateViews()
            if animated {
                self.layoutIfNeeded()
            }
        }
        if animated {
            UIView.animate(withDuration: self.animationDuration, animations: updateAndRefreshViews, completion: { (_) -> Void in
                completion?()
            })
        } else {
            updateAndRefreshViews()
        }
    }
    
    open func updateImage()
    {
//        if let image = self.linkMessageViewModel.previewImage.value
//        {
//            self.previewImageView.image = image
//        }
//        else
//        {
//            self.placeHolderImageView.image = UIImage()
//            self.placeHolderImageView.isHidden = false
//        }
    }
    
    
}
