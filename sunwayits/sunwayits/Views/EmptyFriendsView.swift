//
//  EmptyFriendsView.swift
//  sunwayits
//
//  Created by Paul Wen on 2024/12/31.
//

import UIKit

class EmptyFriendsView: UIView{
    private let addFriendLabel: UILabel = {
        let label = UILabel()
        label.text = "就從加好友開始吧：）"
        label.textColor = .textColor()
        label.font = .systemFont(ofSize: 21, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let descLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        var labelAttributes: [NSAttributedString.Key: Any] = [:]
        labelAttributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 14, weight: .regular)
        labelAttributes[NSAttributedString.Key.foregroundColor] = UIColor.lightGrey()
        let attributedText = NSMutableAttributedString(string: "與好友們一起用 KOKO 聊起來！\n還能互相收付款、發紅包喔：）",attributes: labelAttributes)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        paragraphStyle.alignment = .center
        let range = NSMakeRange(0, attributedText.length)
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
        label.attributedText = attributedText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let bottomLabel: UILabel = {
        let label = UILabel()
        var labelAttributes: [NSAttributedString.Key: Any] = [:]
        labelAttributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 13, weight: .regular)
        labelAttributes[NSAttributedString.Key.foregroundColor] = UIColor.lightGrey()
        let attributedText = NSMutableAttributedString(string: "幫助好友更快找到你？",attributes: labelAttributes)
        
        attributedText.append(NSAttributedString(string: "設定 KOKO ID", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.hotPink(),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
        ]))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        paragraphStyle.alignment = .center
        let range = NSMakeRange(0, attributedText.length)
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
        label.attributedText = attributedText
        label.translatesAutoresizingMaskIntoConstraints = false
        
//        let attributedString = NSMutableAttributedString(string: "幫助好友更快找到你？設定 KOKO ID", attributes: [
//          .font: UIFont(name: "PingFangTC-Regular", size: 13.0)!,
//          .foregroundColor: UIColor.lightGrey,
//          .kern: 0.0
//        ])
//        attributedString.addAttribute(.foregroundColor, value: UIColor.hotPink, range: NSRange(location: 10, length: 10))
        return label
    }()
    private let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = .imgFriendsEmpty.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFit
        iv.widthAnchor.constraint(equalToConstant: 245).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 172).isActive = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    private let addFriendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("加好友", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.widthAnchor.constraint(equalToConstant: 192).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        let imageView = UIImageView()
        imageView.image = .icAddFriendWhite
        button.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.rightAnchor.constraint(equalTo: button.rightAnchor, constant: -15).isActive = true
        imageView.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = button.bounds
        gradientLayer.colors = [UIColor.frogGreen().cgColor,UIColor.booger().cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        button.layer.insertSublayer(gradientLayer, at: 0)
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backgroundImageView)
        backgroundImageView.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        backgroundImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        addSubview(addFriendLabel)
        addFriendLabel.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 40).isActive = true
        addFriendLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        addSubview(descLabel)
        descLabel.topAnchor.constraint(equalTo: addFriendLabel.bottomAnchor, constant: 8).isActive = true
        descLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        addSubview(addFriendButton)
        addFriendButton.topAnchor.constraint(equalTo: descLabel.bottomAnchor,constant: 30).isActive = true
        addFriendButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        addSubview(bottomLabel)
        bottomLabel.topAnchor.constraint(equalTo: addFriendButton.bottomAnchor,constant: 37).isActive = true
        bottomLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if let gradientLayer = addFriendButton.layer.sublayers?.first as? CAGradientLayer{
            gradientLayer.frame = addFriendButton.bounds
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

import SwiftUI

struct CommentHeaderView_Previews: PreviewProvider {
    static var previews: some View{
        ContainerView()
            .previewLayout(.fixed(width: 375, height: 445))
    }
    struct ContainerView: UIViewRepresentable {
        func updateUIView(_ uiView: UIViewType, context: Context) {
            
        }
        func makeUIView(context: Context) -> some UIView {
            EmptyFriendsView()
        }
    }
}

