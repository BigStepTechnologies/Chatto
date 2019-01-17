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
    init(messageModel: MessageModel,titleText:String,titleDescription:String,imageUrl:String,mainUrl:String) {
        super.init(messageModel: messageModel, previewImageUrl: imageUrl, previewHeader: titleText, previewDescription: titleDescription, messageText: mainUrl)
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
