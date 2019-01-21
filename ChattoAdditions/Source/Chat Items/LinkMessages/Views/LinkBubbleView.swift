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
    
    func linkMessageColor(viewModel : LinkMessageViewModelProtocol) -> UIColor
    func canonicalUrlColor(viewModel : LinkMessageViewModelProtocol) -> UIColor
    func linkTitleColor(viewModel : LinkMessageViewModelProtocol) -> UIColor
    func linkDescriptionColor(viewModel : LinkMessageViewModelProtocol) -> UIColor
    func linkMessageFont(viewModel : LinkMessageViewModelProtocol) -> UIFont
    func canonicalUrlFont(viewModel : LinkMessageViewModelProtocol) -> UIFont
    func linkTitleFont(viewModel : LinkMessageViewModelProtocol) -> UIFont
    func linkDescriptionFont(viewModel : LinkMessageViewModelProtocol) -> UIFont
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
        self.addSubview(messageTextLabel)
        self.addSubview(rootUrlLabel)
        self.addSubview(linkImageImageView)
        self.addSubview(linkTitleLabel)
        self.addSubview(linkDescriptionLabel)
    }
    
    private var messageTextLabel : UILabel = {
        let label = UILabel()
        label.autoresizingMask = UIViewAutoresizing()
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()
    
    private var rootUrlLabel : UILabel = {
        let label = UILabel()
        label.autoresizingMask = UIViewAutoresizing()
        label.backgroundColor = .clear
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()

    // Title Label
    private var linkTitleLabel : UILabel = {
        let label = UILabel()
        label.autoresizingMask = UIViewAutoresizing()
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .heavy)
        return label
    }()
    
    // Description Label
    private var linkDescriptionLabel : UILabel = {
        let label = UILabel()
        label.autoresizingMask = UIViewAutoresizing()
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 10.0)
        return label
    }()

    // Link Image ImageView
    private var linkImageImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .white
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
        
        // Setting Decoration and Text for Message Text Label
        self.messageTextLabel.text = viewModel.messageText
        self.messageTextLabel.textColor = style.linkMessageColor(viewModel: viewModel)
        self.messageTextLabel.backgroundColor = .clear
        self.messageTextLabel.font = style.linkMessageFont(viewModel: viewModel)
        
        // Setting for Canonical Label
        
        self.rootUrlLabel.textColor = style.canonicalUrlColor(viewModel: viewModel)
        self.rootUrlLabel.text = viewModel.canonicalUrl
        self.rootUrlLabel.backgroundColor = .clear
        self.rootUrlLabel.font = style.canonicalUrlFont(viewModel: viewModel)
        
        // Setting Decoration and Text for Preview Header
        self.linkTitleLabel.text = viewModel.previewHeader
        self.linkTitleLabel.textColor = style.linkTitleColor(viewModel: viewModel)
        self.linkTitleLabel.backgroundColor = .clear
        self.linkTitleLabel.font = style.linkTitleFont(viewModel: viewModel)
        
        // Setting Decoration and Text for Preview Description
        self.linkDescriptionLabel.text = viewModel.previewDescription
        self.linkDescriptionLabel.backgroundColor = .clear
        self.linkDescriptionLabel.textColor = style.linkDescriptionColor(viewModel: viewModel)
        self.linkDescriptionLabel.font = style.linkDescriptionFont(viewModel: viewModel)
        
        if let imageUrl = URL(string: self.linkMessageViewModel.previewImageUrl)
        {
            self.linkImageImageView.sd_setImage(with: imageUrl,completed: { (image,error,cacheType,url) in
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
        
        let blueBackgroundColor = UIColor(red: 23/255, green: 97/255, blue: 182/255, alpha: 1.0)
        let grayBackgroundColor = UIColor(red:240/255,green:240/255,blue:240/255,alpha:1.0)
        
        self.backgroundColor = self.linkMessageViewModel.isIncoming ? grayBackgroundColor : blueBackgroundColor
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.messageTextLabel.frame = layout.messageTextFrame
        self.rootUrlLabel.frame = layout.canonicalUrlFrame
        self.linkTitleLabel.frame = layout.linkTitleFrame
        self.linkDescriptionLabel.frame = layout.linkDescriptionFrame
        self.linkImageImageView.frame = layout.imagePreviewFrame
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
    var messageTextFrame:CGRect = CGRect.zero
    var canonicalUrlFrame:CGRect = CGRect.zero
    var imagePreviewFrame:CGRect = CGRect.zero
    var linkTitleFrame:CGRect = CGRect.zero
    var linkDescriptionFrame:CGRect = CGRect.zero
    var size: CGSize = CGSize.zero
    
    struct LayoutContext {
        let bubbleSize: CGSize
        let preferredMaxLayoutWidth: CGFloat
        let messageText: String
        let descriptionText : String
        let titleText : String
        let messageFont : UIFont
        let titleFont : UIFont
        let descriptionFont : UIFont
        init(bubbleSize: CGSize,preferredMaxLayoutWidth width: CGFloat,messageText:String,descriptionText:String,titleText:String,messageFont:UIFont,titleFont:UIFont,descriptionFont:UIFont) {
            self.bubbleSize = bubbleSize
            self.preferredMaxLayoutWidth = width
            self.messageText = messageText
            self.descriptionText = descriptionText
            self.titleText = titleText
            self.descriptionFont = descriptionFont
            self.titleFont = titleFont
            self.messageFont = messageFont
        }
        init(linkMessageViewModel model: LinkMessageViewModelProtocol,
             style: LinkBubbleViewStyleProtocol,
             containerWidth width: CGFloat) {
            let messageText = model.messageText
            let descriptionText = model.previewDescription
            let titleText = model.previewHeader
            let messageFont = style.linkMessageFont(viewModel: model)
            let titleFont = style.linkTitleFont(viewModel: model)
            let descriptionFont = style.linkDescriptionFont(viewModel: model)
            self.init(bubbleSize: style.bubbleSize(viewModel: model), preferredMaxLayoutWidth: width, messageText: messageText, descriptionText: descriptionText, titleText: titleText, messageFont: messageFont, titleFont: titleFont, descriptionFont: descriptionFont)
        }
    }
    
    let layoutContext: LayoutContext
    init(layoutContext: LayoutContext) {
        self.layoutContext = layoutContext
    }
    
    func calculateLayout() {
        var size = self.layoutContext.bubbleSize
        let messageFrameHeight = calculateLabelHeight(text: self.layoutContext.messageText, font: self.layoutContext.messageFont, frameSize: size)
        let titleFrameHeight = calculateLabelHeight(text: self.layoutContext.titleText, font: self.layoutContext.titleFont, frameSize: size)
        let descriptionFrameHeight = calculateLabelHeight(text: self.layoutContext.descriptionText, font: self.layoutContext.descriptionFont, frameSize: size)
        self.bubbleFrame = CGRect(origin: .zero, size: size)
        self.messageTextFrame = CGRect(x: 5, y: 5, width: size.width-10, height: messageFrameHeight+5)
        self.imagePreviewFrame = CGRect(x: 0, y: getInputViewYend(frame: self.messageTextFrame), width: size.width, height: 130)
        self.canonicalUrlFrame = CGRect(x: 5, y: getInputViewYend(frame: self.imagePreviewFrame), width: size.width-10, height: 25)
        self.linkTitleFrame = CGRect(x: 5, y: getInputViewYend(frame: self.canonicalUrlFrame), width: size.width-10, height: titleFrameHeight+5)
        self.linkDescriptionFrame = CGRect(x: 5, y: getInputViewYend(frame: self.linkTitleFrame), width: size.width-10, height: descriptionFrameHeight+5)
        size.height = getInputViewYend(frame: self.linkDescriptionFrame)+10
        self.size = size
    }
    func calculateLabelHeight(text:String,font:UIFont,frameSize:CGSize)-> CGFloat
    {
        let labelWidth = frameSize.width
        let label = UILabel()
        label.frame = CGRect(x:5,y:0,width:labelWidth-10,height:4000)
        label.font = font
        label.text = text
        label.numberOfLines = 0
        label.sizeToFit()
        let labelHeight = label.frame.size.height
        label.removeFromSuperview()
        return labelHeight
        
    }
    func getInputViewYend(frame:CGRect)-> CGFloat
    {
        return frame.origin.y+frame.size.height
    }
    
}
