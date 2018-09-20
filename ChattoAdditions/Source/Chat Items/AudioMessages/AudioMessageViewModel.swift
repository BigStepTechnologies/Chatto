//
//  AudioMessageViewModel.swift
//  ChattoAdditions
//
//  Created by Ashish on 12/09/18.
//  Copyright © 2018 Badoo. All rights reserved.
//

public protocol AudioMessageViewModelProtocol: DecoratedMessageViewModelProtocol {
    var transferDirection: Observable<TransferDirection> { get set }
    var transferProgress: Observable<Double> { get  set } // in [0,1]
    var transferStatus: Observable<TransferStatus> { get set }
    var data: Observable<Data?> { get set }
    var duration: Double? { get set }
}

open class AudioMessageViewModel<AudioMessageModelT: AudioMessageModelProtocol>: AudioMessageViewModelProtocol {
    public var audioMessage: AudioMessageModelProtocol {
        return self._audioMessage
    }
    public let _audioMessage: AudioMessageModelT // Can't make audioMessage: AudioMessageModelT: https://gist.github.com/diegosanchezr/5a66c7af862e1117b556
    public var transferStatus: Observable<TransferStatus> = Observable(.idle)
    public var transferProgress: Observable<Double> = Observable(0)
    public var transferDirection: Observable<TransferDirection> = Observable(.download)
    public var data: Observable<Data?>
    public var duration: Double?
    public let messageViewModel: MessageViewModelProtocol
    open var isShowingFailedIcon: Bool {
        return self.messageViewModel.isShowingFailedIcon || self.transferStatus.value == .failed
    }
    
    public init(audioMessage: AudioMessageModelT, messageViewModel: MessageViewModelProtocol) {
        self._audioMessage = audioMessage
        self.data = Observable(audioMessage.data)
        self.duration = audioMessage.duration
        self.messageViewModel = messageViewModel
    }
    
    open func willBeShown() {
        // Need to declare empty. Otherwise subclass code won't execute (as of Xcode 7.2)
    }
    
    open func wasHidden() {
        // Need to declare empty. Otherwise subclass code won't execute (as of Xcode 7.2)
    }
}

open class AudioMessageViewModelDefaultBuilder<AudioMessageModelT: AudioMessageModelProtocol>: ViewModelBuilderProtocol {
    public init() {}
    
    let messageViewModelBuilder = MessageViewModelDefaultBuilder()
    
    open func createViewModel(_ model: AudioMessageModelT) -> AudioMessageViewModel<AudioMessageModelT> {
        let messageViewModel = self.messageViewModelBuilder.createMessageViewModel(model)
        let audioMessageViewModel = AudioMessageViewModel(audioMessage: model, messageViewModel: messageViewModel)
        return audioMessageViewModel
    }
    
    open func canCreateViewModel(fromModel model: Any) -> Bool {
        return model is AudioMessageModelT
    }
}
