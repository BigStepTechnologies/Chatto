//
//  LinkMessagePresenterBuilder.swift
//  ChattoAdditions
//
//  Created by Vidit Paliwal on 11/01/19.
//

import Foundation
import Chatto

open class LinkMessagePresenterBuilder<ViewModelBuilderT, InteractionHandlerT> : ChatItemPresenterBuilderProtocol where
    ViewModelBuilderT: ViewModelBuilderProtocol,
    ViewModelBuilderT.ViewModelT: LinkMessageViewModelProtocol,
    InteractionHandlerT: BaseMessageInteractionHandlerProtocol,
    InteractionHandlerT.ViewModelT == ViewModelBuilderT.ViewModelT
{
    public typealias ModelT = ViewModelBuilderT.ModelT
    public typealias ViewModelT = ViewModelBuilderT.ViewModelT
    
    public init(
        viewModelBuilder: ViewModelBuilderT,
        interactionHandler: InteractionHandlerT?) {
        self.viewModelBuilder = viewModelBuilder
        self.interactionHandler = interactionHandler
    }
    
    public let viewModelBuilder: ViewModelBuilderT
    public let interactionHandler: InteractionHandlerT?
    
    public func canHandleChatItem(_ chatItem: ChatItemProtocol) -> Bool {
        return self.viewModelBuilder.canCreateViewModel(fromModel: chatItem)
    }
    
    public let sizingCell: LinkMessageCollectionViewCell = LinkMessageCollectionViewCell.sizingCell()
    public lazy var linkCellStyle: LinkMessageCollectionViewCellDefaultStyle = LinkMessageCollectionViewCellDefaultStyle()
    
    public lazy var baseCellStyle: BaseMessageCollectionViewCellStyleProtocol = BaseMessageCollectionViewCellDefaultStyle()
    
    public func createPresenterWithChatItem(_ chatItem: ChatItemProtocol) -> ChatItemPresenterProtocol {
        assert(self.canHandleChatItem(chatItem))
        return LinkMessagePresenter<ViewModelBuilderT, InteractionHandlerT>(
            messageModel: chatItem as! ModelT,
            viewModelBuilder: self.viewModelBuilder,
            interactionHandler: self.interactionHandler,
            sizingCell: sizingCell,
            baseCellStyle: self.baseCellStyle,
            linkCellStyle: self.linkCellStyle
        )
    }
    
    public var presenterType: ChatItemPresenterProtocol.Type {
        return LinkMessagePresenter<ViewModelBuilderT, InteractionHandlerT>.self
    }
}



