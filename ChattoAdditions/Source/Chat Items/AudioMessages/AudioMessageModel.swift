//
//  AudioMessageModel.swift
//  ChattoAdditions
//
//  Created by Ashish on 12/09/18.
//  Copyright © 2018 Badoo. All rights reserved.
//

import Foundation

public protocol AudioMessageModelProtocol:DecoratedMessageModelProtocol{
    var data: Data? { get }
}

open class AudioMessageModel<MessageModelT: MessageModelProtocol>: AudioMessageModelProtocol {
    public var messageModel: MessageModelProtocol {
        return self._messageModel
    }
    public let _messageModel: MessageModelT // Can't make messasgeModel: MessageModelT: https://gist.github.com/diegosanchezr/5a66c7af862e1117b556
    public var data: Data?
    
    public init(messageModel: MessageModelT, data:Data? = nil) {
        self._messageModel = messageModel
        self.data = data
    }
}

