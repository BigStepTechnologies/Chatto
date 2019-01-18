//
//  LinkMessageViewModel.swift
//  ChattoAdditions
//
//  Created by Vidit Paliwal on 11/01/19.
//

import Foundation
public enum LinkPreviewStatus
{
    case notFetched
    case fetched
    case failed
}

public protocol LinkMessageViewModelProtocol : DecoratedMessageViewModelProtocol
{
    var fetchedStatus : Observable<LinkPreviewStatus> { get set }
    var previewImageUrl : String { get }
    var previewHeader : String { get }
    var previewDescription : String { get }
    var messageText : String { get }
    var linkUrl : String { get }
    var canonicalUrl : String { get }
}

open class LinkMessageViewModel<LinkMessageModelT : LinkMessageModelProtocol> : LinkMessageViewModelProtocol
{
    public var previewImageUrl: String {
        return self._linkMessage.previewImageUrl
    }
    
    public var previewHeader: String {
        return self._linkMessage.previewHeader
    }
    
    public var previewDescription: String {
        return self._linkMessage.previewDescription
    }
    
    public var messageText: String {
        return self._linkMessage.messageText
    }
    
    
    public var linkUrl : String {
        return self._linkMessage.linkUrl
    }
    
    public var canonicalUrl : String {
        return self._linkMessage.canonicalUrl
    }
    
    
    public let _linkMessage: LinkMessageModelT
    
    public var linkMessage: LinkMessageModelProtocol {
        return self._linkMessage
    }
    
    public var fetchedStatus: Observable<LinkPreviewStatus> = Observable(.notFetched)
    
    public var messageViewModel: MessageViewModelProtocol
    
    open var isShowingFailedIcon: Bool {
        return self.messageViewModel.isShowingFailedIcon || self.fetchedStatus.value == .failed
    }
    
    public init(linkMessage: LinkMessageModelT, messageViewModel: MessageViewModelProtocol) {
        self._linkMessage = linkMessage
        print("Testing Link -> \(linkMessage.previewDescription)")
        print("Testing Link -> \(linkMessage.previewHeader)")
        print("Testing Link -> \(linkMessage.previewImageUrl)")
        print("Testing Link -> \(linkMessage.messageText)")
        self.fetchedStatus = Observable(.notFetched)
        self.messageViewModel = messageViewModel
    }
    
    open func willBeShown() {
        // Need to declare empty. Otherwise subclass code won't execute (as of Xcode 7.2)
    }
    
    open func wasHidden() {
        // Need to declare empty. Otherwise subclass code won't execute (as of Xcode 7.2)
    }
}

open class LinkMessageViewModelDefaultBuilder<LinkMessageModelT: LinkMessageModelProtocol>: ViewModelBuilderProtocol {
    public init() {}
    
    let messageViewModelBuilder = MessageViewModelDefaultBuilder()
    
    open func createViewModel(_ model: LinkMessageModelT) -> LinkMessageViewModel<LinkMessageModelT> {
        let messageViewModel = self.messageViewModelBuilder.createMessageViewModel(model)
        let linkMessageViewModel = LinkMessageViewModel(linkMessage: model, messageViewModel: messageViewModel)
        return linkMessageViewModel
    }
    
    open func canCreateViewModel(fromModel model: Any) -> Bool {
        return model is LinkMessageModelT
    }
}
