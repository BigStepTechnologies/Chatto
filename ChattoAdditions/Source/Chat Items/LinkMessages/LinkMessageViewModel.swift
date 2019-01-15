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
    var previewHeader : Observable<String> { get set }
    var previewDescription : Observable<String> { get set }
    var previewImageUrl : Observable<String> { get set }
}

open class LinkMessageViewModel<LinkMessageModelT : LinkMessageModelProtocol> : LinkMessageViewModelProtocol
{
    public let _linkMessage: LinkMessageModelT
    
    public var linkMessage: LinkMessageModelProtocol {
        return self._linkMessage
    }
    
    public var fetchedStatus: Observable<LinkPreviewStatus> = Observable(.notFetched)
    
    public var previewHeader: Observable<String>
    
    public var previewDescription: Observable<String>
    
    public var previewImageUrl: Observable<String>
    
    public var messageViewModel: MessageViewModelProtocol
    
    open var isShowingFailedIcon: Bool {
        return self.messageViewModel.isShowingFailedIcon || self.fetchedStatus.value == .failed
    }
    
    public init(linkMessage: LinkMessageModelT, messageViewModel: MessageViewModelProtocol) {
        self._linkMessage = linkMessage
        self.fetchedStatus = Observable(.notFetched)
        self.previewHeader = Observable(linkMessage.previewHeader)
        self.previewDescription = Observable(linkMessage.previewDescription)
        self.previewImageUrl = Observable(linkMessage.previewImageUrl)
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
