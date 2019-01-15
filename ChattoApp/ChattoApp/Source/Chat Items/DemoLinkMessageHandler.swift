//
//  DemoLinkMessageHandler.swift
//  ChattoApp
//
//  Created by Vidit Paliwal on 14/01/19.
//  Copyright © 2019 Badoo. All rights reserved.
//

import Foundation
import ChattoAdditions

class DemoLinkMessageHandler: BaseMessageInteractionHandlerProtocol {
    private let baseHandler: BaseMessageHandler
    init (baseHandler: BaseMessageHandler) {
        self.baseHandler = baseHandler
    }
    
    func userDidTapOnFailIcon(viewModel: DemoPhotoMessageViewModel, failIconView: UIView) {
        self.baseHandler.userDidTapOnFailIcon(viewModel: viewModel)
    }
    
    func userDidTapOnAvatar(viewModel: DemoPhotoMessageViewModel) {
        self.baseHandler.userDidTapOnAvatar(viewModel: viewModel)
    }
    
    func userDidTapOnBubble(viewModel: DemoPhotoMessageViewModel) {
        self.baseHandler.userDidTapOnBubble(viewModel: viewModel)
    }
    
    func userDidBeginLongPressOnBubble(viewModel: DemoPhotoMessageViewModel) {
        self.baseHandler.userDidBeginLongPressOnBubble(viewModel: viewModel)
    }
    
    func userDidEndLongPressOnBubble(viewModel: DemoPhotoMessageViewModel) {
        self.baseHandler.userDidEndLongPressOnBubble(viewModel: viewModel)
    }
    
    func userDidSelectMessage(viewModel: DemoPhotoMessageViewModel) {
        self.baseHandler.userDidSelectMessage(viewModel: viewModel)
    }
    
    func userDidDeselectMessage(viewModel: DemoPhotoMessageViewModel) {
        self.baseHandler.userDidDeselectMessage(viewModel: viewModel)
    }
}

