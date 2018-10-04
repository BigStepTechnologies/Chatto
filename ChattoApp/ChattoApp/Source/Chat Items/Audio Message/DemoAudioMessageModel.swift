//
//  DemoAudioMessageModel.swift
//  ChattoApp
//
//  Created by Ashish on 20/09/18.
//  Copyright © 2018 Badoo. All rights reserved.
//

import ChattoAdditions

public class DemoAudioMessageModel: AudioMessageModel<MessageModel>, DemoMessageModelProtocol {
    
    init(messageModel: MessageModel,data: Data?) {
        super.init(messageModel: messageModel, data: data, duration: 00.00)
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
