//
//  LinkMessagePresenter.swift
//  ChattoAdditions
//
//  Created by Vidit Paliwal on 11/01/19.
//

import Foundation
import Chatto

open class LinkMessagePresenter<ViewModelBuilderT, InteractionHandlerT> : BaseMessagePresenter<LinkBubbleView, ViewModelBuilderT, InteractionHandlerT> where ViewModelBuilderT: ViewModelBuilderProtocol,
    ViewModelBuilderT.ViewModelT: LinkMessageViewModelProtocol,
    InteractionHandlerT: BaseMessageInteractionHandlerProtocol,
    InteractionHandlerT.ViewModelT == ViewModelBuilderT.ViewModelT
{
    public typealias ModelT = ViewModelBuilderT.ModelT
    public typealias ViewModelT = ViewModelBuilderT.ViewModelT
    
    public let linkCellStyle: LinkMessageCollectionViewCellStyleProtocol
    
    public init (
        messageModel: ModelT,
        viewModelBuilder: ViewModelBuilderT,
        interactionHandler: InteractionHandlerT?,
        sizingCell: LinkMessageCollectionViewCell,
        baseCellStyle: BaseMessageCollectionViewCellStyleProtocol,
        linkCellStyle: LinkMessageCollectionViewCellStyleProtocol) {
        self.linkCellStyle = linkCellStyle
        super.init(
            messageModel: messageModel,
            viewModelBuilder: viewModelBuilder,
            interactionHandler: interactionHandler,
            sizingCell: sizingCell,
            cellStyle: baseCellStyle
        )
        
    }
    
    public final override class func registerCells(_ collectionView: UICollectionView) {
        collectionView.register(LinkMessageCollectionViewCell.self, forCellWithReuseIdentifier: "link-message")
    }
    
    public final override func dequeueCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "link-message", for: indexPath)
    }
    
    public var linkCell: LinkMessageCollectionViewCell? {
        if let cell = self.cell {
            if let audioCell = cell as? LinkMessageCollectionViewCell {
                return audioCell
            } else {
                assert(false, "Invalid cell was given to presenter!")
            }
        }
        return nil
    }
    
    open override func configureCell(_ cell: BaseMessageCollectionViewCell<LinkBubbleView>, decorationAttributes: ChatItemDecorationAttributes, animated: Bool, additionalConfiguration: (() -> Void)?) {
        guard let cell = cell as? LinkMessageCollectionViewCell else {
            assert(false, "Invalid cell received")
            return
        }
        
        super.configureCell(cell, decorationAttributes: decorationAttributes, animated: animated) { () -> Void in
            cell.linkMessageViewModel = self.messageViewModel
            cell.linkMessageStyle = self.linkCellStyle
            additionalConfiguration?()
        }
    }
    
    public func updateCurrentCell() {
        if let cell = self.linkCell, let decorationAttributes = self.decorationAttributes {
            self.configureCell(cell, decorationAttributes: decorationAttributes, animated: self.itemVisibility != .appearing, additionalConfiguration: nil)
        }
    }
}
