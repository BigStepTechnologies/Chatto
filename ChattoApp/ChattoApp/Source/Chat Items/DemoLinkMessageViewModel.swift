//
//  DemoLinkMessageViewModel.swift
//  ChattoApp
//
//  Created by Vidit Paliwal on 14/01/19.
//  Copyright © 2019 Badoo. All rights reserved.
//

import Foundation
import ChattoAdditions

class DemoLinkMessageViewModel: LinkMessageViewModel<DemoLinkMessageModel> {
    
    override init(linkMessage: DemoLinkMessageModel, messageViewModel: MessageViewModelProtocol) {
        super.init(linkMessage: linkMessage, messageViewModel: messageViewModel)
    }
    override func willBeShown() {
    }
}

extension DemoLinkMessageViewModel: DemoMessageViewModelProtocol {
    var messageModel: DemoMessageModelProtocol {
        return self._linkMessage
    }
}

class DemoLinkMessageViewModelBuilder: ViewModelBuilderProtocol {
    
    let messageViewModelBuilder = MessageViewModelDefaultBuilder()
    
    func createViewModel(_ model: DemoLinkMessageModel) -> DemoLinkMessageViewModel {
        let messageViewModel = self.messageViewModelBuilder.createMessageViewModel(model)
        let linkMessageViewModel = DemoLinkMessageViewModel(linkMessage: model, messageViewModel: messageViewModel)
        linkMessageViewModel.avatarImage.value = UIImage(named: "userAvatar")
        return linkMessageViewModel
    }
    
    func canCreateViewModel(fromModel model: Any) -> Bool {
        return model is DemoLinkMessageModel
    }
}
