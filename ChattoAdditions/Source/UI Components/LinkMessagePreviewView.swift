//
//  LinkMessagePreviewView.swift
//  ChattoAdditions
//
//  Created by Vidit Paliwal on 15/01/19.
//

//
import Foundation
import UIKit

open class LinkPreviewView : UIView
{
    private let imageHeight:CGFloat = 100
    private let linkTitleHeight:CGFloat = 20
    private let linkDescriptionHeight : CGFloat = 40
    private let maxWidth:CGFloat = 210
    
    init(){
        super.init(frame: .zero)
        setupContainerView()
        createConstraints()
        self.previewContainer.frame = self.frame
    }
    
    private var previewContainer : UIStackView = {
        let view = UIStackView()
        return view
    }()
    
    open var linkImageView : UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    open var linkTitleLabel : UILabel = {
        let label = UILabel()
        label.text = "test"
        return label
    }()
    
    open var linkDescription : UILabel = {
        let label = UILabel()
        label.text = "Test Description"
        return label
    }()
    
    private func setupContainerView(){
        previewContainer.axis = .vertical
        previewContainer.isBaselineRelativeArrangement = true
        previewContainer.spacing = 5.0
        previewContainer.addArrangedSubview(linkImageView)
        previewContainer.addArrangedSubview(linkTitleLabel)
        previewContainer.addArrangedSubview(linkDescription)
    }
    
    private func createConstraints() {
        previewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: previewContainer.topAnchor),
            bottomAnchor.constraint(equalTo: previewContainer.bottomAnchor),
            previewContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            previewContainer.widthAnchor.constraint(equalToConstant: maxWidth),
            previewContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            linkImageView.widthAnchor.constraint(equalToConstant: imageHeight),
            linkImageView.heightAnchor.constraint(equalToConstant: maxWidth),
            linkTitleLabel.widthAnchor.constraint(equalToConstant: maxWidth),
            linkTitleLabel.heightAnchor.constraint(equalToConstant: linkTitleHeight),
            linkDescription.widthAnchor.constraint(equalToConstant: maxWidth),
            linkDescription.heightAnchor.constraint(equalToConstant: linkDescriptionHeight)
            ])
    }
    
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


