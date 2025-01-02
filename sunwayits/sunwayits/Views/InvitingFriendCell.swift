//
//  InvitingFriendCell.swift
//  sunwayits
//
//  Created by Paul Wen on 2024/12/31.
//


import UIKit

class InvitingFriendCell: UITableViewCell{
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    private let checkButton: UIButton = {
        let button = UIButton(type: .system)
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.agree(), for: .normal)
        return button
    }()
    private let crossButton: UIButton = {
        let button = UIButton(type: .system)
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.delete(), for: .normal)
        return button
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textColor()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    private let invitingLabel: UILabel = {
        let label = UILabel()
        label.text = "邀請你成為好友：）"
        label.textColor = .lightGrey()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    private let avatarView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGrey()
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        view.widthAnchor.constraint(equalToConstant: 40).isActive = true
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let cardBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        backgroundColor = .backgroundColor()
        addSubview(cardBackgroundView)
        cardBackgroundView.layer.cornerRadius = 3
        cardBackgroundView.clipsToBounds = true
        cardBackgroundView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 30, paddingBottom: 5, paddingRight: 30, width: 0, height: 0)
        cardBackgroundView.addSubview(avatarView)
        avatarView.leftAnchor.constraint(equalTo: cardBackgroundView.leftAnchor, constant: 15).isActive = true
        avatarView.centerYAnchor.constraint(equalTo: cardBackgroundView.centerYAnchor).isActive = true
        cardBackgroundView.addSubview(crossButton)
        crossButton.rightAnchor.constraint(equalTo: cardBackgroundView.rightAnchor, constant: -15).isActive = true
        crossButton.centerYAnchor.constraint(equalTo: cardBackgroundView.centerYAnchor).isActive = true
        cardBackgroundView.addSubview(checkButton)
        checkButton.rightAnchor.constraint(equalTo: crossButton.leftAnchor, constant: -15).isActive = true
        checkButton.centerYAnchor.constraint(equalTo: cardBackgroundView.centerYAnchor).isActive = true
        cardBackgroundView.addSubview(stackView)
        stackView.anchor(top: cardBackgroundView.topAnchor, left: avatarView.rightAnchor, bottom: bottomAnchor, right: checkButton.leftAnchor, paddingTop: 15, paddingLeft: 15, paddingBottom: 15, paddingRight: 15, width: 0, height: 0)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(invitingLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InvitingFriendCell{
    func configure(with name: String){
        nameLabel.text = name
    }
}

//import SwiftUI
//
//struct InvitingFriendCell_Previews: PreviewProvider {
//    static var previews: some View{
//        ContainerView()
//            .previewLayout(.fixed(width: 315, height: 80))
//    }
//    struct ContainerView: UIViewRepresentable {
//        func updateUIView(_ uiView: UIViewType, context: Context) {
//            
//        }
//        func makeUIView(context: Context) -> some UIView {
//            InvitingFriendCell()
//        }
//    }
//}
