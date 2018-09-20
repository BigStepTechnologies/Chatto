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
        self.addSubview(self.bubbleImageView)
        self.addSubview(self.progressView)
        self.addSubview(self.durationLabel)
    }
    
    private var borderImageView: UIImageView = UIImageView()
    private lazy var bubbleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.addSubview(self.borderImageView)
        return imageView
    }()
    
    private lazy var progressView: UIProgressView = {
        let voiceView = UIProgressView()
        voiceView.progressViewStyle = .default
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
        
        self.updateAudioView()
        self.durationLabel.text = "\(viewModel.duration)″"
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
        let voiceIconHeight: CGFloat = 15.0
        self.progressView.frame = CGRect(x:layout.bubbleFrame.width - 36, y:(layout.bubbleFrame.height - voiceIconHeight) / 2,width: voiceIconHeight, height: voiceIconHeight)
        self.durationLabel.frame = CGRect(x:-21, y:layout.bubbleFrame.height / 2, width:20, height:20)
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
}


private class AudioBubbleLayoutModel {
    var bubbleFrame: CGRect = CGRect.zero
    var size: CGSize = CGSize.zero
    
    struct LayoutContext {
        let bubbleSize: CGSize
        let preferredMaxLayoutWidth: CGFloat
        let iconSize: CGSize
        let timeLabelWidth: CGFloat
        let seekBarWidth:CGFloat
        
        init(bubbleSize: CGSize,
             iconSize: CGSize,
             seekBarWidth: CGFloat,
             timeLabelWidth: CGFloat,
             preferredMaxLayoutWidth width: CGFloat) {
            self.bubbleSize = bubbleSize
            self.iconSize = iconSize
            self.timeLabelWidth = timeLabelWidth
            self.seekBarWidth = seekBarWidth
            self.preferredMaxLayoutWidth = width
        }
        
        init(audioMessageViewModel model: AudioMessageViewModelProtocol,
             style: AudioBubbleViewStyleProtocol,
             containerWidth width: CGFloat) {
            self.init(bubbleSize: style.bubbleSize(viewModel: model),
                      iconSize: style.playIconImage(viewModel: model).size,
                      seekBarWidth: style.seekBarWidth(viewModel: model),
                      timeLabelWidth: style.timeLabelWidth(viewModel: model),
                      preferredMaxLayoutWidth: width)
        }
    }
    
    let layoutContext: LayoutContext
    init(layoutContext: LayoutContext) {
        self.layoutContext = layoutContext
    }
    
    func calculateLayout() {
        
    }
}
