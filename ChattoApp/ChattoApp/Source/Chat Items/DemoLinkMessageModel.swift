//
//  DemoLinkMessageModel.swift
//  ChattoApp
//
//  Created by Vidit Paliwal on 14/01/19.
//  Copyright © 2019 Badoo. All rights reserved.
//

import Foundation
import ChattoAdditions

public class DemoLinkMessageModel: PhotoMessageModel<MessageModel>, DemoMessageModelProtocol {
    public var senderId: String
    
    public var isIncoming: Bool
    
    public var date: Date
    
    public var userDisplayName: String
    
    public var type: ChatItemType
    
    public var uid: String
    
    
    init(messageModel: MessageModel,image: UIImage?) {
        super.init(messageModel: messageModel,imageType: .normal,image:image )
    }
    
    init(messageModel: MessageModel,url:URL?) {
        super.init(messageModel: messageModel,imageType: .video,imageUrl:url )
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
