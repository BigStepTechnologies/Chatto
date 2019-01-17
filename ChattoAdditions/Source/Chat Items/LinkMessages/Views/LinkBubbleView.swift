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

// Mark: Protocols to style Link Cell. Declare variables like fonts, textColors, sizes, background colors, paddins etc here
public protocol LinkBubbleViewStyleProtocol {
    func textFont(viewModel: LinkMessageViewModelProtocol, isSelected: Bool) -> UIFont
    func textColor(viewModel: LinkMessageViewModelProtocol, isSelected: Bool) -> UIColor
    func textInsets(viewModel: LinkMessageViewModelProtocol, isSelected: Bool) -> UIEdgeInsets
    func linkPreviewTitleTextColor(viewModel: LinkMessageViewModelProtocol) -> UIColor
    func linkPreviewDescriptionTextColor(viewModel : LinkMessageViewModelProtocol) -> UIColor
    func linkPreviewBackgroundColor(viewModel: LinkMessageViewModelProtocol) -> UIColor
    func bubbleSize(viewModel: LinkMessageViewModelProtocol) -> CGSize
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
        label.backgroundColor = .black
        label.font = UIFont.systemFont(ofSize: 15.0, weight: .heavy)
        return label
    }()
    
    private var previewDescription : UILabel = {
        let label = UILabel()
        label.autoresizingMask = UIViewAutoresizing()
        label.backgroundColor = .green
        label.numberOfLines = 2
        return label
    }()
    
    private var placeHolderImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.autoresizingMask = UIViewAutoresizing()
        return imageView
    }()
    
    private var previewImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
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
        guard let viewModel = self.linkMessageViewModel, let style = self.linkMessageStyle else { return }
        
        // Setting Decoration and Text for Preview Header
        self.previewHeader.text = viewModel.previewHeader
        self.previewHeader.textColor = style.linkPreviewTitleTextColor(viewModel: viewModel)
        self.previewHeader.backgroundColor = style.linkPreviewBackgroundColor(viewModel: viewModel)
        self.previewHeader.font = style.textFont(viewModel: viewModel, isSelected: false)
        
        // Setting Decoration and Text for Preview Description
        self.previewDescription.text = viewModel.previewDescription
        self.previewDescription.backgroundColor = style.linkPreviewBackgroundColor(viewModel: viewModel)
        self.previewDescription.textColor = style.linkPreviewDescriptionTextColor(viewModel: viewModel)
        self.previewDescription.font = style.textFont(viewModel: viewModel, isSelected: false)
        
        if let imageUrl = URL(string: self.linkMessageViewModel.previewImageUrl)
        {
            self.previewImageView.sd_setImage(with: imageUrl,completed: { (image,error,cacheType,url) in
                DispatchQueue.main.async {
                }
            })
        }
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
    
    // MARK: Layout
    public override func layoutSubviews() {
        super.layoutSubviews()
        let layout = self.calculateAudioBubbleLayout(maximumWidth: self.preferredMaxLayoutWidth)
        self.backgroundColor = self.linkMessageStyle.linkPreviewBackgroundColor(viewModel: self.linkMessageViewModel)
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.previewHeader.frame = layout.linkTitleFrame
        self.previewDescription.frame = layout.linkDescriptionFrame
        self.previewImageView.frame = layout.imagePreviewFrame
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        return self.calculateAudioBubbleLayout(maximumWidth: size.width).size
    }
    
    private func calculateAudioBubbleLayout(maximumWidth: CGFloat) -> LinkBubbleLayoutModel {
        let layoutContext = LinkBubbleLayoutModel.LayoutContext(linkMessageViewModel: self.linkMessageViewModel, style: self.linkMessageStyle, containerWidth: maximumWidth)
        let layoutModel = LinkBubbleLayoutModel(layoutContext: layoutContext)
        layoutModel.calculateLayout()
        
        return layoutModel
    }
}

private class LinkBubbleLayoutModel {
    var bubbleFrame:CGRect = CGRect.zero
    var imagePreviewFrame:CGRect = CGRect.zero
    var linkTitleFrame:CGRect = CGRect.zero
    var linkDescriptionFrame:CGRect = CGRect.zero
    var size: CGSize = CGSize.zero
    
    struct LayoutContext {
        let bubbleSize: CGSize
        let preferredMaxLayoutWidth: CGFloat
        init(bubbleSize: CGSize,preferredMaxLayoutWidth width: CGFloat) {
            self.bubbleSize = bubbleSize
            self.preferredMaxLayoutWidth = width
        }
        init(linkMessageViewModel model: LinkMessageViewModelProtocol,
             style: LinkBubbleViewStyleProtocol,
             containerWidth width: CGFloat) {
            
            self.init(bubbleSize: style.bubbleSize(viewModel: model),preferredMaxLayoutWidth: width)
        }
    }
    
    let layoutContext: LayoutContext
    init(layoutContext: LayoutContext) {
        self.layoutContext = layoutContext
    }
    
    func calculateLayout() {
        let size = self.layoutContext.bubbleSize
        self.bubbleFrame = CGRect(origin: .zero, size: size)
        self.imagePreviewFrame = CGRect(origin: .zero, size: CGSize(width: size.width, height: 130))
        self.linkTitleFrame = CGRect(x: 5, y: 130, width: size.width-10, height: 25)
        self.linkDescriptionFrame = CGRect(x: 5, y: 155, width: size.width-10, height: 40)
        self.size = size
    }
    
}
