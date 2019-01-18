//
//  DemoLinkMessageModel.swift
//  ChattoApp
//
//  Created by Vidit Paliwal on 14/01/19.
//  Copyright © 2019 Badoo. All rights reserved.
//

import Foundation
import Chatto
import ChattoAdditions

public class DemoLinkMessageModel: LinkMessageModel<MessageModel>, DemoMessageModelProtocol {
    
    override init(messageModel: MessageModel, linkTitle: String, linkDescription: String, linkImageUrl: String, linkUrl: String, canonicalUrl: String, messageText: String)
    {
        super.init(messageModel: messageModel, linkTitle: linkTitle, linkDescription: linkDescription, linkImageUrl: linkImageUrl, linkUrl: linkUrl, canonicalUrl: canonicalUrl, messageText: messageText)
    }
    
    public var status: MessageStatus {
        get {
            return self._messageModel.status
        }
        set {
            self._messageModel.status = newValue
        }
    }
}
