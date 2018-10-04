//
//  DemoAudioMessageViewModel.swift
//  ChattoApp
//
//  Created by Ashish on 20/09/18.
//  Copyright © 2018 Badoo. All rights reserved.
//

import ChattoAdditions

class DemoAudioMessageViewModel: AudioMessageViewModel<DemoAudioMessageModel> {
    
    override init(audioMessage: DemoAudioMessageModel, messageViewModel: MessageViewModelProtocol) {
        super.init(audioMessage: audioMessage, messageViewModel: messageViewModel)
        
    }
    
    override func willBeShown() {
        // self.fakeProgress()
    }
    
}

extension DemoAudioMessageViewModel: DemoMessageViewModelProtocol {
    var messageModel: DemoMessageModelProtocol {
        return self._audioMessage
    }
}

class DemoAudioMessageViewModelBuilder: ViewModelBuilderProtocol {
    
    let messageViewModelBuilder = MessageViewModelDefaultBuilder()
    
    func createViewModel(_ model: DemoAudioMessageModel) -> DemoAudioMessageViewModel {
        let messageViewModel = self.messageViewModelBuilder.createMessageViewModel(model)
        let audioMessageViewModel = DemoAudioMessageViewModel(audioMessage: model, messageViewModel: messageViewModel)
        audioMessageViewModel.avatarImage.value = UIImage(named: "userAvatar")
        return audioMessageViewModel
    }
    
    func canCreateViewModel(fromModel model: Any) -> Bool {
        return model is DemoAudioMessageModel
    }
}
