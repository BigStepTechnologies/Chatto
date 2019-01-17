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
    }
    
    public struct TextStyle {
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
    
    lazy var font: UIFont = self.textDecorationStyles.font()
    lazy var incomingColor: UIColor = self.textDecorationStyles.incomingColor()
    lazy var outgoingColor: UIColor = self.textDecorationStyles.outgoingColor()
    
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
    
    // Function for setting Link Preview Text Color
    open func linkPreviewTitleTextColor(viewModel: LinkMessageViewModelProtocol) -> UIColor {
        return viewModel.isIncoming ? self.decorationColors.previewTitleColorInComing : self.decorationColors.previewTitleColorIOutGoing
    }
    
    // Function for setting Link Preview Description Color
    open func linkPreviewDescriptionTextColor(viewModel: LinkMessageViewModelProtocol) -> UIColor {
        return viewModel.isIncoming ? self.decorationColors.previewDescriptionColorInComing :  self.decorationColors.previewDescriptionColorOutGoing
    }
    
    // Function for setting Link Preview Background Color
    open func linkPreviewBackgroundColor(viewModel: LinkMessageViewModelProtocol) -> UIColor {
        return viewModel.isIncoming ? self.decorationColors.previewBackgroundColorInComing : self.decorationColors.previewBackgroundColorOutGoing
    }
    
    // Function to set link preview text labels Font
    open func textFont(viewModel: LinkMessageViewModelProtocol, isSelected: Bool) -> UIFont {
        return self.font
    }
    
    // Function to set Text Color in Case no preview returned.
    open func textColor(viewModel: LinkMessageViewModelProtocol, isSelected: Bool) -> UIColor {
        return viewModel.isIncoming ? self.incomingColor : self.outgoingColor
    }
    
    // Function to set Text insets for Text in case no preview returned.
    open func textInsets(viewModel: LinkMessageViewModelProtocol, isSelected: Bool) -> UIEdgeInsets {
        return viewModel.isIncoming ? self.textDecorationStyles.incomingInsets : self.textDecorationStyles.outgoingInsets
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
            previewSizePortrait: CGSize(width: 220, height: 205)
        )
    }
    
    static public func createPreviewDecorationColor() -> Colors
    {
        let blueBackgroundColor = UIColor(red: 23/255, green: 97/255, blue: 182/255, alpha: 1.0)
        let grayBackgroundColor = UIColor(red:240/255,green:240/255,blue:240/255,alpha:1.0)
        let incomingTitleColor = UIColor.black
        let incomingDescriptionColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1.0)
        return Colors(previewTitleColorInComing: incomingTitleColor, previewDescriptionColorInComing: incomingDescriptionColor, previewBackgroundColorInComing: grayBackgroundColor, previewBackgroundColorOutGoing: blueBackgroundColor, previewTitleColorIOutGoing: UIColor.white, previewDescriptionColorOutGoing: UIColor.lightText)
    }
    
    static public func createDefaultTextStyle() -> TextStyle {
        return TextStyle(
            font: UIFont.systemFont(ofSize: 16),
            incomingColor: UIColor.black,
            outgoingColor: UIColor.white,
            incomingInsets: UIEdgeInsets(top: 10, left: 19, bottom: 10, right: 15),
            outgoingInsets: UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 19)
        )
    }
}
