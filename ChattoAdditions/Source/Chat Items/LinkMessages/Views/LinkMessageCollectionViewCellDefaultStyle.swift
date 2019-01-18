//
//  LinkMessageCollectionViewCellDefaultStyle.swift
//  ChattoAdditions
//
//  Created by Vidit Paliwal on 15/01/19.
//

import Foundation
import UIKit

open class LinkMessageCollectionViewCellDefaultStyle : LinkMessageCollectionViewCellStyleProtocol
{
    typealias Class = LinkMessageCollectionViewCellDefaultStyle
    
    public struct BubbleMasks {
        public let incomingTail: () -> UIImage
        public let incomingNoTail: () -> UIImage
        public let outgoingTail: () -> UIImage
        public let outgoingNoTail: () -> UIImage
        public let tailWidth: CGFloat
        public init(
            incomingTail: @autoclosure @escaping () -> UIImage,
            incomingNoTail: @autoclosure @escaping () -> UIImage,
            outgoingTail: @autoclosure @escaping () -> UIImage,
            outgoingNoTail: @autoclosure @escaping () -> UIImage,
            tailWidth: CGFloat) {
            self.incomingTail = incomingTail
            self.incomingNoTail = incomingNoTail
            self.outgoingTail = outgoingTail
            self.outgoingNoTail = outgoingNoTail
            self.tailWidth = tailWidth
        }
    }
    
    public struct Sizes {
        public let previewSizeLandscape: CGSize
        public let previewSizePortrait: CGSize
        public init(
            previewSizeLandscape: CGSize,
            previewSizePortrait: CGSize) {
            self.previewSizeLandscape = previewSizeLandscape
            self.previewSizePortrait = previewSizePortrait
        }
    }
    
    public struct Colors {
        
        
         public let linkMessageIncomingColor : UIColor
         public let linkMessageOutgoingColor : UIColor
         public let canonicalUrlIncomingColor : UIColor
         public let canonicalUrlOutgoingColor : UIColor
         public let linkTitleIncomingColor : UIColor
         public let linkTitleOutgoingColor : UIColor
         public let linkDescriptionIncomingColor : UIColor
         public let linkDescriptionOutgoingColor : UIColor
         public init(
         linkMessageIncomingColor : UIColor,
         linkMessageOutgoingColor : UIColor,
         canonicalUrlIncomingColor : UIColor,
         canonicalUrlOutgoingColor : UIColor,
         linkTitleIncomingColor : UIColor,
         linkTitleOutgoingColor : UIColor,
         linkDescriptionIncomingColor : UIColor,
         linkDescriptionOutgoingColor : UIColor ) {
         self.linkMessageIncomingColor = linkMessageIncomingColor
         self.linkMessageOutgoingColor = linkMessageOutgoingColor
         self.canonicalUrlIncomingColor = canonicalUrlIncomingColor
         self.canonicalUrlOutgoingColor = canonicalUrlOutgoingColor
         self.linkTitleIncomingColor = linkTitleIncomingColor
         self.linkTitleOutgoingColor = linkTitleOutgoingColor
         self.linkDescriptionIncomingColor = linkDescriptionIncomingColor
         self.linkDescriptionOutgoingColor = linkDescriptionOutgoingColor
         }
 
        /*
        public let previewTitleColorInComing: UIColor
        public let previewDescriptionColorInComing: UIColor
        public let previewBackgroundColorInComing: UIColor
        public let previewBackgroundColorOutGoing: UIColor
        public let previewTitleColorIOutGoing: UIColor
        public let previewDescriptionColorOutGoing: UIColor
        public init(
            previewTitleColorInComing: UIColor,
            previewDescriptionColorInComing: UIColor,
            previewBackgroundColorInComing: UIColor,
            previewBackgroundColorOutGoing: UIColor,
            previewTitleColorIOutGoing: UIColor,
            previewDescriptionColorOutGoing: UIColor) {
            self.previewTitleColorInComing = previewTitleColorInComing
            self.previewDescriptionColorInComing = previewDescriptionColorInComing
            self.previewBackgroundColorInComing = previewBackgroundColorInComing
            self.previewTitleColorIOutGoing = previewTitleColorIOutGoing
            self.previewDescriptionColorOutGoing = previewDescriptionColorOutGoing
            self.previewBackgroundColorOutGoing = previewBackgroundColorOutGoing
        }
        */
    }
    
    public struct TextStyle {
        
         let linkMessageFont : () -> UIFont
         let canonicalUrlFont : () -> UIFont
         let linkTitleFont : () -> UIFont
         let linkDescriptionFont : () -> UIFont
         let incomingTextInsets : UIEdgeInsets
         let outgoingTextInsets : UIEdgeInsets
         public init (
         linkMessageFont: @autoclosure @escaping () -> UIFont,
         canonicalUrlFont: @autoclosure @escaping () -> UIFont,
         linkTitleFont: @autoclosure @escaping () -> UIFont,
         linkDescriptionFont: @autoclosure @escaping () -> UIFont,
         incomingTextInsets : UIEdgeInsets,
         outgoingTextInsets : UIEdgeInsets) {
         self.linkMessageFont = linkMessageFont
         self.canonicalUrlFont = canonicalUrlFont
         self.linkTitleFont = linkTitleFont
         self.linkDescriptionFont = linkDescriptionFont
         self.incomingTextInsets = incomingTextInsets
         self.outgoingTextInsets = outgoingTextInsets
         }
        
        /*
        let font: () -> UIFont
        let incomingColor: () -> UIColor
        let outgoingColor: () -> UIColor
        let incomingInsets: UIEdgeInsets
        let outgoingInsets: UIEdgeInsets
        public init(
            font: @autoclosure @escaping () -> UIFont,
            incomingColor: @autoclosure @escaping () -> UIColor,
            outgoingColor: @autoclosure @escaping () -> UIColor,
            incomingInsets: UIEdgeInsets,
            outgoingInsets: UIEdgeInsets) {
            self.font = font
            self.incomingColor = incomingColor
            self.outgoingColor = outgoingColor
            self.incomingInsets = incomingInsets
            self.outgoingInsets = outgoingInsets
        }
        */
    }
    
    let bubbleMasks: BubbleMasks
    let sizes: Sizes
    let baseStyle: BaseMessageCollectionViewCellDefaultStyle
    let decorationColors : Colors
    let textDecorationStyles : TextStyle
    public init(
        bubbleMasks: BubbleMasks = Class.createDefaultBubbleMasks(),
        sizes: Sizes = Class.createDefaultSizes(),
        decorationColors : Colors = Class.createPreviewDecorationColor(),
        textDecorationStyles : TextStyle = Class.createDefaultTextStyle(),
        baseStyle: BaseMessageCollectionViewCellDefaultStyle = BaseMessageCollectionViewCellDefaultStyle()) {
        self.bubbleMasks = bubbleMasks
        self.sizes = sizes
        self.baseStyle = baseStyle
        self.decorationColors = decorationColors
        self.textDecorationStyles = textDecorationStyles
    }
    
     lazy var linkMessageIncomingColor:UIColor = self.decorationColors.linkMessageIncomingColor
     lazy var linkMessageOutgoingColor:UIColor = self.decorationColors.linkMessageOutgoingColor
     lazy var canonicalUrlIncomingColor:UIColor = self.decorationColors.canonicalUrlIncomingColor
     lazy var canonicalUrlOutgoingColor:UIColor = self.decorationColors.canonicalUrlOutgoingColor
     lazy var linkTitleIncomingColor:UIColor = self.decorationColors.linkTitleIncomingColor
     lazy var linkTitleOutgoingColor:UIColor = self.decorationColors.linkTitleOutgoingColor
     lazy var linkDescriptionIncomingColor:UIColor = self.decorationColors.linkDescriptionIncomingColor
     lazy var linkDescriptionOutgoingColor:UIColor = self.decorationColors.linkDescriptionOutgoingColor
    
    
    
     
     lazy var linkMessageFont:UIFont = self.textDecorationStyles.linkMessageFont()
     lazy var canonicalUrlFont:UIFont = self.textDecorationStyles.canonicalUrlFont()
     lazy var linkTitleFont:UIFont = self.textDecorationStyles.linkTitleFont()
     lazy var linkDescriptionFont:UIFont = self.textDecorationStyles.linkDescriptionFont()
     lazy var incomingTextInsets:UIEdgeInsets = self.textDecorationStyles.incomingTextInsets
     lazy var outgoingTextInsets:UIEdgeInsets = self.textDecorationStyles.outgoingTextInsets

    
    
    
    lazy private var maskImageIncomingTail: UIImage = self.bubbleMasks.incomingTail()
    lazy private var maskImageIncomingNoTail: UIImage = self.bubbleMasks.incomingNoTail()
    lazy private var maskImageOutgoingTail: UIImage = self.bubbleMasks.outgoingTail()
    lazy private var maskImageOutgoingNoTail: UIImage = self.bubbleMasks.outgoingNoTail()
    
    open func maskingImage(viewModel: LinkMessageViewModelProtocol) -> UIImage {
        switch (viewModel.isIncoming, viewModel.decorationAttributes.isShowingTail) {
        case (true, true):
            return self.maskImageIncomingTail
        case (true, false):
            return self.maskImageIncomingNoTail
        case (false, true):
            return self.maskImageOutgoingTail
        case (false, false):
            return self.maskImageOutgoingNoTail
        }
    }
    
    open func bubbleSize(viewModel: LinkMessageViewModelProtocol) -> CGSize {
        return self.sizes.previewSizePortrait
    }
    
    open func overlayColor(viewModel: AudioMessageViewModelProtocol) -> UIColor? {
        let showsOverlay = (viewModel.transferStatus.value == .transfering || viewModel.status == MessageViewModelStatus.sending || viewModel.status == MessageViewModelStatus.failed)
        return showsOverlay ? UIColor.black.withAlphaComponent(0.70) : nil
    }
    
    // MARK:- Functions for Styling Link Preview
    
    public func linkMessageColor(viewModel: LinkMessageViewModelProtocol) -> UIColor {
        return viewModel.isIncoming ? self.linkMessageIncomingColor : self.linkMessageOutgoingColor
    }
    
    public func canonicalUrlColor(viewModel: LinkMessageViewModelProtocol) -> UIColor {
        return viewModel.isIncoming ? self.canonicalUrlIncomingColor : self.canonicalUrlOutgoingColor
    }
    
    public func linkTitleColor(viewModel: LinkMessageViewModelProtocol) -> UIColor {
        return viewModel.isIncoming ? self.linkTitleIncomingColor : self.linkTitleOutgoingColor
    }
    
    public func linkDescriptionColor(viewModel: LinkMessageViewModelProtocol) -> UIColor {
        return viewModel.isIncoming ? self.linkDescriptionIncomingColor : self.linkDescriptionOutgoingColor
    }

    public func linkMessageFont(viewModel: LinkMessageViewModelProtocol) -> UIFont {
        return self.linkMessageFont
    }
    
    public func canonicalUrlFont(viewModel: LinkMessageViewModelProtocol) -> UIFont {
        return self.canonicalUrlFont
    }
    
    public func linkTitleFont(viewModel: LinkMessageViewModelProtocol) -> UIFont {
        return self.linkTitleFont
    }
    
    public func linkDescriptionFont(viewModel: LinkMessageViewModelProtocol) -> UIFont {
        return self.linkDescriptionFont
    }
}

extension LinkMessageCollectionViewCellDefaultStyle {
    
    static public func createDefaultBubbleMasks() -> BubbleMasks {
        return BubbleMasks(
            incomingTail: UIImage(named: "bubble-incoming-tail", in: Bundle(for: Class.self), compatibleWith: nil)!,
            incomingNoTail: UIImage(named: "bubble-incoming", in: Bundle(for: Class.self), compatibleWith: nil)!,
            outgoingTail: UIImage(named: "bubble-outgoing-tail", in: Bundle(for: Class.self), compatibleWith: nil)!,
            outgoingNoTail: UIImage(named: "bubble-outgoing", in: Bundle(for: Class.self), compatibleWith: nil)!,
            tailWidth: 6
        )
    }
    
    static public func createDefaultSizes() -> Sizes {
        return Sizes(
            previewSizeLandscape: CGSize(width: 210, height: 136),
            previewSizePortrait: CGSize(width: 220, height: 280)
        )
    }
    
    static public func createPreviewDecorationColor() -> Colors
    {
        
        let incomingTitleColor = UIColor.black
        let incomingDescriptionColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1.0)
        
        let canonicalColorIn = UIColor(red: 102/255, green: 255/255, blue: 239/255, alpha: 1.0)
        let canonicalColorOut = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0)
        
        let linkTitleIn = UIColor.black.withAlphaComponent(0.9)
        let linkTitleOut = UIColor.white.withAlphaComponent(0.9)
        
        let linkDescriptionIn = UIColor.black.withAlphaComponent(0.8)
        let linkDescriptionOut = UIColor.white.withAlphaComponent(0.8)
        
        return Colors(linkMessageIncomingColor: UIColor.black, linkMessageOutgoingColor: UIColor.white, canonicalUrlIncomingColor: canonicalColorIn, canonicalUrlOutgoingColor: canonicalColorOut, linkTitleIncomingColor: linkTitleIn, linkTitleOutgoingColor: linkTitleOut, linkDescriptionIncomingColor: linkDescriptionIn, linkDescriptionOutgoingColor: linkDescriptionOut)
        
    }
    
    static public func createDefaultTextStyle() -> TextStyle {
        
        let messageFont = UIFont.systemFont(ofSize: 16)
        let titleFont = UIFont.systemFont(ofSize: 16)
        let canonicalFont = UIFont.systemFont(ofSize: 16)
        let descriptionFont = UIFont.systemFont(ofSize: 16)
        let incomingInsets = UIEdgeInsets(top: 10, left: 19, bottom: 10, right: 15)
        let outgoingInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 19)
        
        return TextStyle(linkMessageFont: messageFont, canonicalUrlFont: canonicalFont, linkTitleFont: titleFont, linkDescriptionFont: descriptionFont, incomingTextInsets: incomingInsets, outgoingTextInsets: outgoingInsets)
    }
}
