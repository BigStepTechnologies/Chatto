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
    
    
}


//
//
//class LinkMessagePresenter: ChatItemPresenterProtocol {
//
//    let linkMessageModel: LinkMessageModel<<#MessageModelT: MessageModelProtocol#>>
//    init (linkMessageModel: LinkMessageModel<<#MessageModelT: MessageModelProtocol#>>) {
//        self.linkMessageModel = linkMessageModel
//    }
//
//    private static let cellReuseIdentifier = LinkMessageCollectionViewCell.self.description()
//
//    static func registerCells(_ collectionView: UICollectionView) {
//        collectionView.register(LinkMessageCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
//    }
//
//    func dequeueCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
//        return collectionView.dequeueReusableCell(withReuseIdentifier: LinkMessagePresenter.cellReuseIdentifier, for: indexPath)
//    }
//
//    func configureCell(_ cell: UICollectionViewCell, decorationAttributes: ChatItemDecorationAttributesProtocol?) {
//        guard let linkMessageCell = cell as? LinkMessageCollectionViewCell else {
//            assert(false, "expecting status cell")
//            return
//        }
//        linkMessageCell.linkHeaderString = self.linkMessageModel.previewHeader
//        linkMessageCell.linkDescriptionString = self.linkMessageModel.previewDescription
//        linkMessageCell.imageUrl = self.linkMessageModel.previewImageUrl
//        //timeSeparatorCell.text = self.timeSeparatorModel.date
//    }
//
//    var canCalculateHeightInBackground: Bool {
//        return true
//    }
//
//    func heightForCell(maximumWidth width: CGFloat, decorationAttributes: ChatItemDecorationAttributesProtocol?) -> CGFloat {
//        return 120
//    }
//}
