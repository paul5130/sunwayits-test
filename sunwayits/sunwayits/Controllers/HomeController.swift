//
//  HomeController.swift
//  sunwayits
//
//  Created by Paul Wen on 2024/12/31.
//

import UIKit

class HomeController: UIViewController{
    private let atmBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.image = .navATM.withRenderingMode(.alwaysOriginal)
        return barButton
    }()
    private let dollarBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.image = .navTransfer.withRenderingMode(.alwaysOriginal)
        return barButton
    }()
    private let scanBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.image = .navScan.withRenderingMode(.alwaysOriginal)
        return barButton
    }()
    private let headerView = HeaderView()
    private let emptyFriendsView = EmptyFriendsView()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .backgroundColor()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        return tableView
    }()
    private let invitingFriendCellId = "invitingFriendCellId"
    private let friendCellId = "friendCellId"
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(InvitingFriendCell.self, forCellReuseIdentifier: invitingFriendCellId)
        tableView.register(FriendCell.self, forCellReuseIdentifier: friendCellId)
        view.backgroundColor = .backgroundColor()
        navigationItem.leftBarButtonItems = [atmBarButton,dollarBarButton]
        navigationItem.rightBarButtonItem = scanBarButton
        view.addSubview(headerView)
        headerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        view.addSubview(emptyFriendsView)
        emptyFriendsView.anchor(top: headerView.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        view.addSubview(tableView)
        tableView.anchor(top: headerView.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
}
extension HomeController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 2
        }else if section == 1{
            return 2
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: invitingFriendCellId, for: indexPath) as! InvitingFriendCell
            cell.selectionStyle = .none
            return cell
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: friendCellId, for: indexPath) as! FriendCell
            cell.selectionStyle = .none
            return cell
        }else{
            return UITableViewCell()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
}
extension HomeController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        section == 1 ? FriendsHeaderView() : nil
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section == 1 ? 100 : 0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0
    }
}


import SwiftUI
struct HomeController_Previews: PreviewProvider {
    static var previews: some View{
        ContainerView()
    }
    struct ContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            let navController = UINavigationController(rootViewController: HomeController())
            return navController
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
