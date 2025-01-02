//
//  InvitingFriendsFooterView.swift
//  sunwayits
//
//  Created by Paul Wen on 2025/1/2.
//

import UIKit

class InvitingFriendsFooterView: UIView{
    private let horizontalLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .bottomLineColor()
        return view
    }()
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 30
        return sv
    }()
    private let bottomView1: BottomLineView = {
        let view = BottomLineView()
        view.configure(text: "好友", numberString: "2")
        return view
    }()
    private let bottomView2: BottomLineView = {
        let view = BottomLineView()
        view.configure(text: "聊天", numberString: " 99+ ")
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        heightAnchor.constraint(equalToConstant: 40).isActive = true
        backgroundColor = .backgroundColor()
        addSubview(horizontalLineView)
        horizontalLineView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 60, paddingRight: 0, width: 0, height: 1)
        addSubview(stackView)
        stackView.anchor(top: topAnchor, left: leftAnchor, bottom: horizontalLineView.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 0, height: 0)
        stackView.addArrangedSubview(bottomView1)
        stackView.addArrangedSubview(bottomView2)
        stackView.addArrangedSubview(UIView())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

import SwiftUI

struct FriendsHeaderView_Previews: PreviewProvider {
    static var previews: some View{
        ContainerView()
            .previewLayout(.fixed(width: 375, height: 40))
    }
    struct ContainerView: UIViewRepresentable {
        func updateUIView(_ uiView: UIViewType, context: Context) {
            
        }
        func makeUIView(context: Context) -> some UIView {
            InvitingFriendsFooterView()
        }
    }
}
