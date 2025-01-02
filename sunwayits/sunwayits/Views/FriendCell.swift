//
//  FriendCell.swift
//  sunwayits
//
//  Created by Paul Wen on 2024/12/31.
//

import UIKit

struct FriendCellViewModel{
    let id: String
    let name: String
    let updateDate: String
    let showStar: Bool
    let friendStatus: FriendStatus
    enum FriendStatus: Int, Decodable{
        case sent = 0
        case completed = 1
        case pending = 2
        case unknown = -1
    }
    init(friend: Friend) {
        self.id = friend.fid
        self.name = friend.name
        self.updateDate = friend.updateDate
        self.showStar = friend.isTop == "1"
        self.friendStatus = FriendStatus(rawValue: friend.status) ?? .unknown
    }
}

class FriendCell: UITableViewCell{
    private let starView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage.star()
        return iv
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
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textColor()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    private let transferButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("轉帳", for: .normal)
        button.widthAnchor.constraint(equalToConstant: 47).isActive = true
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.setTitleColor(.hotPink(), for: .normal)
        button.layer.borderColor = UIColor.hotPink().cgColor
        button.layer.borderWidth = 1
        return button
    }()
    private let invitingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("邀請中", for: .normal)
        button.widthAnchor.constraint(equalToConstant: 60).isActive = true
        button.setTitleColor(.lightGrey(), for: .normal)
        button.layer.borderColor = UIColor.lightGrey().cgColor
        button.layer.borderWidth = 1
        return button
    }()
    private let threeDotButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.icMore.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 10
        return sv
    }()
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .bottomLineColor()
        return view
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        heightAnchor.constraint(equalToConstant: 60).isActive = true
        addSubview(starView)
        starView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 30, paddingBottom: 0, paddingRight: 0, width: 14, height: 14)
        starView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        addSubview(avatarView)
        avatarView.anchor(top: topAnchor, left: starView.rightAnchor, bottom: bottomAnchor, right: nil, paddingTop: 10, paddingLeft: 6, paddingBottom: 10, paddingRight: 0, width: 40, height: 40)
        addSubview(stackView)
        stackView.anchor(top: nil, left: avatarView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 30, width: 0, height: 24)
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(transferButton)
//        stackView.addArrangedSubview(createEmptyView(width: 10))
        stackView.addArrangedSubview(invitingButton)
//        stackView.addArrangedSubview(createEmptyView(width: 30))
        stackView.addArrangedSubview(threeDotButton)
        addSubview(lineView)
        lineView.anchor(top: nil, left: nameLabel.leftAnchor, bottom: bottomAnchor, right: stackView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func createEmptyView(width: CGFloat) -> UIView{
        let view = UIView()
        view.widthAnchor.constraint(equalToConstant: width).isActive = true
        return view
    }
}
extension FriendCell{
    func configure(with model: FriendCellViewModel){
        nameLabel.text = model.name
        starView.alpha = model.showStar ? 1 : 0
        threeDotButton.isHidden = model.friendStatus == .pending
        invitingButton.isHidden = model.friendStatus == .completed
    }
}

import SwiftUI

struct FriendCell_Previews: PreviewProvider {
    static var previews: some View{
        ContainerView()
            .previewLayout(.fixed(width: 375, height: 60))
    }
    struct ContainerView: UIViewRepresentable {
        func updateUIView(_ uiView: UIViewType, context: Context) {
            
        }
        func makeUIView(context: Context) -> some UIView {
            FriendCell()
        }
    }
}
