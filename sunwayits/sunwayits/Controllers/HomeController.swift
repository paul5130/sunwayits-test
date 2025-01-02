//
//  HomeController.swift
//  sunwayits
//
//  Created by Paul Wen on 2024/12/31.
//

import UIKit

class HomeController: UIViewController{
    private let viewModel: HomeViewModel
    private lazy var atmBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: .navATM.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleBack))
        return barButton
    }()
    private lazy var dollarBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: .navTransfer.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleBack))
        return barButton
    }()
    private lazy var scanBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: .navScan.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleBack))
        return barButton
    }()
    private let headerView = HeaderView()
    private let emptyFriendsView = EmptyFriendsView()
    private var invitingFriends = [Friend]()
    private var friends = [Friend]()
    @objc private func handleBack(){
        navigationController?.popViewController(animated: true)
    }
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
    private func setupViews() {
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
    init(state: FriendState) {
        self.viewModel = HomeViewModel(friendState: state)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupObserver()
    }
    private func setupObserver(){
        viewModel.fetchMultipleApiFriends {[weak self] result in
            switch result {
            case .success(let friendsData):
                print(friendsData)
                self?.invitingFriends = friendsData.invitingFriends
                self?.friends = friendsData.friends
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let failure):
                print(failure)
            }
        }
        viewModel.fetchUserData { [weak self] result in
            switch result {
            case .success(let userData):
                DispatchQueue.main.async {
                    self?.headerView.configure(with: userData.name)
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
extension HomeController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return invitingFriends.count
        }else if section == 1{
            return friends.count
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: invitingFriendCellId, for: indexPath) as! InvitingFriendCell
            cell.selectionStyle = .none
            cell.configure(with: invitingFriends[indexPath.row].name)
            return cell
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: friendCellId, for: indexPath) as! FriendCell
            cell.configure(with: FriendCellViewModel(friend: friends[indexPath.row]))
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
            let navController = UINavigationController(rootViewController: HomeController(state: .noFriends))
            return navController
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
