//
//  AudioBubbleView.swift
//  ChattoAdditions
//
//  Created by Ashish on 12/09/18.
//  Copyright © 2018 Badoo. All rights reserved.
//

public protocol AudioBubbleViewStyleProtocol {
    func maskingImage(viewModel: AudioMessageViewModelProtocol) -> UIImage
    func borderImage(viewModel: AudioMessageViewModelProtocol) -> UIImage?
    func playIconImage(viewModel: AudioMessageViewModelProtocol) -> UIImage
    func pauseIconImage(viewModel: AudioMessageViewModelProtocol) -> UIImage
    func audioViewTintColot(viewModel: AudioMessageViewModelProtocol) -> UIColor
    func bubbleSize(viewModel: AudioMessageViewModelProtocol) -> CGSize
}

public class AudioBubbleView: UIView, MaximumLayoutWidthSpecificable, BackgroundSizingQueryable {
    
    public var viewContext: ViewContext = .normal
    public var animationDuration: CFTimeInterval = 0.33
    public var preferredMaxLayoutWidth: CGFloat = 0
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        self.autoresizesSubviews = false
        //self.addSubview(self.audioButton)
        self.addSubview(self.bubbleImageView)
        //self.addSubview(self.progressView)
        //self.addSubview(self.durationLabel)
        self.contentMode = .center
    }
    
    private var borderImageView: UIImageView = UIImageView()
    private lazy var bubbleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.addSubview(self.borderImageView)
        return imageView
    }()
    
    private lazy var audioButton: UIImageView = {
        let iconView = UIImageView()
        iconView.contentMode = .scaleAspectFit
        iconView.sizeToFit()
        return iconView
    }()
    
    private lazy var progressView: UIProgressView = {
        let voiceView = UIProgressView()
        voiceView.progressViewStyle = .default
        voiceView.sizeToFit()
        return voiceView
    }()
    
    private lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red:0.62, green:0.62, blue:0.62, alpha:1.00)
        label.font = label.font.withSize(14)
        
        return label
    }()
    
    var audioMessageViewModel: AudioMessageViewModelProtocol! {
        didSet {
            self.updateViews()
        }
    }
    
    var audioMessageViewStyle: AudioBubbleViewStyleProtocol! {
        didSet {
            self.updateViews()
        }
    }
    
    public private(set) var isUpdating: Bool = false
    public func performBatchUpdates(updateClosure: @escaping () -> Void, animated: Bool, completion: (() ->())?) {
        self.isUpdating = true
        let updateAndRefreshViews = {
            updateClosure()
            self.isUpdating = false
            self.updateViews()
            if animated {
                self.layoutIfNeeded()
            }
        }
        if animated {
            UIView.animate(withDuration: self.animationDuration, animations: updateAndRefreshViews, completion: { (finished) -> Void in
                completion?()
            })
        } else {
            updateAndRefreshViews()
        }
    }
    
    public func updateViews() {
        if self.viewContext == .sizing { return }
        if isUpdating { return }
        guard let viewModel = self.audioMessageViewModel, let style = self.audioMessageViewStyle else { return }
//        self.audioButton.image = style.playIconImage(viewModel: viewModel)
        self.borderImageView.image = style.borderImage(viewModel: viewModel)
        self.bubbleImageView.layer.mask = UIImageView(image: style.maskingImage(viewModel: viewModel)).layer
//        self.durationLabel.text = "0:00"
    }
    
    public func playAudio() {
        // make the audio to start
    }
    
    // MARK: Layout
    public override func layoutSubviews() {
        super.layoutSubviews()
        let layout = self.calculateAudioBubbleLayout(maximumWidth: self.preferredMaxLayoutWidth)
        self.bubbleImageView.bma_rect = layout.bubbleFrame
        self.borderImageView.bma_rect = self.bubbleImageView.bounds
        self.bubbleImageView.layer.mask?.frame = self.bubbleImageView.layer.bounds
//        self.audioButton.frame = layout.iconFrame
//        self.progressView.frame = layout.progressViewFrame
//        self.durationLabel.frame = layout.progressLableFrame
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        return self.calculateAudioBubbleLayout(maximumWidth: size.width).size
    }
    
    public var canCalculateSizeInBackground: Bool {
        return true
    }
    
    // MARK: Private Helper Methods
    private func updateAudioView() {
        
    }
    
    private func calculateAudioBubbleLayout(maximumWidth: CGFloat) -> AudioBubbleLayoutModel {
        let layoutContext = AudioBubbleLayoutModel.LayoutContext(audioMessageViewModel: self.audioMessageViewModel, style: self.audioMessageViewStyle, containerWidth: maximumWidth)
        let layoutModel = AudioBubbleLayoutModel(layoutContext: layoutContext)
        layoutModel.calculateLayout()
        
        return layoutModel
    }
    
    private func timeStampString(currentTime: TimeInterval, duration: TimeInterval) -> String {
        // print the time as 0:ss or ss.x up to 59 seconds
        // print the time as m:ss up to 59:59 seconds
        // print the time as h:mm:ss for anything longer
        if (duration < 60) {
            
            if (currentTime < duration) {
                return String.init(format: "0:%02d",Int(round(currentTime)))
            }
            return String.init(format: "0:%02d",Int(ceil(currentTime)))
        }
        else if (duration < 3600) {
            return String.init(format: "%d:%02d",Int(currentTime) / 60, Int(currentTime) % 60)
        }
        return String.init(format: "%d:%02d:%02d",Int(currentTime) / 3600,Int(currentTime) / 60, Int(currentTime) % 60)
    }
}


private class AudioBubbleLayoutModel {
    var bubbleFrame:CGRect = CGRect.zero
    var iconFrame: CGRect = CGRect.zero
    var progressViewFrame: CGRect = CGRect.zero
    var progressLableFrame: CGRect = CGRect.zero
    var size: CGSize = CGSize.zero
    
    struct LayoutContext {
        let duration:String
        let bubbleSize: CGSize
        let preferredMaxLayoutWidth: CGFloat
        let iconSize: CGSize
        
        init(duration:String,
             bubbleSize: CGSize,
             iconSize: CGSize,
             preferredMaxLayoutWidth width: CGFloat) {
            self.duration = duration
            self.bubbleSize = bubbleSize
            self.iconSize = iconSize
            self.preferredMaxLayoutWidth = width
        }
        
        init(audioMessageViewModel model: AudioMessageViewModelProtocol,
             style: AudioBubbleViewStyleProtocol,
             containerWidth width: CGFloat) {
            self.init(duration: "00:00",
                      bubbleSize: style.bubbleSize(viewModel: model),
                      iconSize: style.playIconImage(viewModel: model).size,
                      preferredMaxLayoutWidth: width)
        }
    }
    
    let layoutContext: LayoutContext
    init(layoutContext: LayoutContext) {
        self.layoutContext = layoutContext
    }
    
    func calculateLayout() {
        let size = self.layoutContext.bubbleSize
        self.bubbleFrame = CGRect(origin: .zero, size: size)
        let labelFrame = CGRect(x: size.width - 24 - 5, y: size.height/2, width: 24, height: 18)
        let xOffset:CGFloat = 40 + 10
        let width = labelFrame.origin.x - xOffset - 5;
        self.progressLableFrame = labelFrame
        self.progressViewFrame = CGRect(x: xOffset, y: (size.height-15)/2, width: width, height: 15)
        self.iconFrame = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.size = size
    }

}
