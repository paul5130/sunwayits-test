//
//  BottomLineView.swift
//  sunwayits
//
//  Created by Paul Wen on 2025/1/2.
//

import UIKit

class BottomLineView: UIView{
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .hotPink()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.layer.cornerRadius = 9
        label.clipsToBounds = true
        label.widthAnchor.constraint(greaterThanOrEqualToConstant: 18).isActive = true
        return label
    }()
    private let textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .textColor()
        return label
    }()
    private let bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .hotPink()
        view.layer.cornerRadius = 2
        view.clipsToBounds = true
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        widthAnchor.constraint(equalToConstant: 60).isActive = true
        heightAnchor.constraint(equalToConstant: 40).isActive = true
        addSubview(numberLabel)
        numberLabel.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 18)
        addSubview(textLabel)
        textLabel.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        textLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        addSubview(bottomLine)
        bottomLine.anchor(top: nil, left: textLabel.leftAnchor, bottom: bottomAnchor, right: textLabel.rightAnchor, paddingTop: 0, paddingLeft: 2, paddingBottom: 0, paddingRight: 2, width: 0, height: 4)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BottomLineView{
    func configure(text: String, numberString: String){
        textLabel.text = text
        numberLabel.text = numberString
    }
}

//import SwiftUI
//
//struct BottomLineView_Previews: PreviewProvider {
//    static var previews: some View{
//        ContainerView()
//            .previewLayout(.fixed(width: 60, height: 40))
//    }
//    struct ContainerView: UIViewRepresentable {
//        func updateUIView(_ uiView: UIViewType, context: Context) {
//            
//        }
//        func makeUIView(context: Context) -> some UIView {
//            BottomLineView()
//        }
//    }
//}
