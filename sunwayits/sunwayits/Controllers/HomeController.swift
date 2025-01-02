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
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.keyboardDismissMode = .onDrag
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
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        tableView.addSubview(emptyFriendsView)
        emptyFriendsView.anchor(top: tableView.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 200, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
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
    @objc private func handleSearchNotification(_ notification: Notification){
        if let searchText = notification.userInfo?["searchText"] as? String{
            print(searchText)
            viewModel.filterFriends(searchText)
            self.friends = viewModel.filteredFriends
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: .searchBarTextDidChange, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc private func handleKeyboardWillShow(notification: Notification){
        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        var contentInset = self.tableView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 300
        tableView.contentInset = contentInset
        tableView.scrollToRow(at: IndexPath(row: 0, section: 1), at: UITableView.ScrollPosition.top, animated: true)
    }
    @objc private func handleKeyboardWillHide(notification: Notification){
        tableView.contentInset = .zero
    }
    private func setupObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleSearchNotification), name: .searchBarTextDidChange, object: nil)
        viewModel.fetchMultipleApiFriends {[weak self] result in
            switch result {
            case .success(let friendsData):
                print(friendsData)
                self?.invitingFriends = friendsData.invitingFriends
                self?.friends = friendsData.friends
                DispatchQueue.main.async {
                    self?.emptyFriendsView.isHidden = !friendsData.isEmpty
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
                    self?.headerView.configure(with: userData.name, kokoId: userData.kokoid)
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
        if section == 0{
            return headerView
        }else if section == 1 && friends.count > 0{
            return SearchBarView()
        }else {
            return nil
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        section == 0 ? InvitingFriendsFooterView(): nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section == 1 ? 60 : 80
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        section == 0 ? 40 : 0
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
