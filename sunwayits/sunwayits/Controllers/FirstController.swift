//
//  FirstController.swift
//  sunwayits
//
//  Created by Paul Wen on 2025/1/2.
//

import UIKit

enum FriendState{
    case noFriends
    case friendWithInvites
    case friendWithoutInvites
}

class FirstController: UIViewController{
    private lazy var noFriendsButton: UIButton = {
        let button = UIButton(type: .system)
        button.tag = 0
        button.setTitle("無好友", for: .normal)
        button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        return button
    }()
    private lazy var friendWithoutInvitesButton: UIButton = {
        let button = UIButton(type: .system)
        button.tag = 1
        button.setTitle("好友列表無邀請", for: .normal)
        button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        return button
    }()
    private lazy var friendWithInvitesButton: UIButton = {
        let button = UIButton(type: .system)
        button.tag = 2
        button.setTitle("好友列表含邀請列表", for: .normal)
        button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        return button
    }()
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.spacing = 30
        return sv
    }()
    @objc private func handleButton(button: UIButton){
        var state = FriendState.noFriends
        if button.tag == 0{
            state = .noFriends
        }
        if button.tag == 1{
            state = .friendWithoutInvites
        }
        if button.tag == 2{
            state = .friendWithInvites
        }
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(HomeController(state: state), animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stackView)
        view.backgroundColor = .white
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 200, paddingLeft: 30, paddingBottom: 200, paddingRight: 30, width: 0, height: 0)
        stackView.addArrangedSubview(noFriendsButton)
        stackView.addArrangedSubview(friendWithoutInvitesButton)
        stackView.addArrangedSubview(friendWithInvitesButton)
    }
}

import SwiftUI

struct FirstController_Previews: PreviewProvider {
    static var previews: some View{
        ContainerView()
    }
    struct ContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            let navController = UINavigationController(rootViewController: FirstController())
            return navController
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
