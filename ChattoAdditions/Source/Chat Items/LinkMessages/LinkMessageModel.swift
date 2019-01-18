//
//  LinkMessageModel.swift
//  Chatto
//
//  Created by Vidit Paliwal on 11/01/19.
//

import Foundation
import Chatto

public protocol LinkMessageModelProtocol:DecoratedMessageModelProtocol{
    
    // Declare variables to be used to display Data in Custom Cell
    var previewImageUrl : String { get }
    var previewHeader : String { get }
    var previewDescription : String { get }
    var messageText : String { get }
    var linkUrl : String { get }
    var canonicalUrl : String { get }
}

open class LinkMessageModel<MessageModelT: MessageModelProtocol>: LinkMessageModelProtocol
{
    public var messageText: String
    
    public var messageModel: MessageModelProtocol {
        return self._messageModel
    }
    public let _messageModel: MessageModelT
    public var previewImageUrl : String
    public var previewHeader : String
    public var previewDescription : String
    
    public var linkUrl : String
    public var canonicalUrl : String
    
    static var chatItemType: ChatItemType {
        return "LinkMessageModel"
    }
    
    // Initialize Class Constructor
    public init(messageModel : MessageModelT, linkTitle: String, linkDescription: String, linkImageUrl: String, linkUrl: String, canonicalUrl: String, messageText: String)
    {
        self._messageModel = messageModel
        self.previewImageUrl = linkImageUrl
        self.previewHeader = linkTitle
        self.previewDescription = linkDescription
        self.messageText = messageText
        self.linkUrl = linkUrl
        self.canonicalUrl = canonicalUrl
        print("Title -> \(linkTitle)")
        print("Description -> \(linkDescription)")
        print("ImageUrl -> \(linkImageUrl)")
        print("Canonical Url -> \(canonicalUrl)")
        print("Message Text -> \(messageText)")
    }
}
