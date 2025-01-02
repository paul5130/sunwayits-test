//
//  SearchBarView.swift
//  sunwayits
//
//  Created by Paul Wen on 2025/1/1.
//

import UIKit

class SearchBarView: UIView{
    private lazy var searchView: UISearchBar = {
        let sb = UISearchBar()
        sb.delegate = self
        sb.placeholder = "想轉一筆給誰呢？"
        sb.searchBarStyle = .minimal
        return sb
    }()
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage.icAddFriendPurple.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        heightAnchor.constraint(equalToConstant: 60).isActive = true
        backgroundColor = .backgroundColor()
        addSubview(addButton)
        addButton.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 15, width: 24, height: 24)
        addButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        addSubview(searchView)
        searchView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: addButton.leftAnchor, paddingTop: 15, paddingLeft: 30, paddingBottom: 15, paddingRight: 15, width: 0, height: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchBarView: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NotificationCenter.default.post(name: .searchBarTextDidChange, object: nil, userInfo: ["searchText": searchText])
    }
    
}
extension Notification.Name{
    static let searchBarTextDidChange = Notification.Name("searchBarTextDidChange")
}
//import SwiftUI
//
//struct SearchBarView_Previews: PreviewProvider {
//    static var previews: some View{
//        ContainerView()
//            .previewLayout(.fixed(width: 375, height: 60))
//    }
//    struct ContainerView: UIViewRepresentable {
//        func updateUIView(_ uiView: UIViewType, context: Context) {
//            
//        }
//        func makeUIView(context: Context) -> some UIView {
//            SearchBarView()
//        }
//    }
//}
