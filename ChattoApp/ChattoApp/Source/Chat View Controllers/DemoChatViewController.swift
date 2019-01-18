/*
 The MIT License (MIT)

 Copyright (c) 2015-present Badoo Trading Limited.

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
*/

import UIKit
import Chatto
import ChattoAdditions

class DemoChatViewController: BaseChatViewController {

    var messageSender: DemoChatMessageSender!
    let messagesSelector = BaseMessagesSelector()

    var dataSource: DemoChatDataSource! {
        didSet {
            self.chatDataSource = self.dataSource
            self.messageSender = self.dataSource.messageSender
        }
    }

    lazy private var baseMessageHandler: BaseMessageHandler = {
        return BaseMessageHandler(messageSender: self.messageSender, messagesSelector: self.messagesSelector)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Chat"
        self.messagesSelector.delegate = self
        self.chatItemsDecorator = DemoChatItemsDecorator(messagesSelector: self.messagesSelector)
    }

    var chatInputPresenter: BasicChatInputBarPresenter!
    override func createChatInputView() -> UIView {
        let chatInputView = ChatInputBar.loadNib()
        var appearance = ChatInputBarAppearance()
        appearance.sendButtonAppearance.title = NSLocalizedString("Send", comment: "")
        appearance.textInputAppearance.placeholderText = NSLocalizedString("Type a message", comment: "")
        self.chatInputPresenter = BasicChatInputBarPresenter(chatInputBar: chatInputView, chatInputItems: self.createChatInputItems(), chatInputBarAppearance: appearance)
        chatInputView.maxCharactersCount = 1000
        return chatInputView
    }

    override func createPresenterBuilders() -> [ChatItemType: [ChatItemPresenterBuilderProtocol]] {

        BaseMessageCollectionViewCellAvatarStyle.defaultOutgoingColor = UIColor.black
        
        // used for base message background + text background
        let baseMessageStyle = BaseMessageCollectionViewCellAvatarStyle()
        baseMessageStyle.baseColorOutgoing = UIColor.black
        
        let textMessagePresenter = TextMessagePresenterBuilder(
            viewModelBuilder: DemoTextMessageViewModelBuilder(),
            interactionHandler: DemoTextMessageHandler(baseHandler: self.baseMessageHandler)
        )
        textMessagePresenter.baseMessageStyle = baseMessageStyle

        let photoMessagePresenter = PhotoMessagePresenterBuilder(
            viewModelBuilder: DemoPhotoMessageViewModelBuilder(),
            interactionHandler: DemoPhotoMessageHandler(baseHandler: self.baseMessageHandler)
        )
        photoMessagePresenter.baseCellStyle = baseMessageStyle
        
        let audioMessagePresenter = AudioMessagePresenterBuilder(
            viewModelBuilder: DemoAudioMessageViewModelBuilder(),
            interactionHandler: DemoAudioMessageHandler(baseHandler: self.baseMessageHandler)
        )
        audioMessagePresenter.baseCellStyle = baseMessageStyle
        
        let linkMessagePresenter = LinkMessagePresenterBuilder(viewModelBuilder: DemoLinkMessageViewModelBuilder(), interactionHandler: DemoLinkMessageHandler(baseHandler: self.baseMessageHandler))
        
        linkMessagePresenter.baseCellStyle = baseMessageStyle
        

        return [
            DemoTextMessageModel.chatItemType: [textMessagePresenter],
            DemoPhotoMessageModel.chatItemType: [photoMessagePresenter],
            DemoAudioMessageModel.chatItemType: [audioMessagePresenter],
            DemoLinkMessageModel.chatItemType : [linkMessagePresenter],
            SendingStatusModel.chatItemType: [SendingStatusPresenterBuilder()],
            TimeSeparatorModel.chatItemType: [TimeSeparatorPresenterBuilder()]
        ]
    }

    func createChatInputItems() -> [ChatInputItemProtocol] {
        var items = [ChatInputItemProtocol]()
        items.append(self.createTextInputItem())
        items.append(self.createPhotoInputItem())
        return items
    }

    private func createTextInputItem() -> TextChatInputItem {
        let item = TextChatInputItem()
        item.textInputHandler = { [weak self] text in
            
            let inputText = text
            let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
            let matches = detector.matches(in: inputText, options: [], range: NSRange(location: 0, length: inputText.utf16.count))
            
            var firstUrl = ""
            for match in matches {
                guard let range = Range(match.range, in: inputText) else { continue }
                let url = inputText[range]
                firstUrl = String(url)
                print(url)
            }
            
            let slp = SwiftLinkPreview(session: URLSession.shared, workQueue: SwiftLinkPreview.defaultWorkQueue, responseQueue: DispatchQueue.main, cache: DisabledCache.instance)
            slp.preview(text, onSuccess: {result in
                print("\(result)")
                
                var resultFinal = SwiftLinkPreview.Response()
                resultFinal = result
                print(resultFinal.values)
                let title = resultFinal[.title] as? String ?? ""
                let description = resultFinal[.description] as? String ?? ""
                let imageUrl = resultFinal[.image] as? String ?? ""
                let url = resultFinal[.finalUrl] as? URL ?? URL(string: "no Url")
                var canonicalUrl = resultFinal[.canonicalUrl] as? String ?? ""
                let urlString = url?.absoluteString
                if canonicalUrl == ""
                {
                    canonicalUrl = (url?.host)!
                }
                self?.dataSource.addLinkPreviewMessage(linkTitle: title, linkDescription: description, linkImageUrl: imageUrl, linkUrl: urlString!, canonicalUrl: canonicalUrl, messageText: text)
                
            }, onError: { error in
                print("\(error)")
                self?.dataSource.addTextMessage(text)
            })
        }
        return item
    }

    private func createPhotoInputItem() -> PhotosChatInputItem {
        let item = PhotosChatInputItem(presentingController: self)
        item.photoInputHandler = { [weak self] image in
            self?.dataSource.addPhotoMessage(image)
        }
        return item
    }
}

extension DemoChatViewController: MessagesSelectorDelegate {
    func messagesSelector(_ messagesSelector: MessagesSelectorProtocol, didSelectMessage: MessageModelProtocol) {
        self.enqueueModelUpdate(updateType: .normal)
    }

    func messagesSelector(_ messagesSelector: MessagesSelectorProtocol, didDeselectMessage: MessageModelProtocol) {
        self.enqueueModelUpdate(updateType: .normal)
    }
}
