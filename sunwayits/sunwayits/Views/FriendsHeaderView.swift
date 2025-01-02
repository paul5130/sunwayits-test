//
//  FriendsHeaderView.swift
//  sunwayits
//
//  Created by Paul Wen on 2025/1/2.
//

import UIKit

class FriendsHeaderView: UIView{
    private let horizontalLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .bottomLineColor()
        return view
    }()
    private let searchBarView: SearchBarView = {
        let view = SearchBarView()
        return view
    }()
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 30
        return sv
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .backgroundColor()
        addSubview(horizontalLineView)
        horizontalLineView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 60, paddingRight: 0, width: 0, height: 1)
        addSubview(searchBarView)
        searchBarView.anchor(top: horizontalLineView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        addSubview(stackView)
        stackView.anchor(top: topAnchor, left: leftAnchor, bottom: horizontalLineView.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 0, height: 0)
        stackView.addArrangedSubview(BottomLineView())
        stackView.addArrangedSubview(BottomLineView())
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
            .previewLayout(.fixed(width: 375, height: 100))
    }
    struct ContainerView: UIViewRepresentable {
        func updateUIView(_ uiView: UIViewType, context: Context) {
            
        }
        func makeUIView(context: Context) -> some UIView {
            FriendsHeaderView()
        }
    }
}
