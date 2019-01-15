//
//  LinkMessageCollectionViewCellDefaultStyle.swift
//  ChattoAdditions
//
//  Created by Vidit Paliwal on 15/01/19.
//

import Foundation
import UIKit

class LinkMessageCollectionViewCellDefaultStyle : LinkMessageCollectionViewCellStyleProtocol
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
        public let audioSizeLandscape: CGSize
        public let audioSizePortrait: CGSize
        public init(
            audioSizeLandscape: CGSize,
            audioSizePortrait: CGSize) {
            self.audioSizeLandscape = audioSizeLandscape
            self.audioSizePortrait = audioSizePortrait
        }
    }
    
    let bubbleMasks: BubbleMasks
    let sizes: Sizes
    let baseStyle: BaseMessageCollectionViewCellDefaultStyle
    public init(
        bubbleMasks: BubbleMasks = Class.createDefaultBubbleMasks(),
        sizes: Sizes = Class.createDefaultSizes(),
        baseStyle: BaseMessageCollectionViewCellDefaultStyle = BaseMessageCollectionViewCellDefaultStyle()) {
        self.bubbleMasks = bubbleMasks
        self.sizes = sizes
        self.baseStyle = baseStyle
    }
    
    lazy private var maskImageIncomingTail: UIImage = self.bubbleMasks.incomingTail()
    lazy private var maskImageIncomingNoTail: UIImage = self.bubbleMasks.incomingNoTail()
    lazy private var maskImageOutgoingTail: UIImage = self.bubbleMasks.outgoingTail()
    lazy private var maskImageOutgoingNoTail: UIImage = self.bubbleMasks.outgoingNoTail()
    
    
    lazy private var pauseIcon: UIImage = {
        return UIImage(named: "pause_icon", in: Bundle(for: Class.self), compatibleWith: nil)!
    }()
    
    lazy private var playIcon: UIImage = {
        return UIImage(named: "play_icon", in: Bundle(for: Class.self), compatibleWith: nil)!
    }()
    
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
    
    open func bubbleSize(viewModel: AudioMessageViewModelProtocol) -> CGSize {
        return self.sizes.audioSizePortrait
    }
    open func overlayColor(viewModel: AudioMessageViewModelProtocol) -> UIColor? {
        let showsOverlay = (viewModel.transferStatus.value == .transfering || viewModel.status == MessageViewModelStatus.sending || viewModel.status == MessageViewModelStatus.failed)
        return showsOverlay ? UIColor.black.withAlphaComponent(0.70) : nil
    }
    
    // Functions for Styling Link Preview
    
    func linkPreviewImageHolder(viewModel: LinkMessageViewModelProtocol) -> UIImage {
        <#code#>
    }
    
    func linkPreviewTitleTextColor(viewModel: LinkMessageViewModelProtocol) -> UIColor {
        <#code#>
    }
    
    func linkPreviewDescriptionTextColor(viewModel: LinkMessageViewModelProtocol) -> UIColor {
        <#code#>
    }
    
    func textFont(viewModel: LinkMessageViewModelProtocol, isSelected: Bool) -> UIFont {
        <#code#>
    }
    
    func textColor(viewModel: LinkMessageViewModelProtocol, isSelected: Bool) -> UIColor {
        return viewModel.isIncoming ? self.incomingColor : self.outgoingColor
    }
    
    func baseColor(viewModel: LinkMessageViewModelProtocol) -> UIColor {
        <#code#>
    }
    
    func textInsets(viewModel: LinkMessageViewModelProtocol, isSelected: Bool) -> UIEdgeInsets {
        <#code#>
    }
}
