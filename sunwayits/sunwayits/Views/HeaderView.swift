//
//  HeaderView.swift
//  sunwayits
//
//  Created by Paul Wen on 2025/1/1.
//

import UIKit

class HeaderView: UIView{
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textColor()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        return label
    }()
    private let idLabel: UILabel = {
        let label = UILabel()
        label.text = "設定 KOKO ID"
        label.textColor = .textColor()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    private let rightArrowImageView = {
        let iv = UIImageView()
        iv.image = .rightArrow().withRenderingMode(.alwaysOriginal)
        iv.widthAnchor.constraint(equalToConstant: 18).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 18).isActive = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    private let avatarImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = .defaultFemale.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFit
        iv.widthAnchor.constraint(equalToConstant: 54).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 54).isActive = true
        iv.layer.cornerRadius = 27
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        return iv
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        addSubview(avatarImageView)
        avatarImageView.rightAnchor.constraint(equalTo: rightAnchor,constant: -30).isActive = true
        avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        addSubview(nameLabel)
        nameLabel.anchor(top: avatarImageView.topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 30, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        addSubview(idLabel)
        idLabel.anchor(top: nameLabel.bottomAnchor, left: nameLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        addSubview(rightArrowImageView)
        rightArrowImageView.centerYAnchor.constraint(equalTo: idLabel.centerYAnchor).isActive = true
        rightArrowImageView.leftAnchor.constraint(equalTo: idLabel.rightAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HeaderView{
    func configure(with name: String,kokoId: String?){
        nameLabel.text = name
        idLabel.text = kokoId
    }
}

import SwiftUI

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View{
        ContainerView()
            .previewLayout(.fixed(width: 375, height: 80))
    }
    struct ContainerView: UIViewRepresentable {
        func updateUIView(_ uiView: UIViewType, context: Context) {
            
        }
        func makeUIView(context: Context) -> some UIView {
            HeaderView()
        }
    }
}
