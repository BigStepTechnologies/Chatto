//
//  LinkMessageCollectionViewCell.swift
//  Chatto
//
//  Created by Vidit Paliwal on 11/01/19.
//

import UIKit

public typealias LinkMessageCollectionViewCellStyleProtocol = LinkBubbleViewStyleProtocol

public final class LinkMessageCollectionViewCell: BaseMessageCollectionViewCell<LinkBubbleView> {
    
    public static func sizingCell() -> LinkMessageCollectionViewCell {
        let cell = LinkMessageCollectionViewCell(frame: CGRect.zero)
        cell.viewContext = .sizing
        return cell
    }
    
    public override func createBubbleView() -> LinkBubbleView {
        return LinkBubbleView()
    }
    
    override public var viewContext: ViewContext {
        didSet {
            self.bubbleView.viewContext = self.viewContext
        }
    }
    
    public var linkMessageViewModel: LinkMessageViewModelProtocol! {
        didSet {
            self.messageViewModel = self.linkMessageViewModel
            self.bubbleView.linkMessageViewModel = self.linkMessageViewModel
        }
    }
    
    public var linkMessageStyle: LinkMessageCollectionViewCellStyleProtocol! {
        didSet {
            self.bubbleView.linkMessageStyle = self.linkMessageStyle
        }
    }
    
    public override func performBatchUpdates(_ updateClosure: @escaping () -> Void, animated: Bool, completion: (() -> Void)?) {
        super.performBatchUpdates({ () -> Void in
            self.bubbleView.performBatchUpdates(updateClosure, animated: false, completion: nil)
        }, animated: animated, completion: completion)
    }
}
