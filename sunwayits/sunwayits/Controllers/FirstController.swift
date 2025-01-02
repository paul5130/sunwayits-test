//
//  FirstController.swift
//  sunwayits
//
//  Created by Paul Wen on 2025/1/2.
//

import UIKit

enum FriendState: Int {
    case noFriends = 0
    case friendWithoutInvites = 1
    case friendWithInvites = 2
}

class FirstController: UIViewController{
    private lazy var noFriendsButton = createButton(title: "無好友", tag: FriendState.noFriends.rawValue)
    private lazy var friendWithoutInvitesButton = createButton(title: "好友列表無邀請", tag: FriendState.friendWithoutInvites.rawValue)
    private lazy var friendWithInvitesButton = createButton(title: "好友列表含邀請列表", tag: FriendState.friendWithInvites.rawValue)
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.spacing = 30
        return sv
    }()
    
    @objc private func handleButton(button: UIButton) {
        guard let state = FriendState(rawValue: button.tag) else { return }
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(HomeController(state: state), animated: true)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    private func setupViews() {
        view.addSubview(stackView)
        view.backgroundColor = .white
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 200, paddingLeft: 30, paddingBottom: 200, paddingRight: 30, width: 0, height: 0)
        stackView.addArrangedSubview(noFriendsButton)
        stackView.addArrangedSubview(friendWithoutInvitesButton)
        stackView.addArrangedSubview(friendWithInvitesButton)
    }
    private func createButton(title: String, tag: Int) -> UIButton {
        let button = UIButton(type: .system)
        button.tag = tag
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        return button
    }
}

//import SwiftUI
//
//struct FirstController_Previews: PreviewProvider {
//    static var previews: some View{
//        ContainerView()
//    }
//    struct ContainerView: UIViewControllerRepresentable {
//        func makeUIViewController(context: Context) -> some UIViewController {
//            let navController = UINavigationController(rootViewController: FirstController())
//            return navController
//        }
//        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//
//        }
//    }
//}
