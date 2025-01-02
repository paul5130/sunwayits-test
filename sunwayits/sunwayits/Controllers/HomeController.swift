//
//  HomeController.swift
//  sunwayits
//
//  Created by Paul Wen on 2024/12/31.
//

import UIKit

enum TableViewSection: Int, CaseIterable {
    case invitingFriends = 0
    case friends = 1
}

class HomeController: UIViewController{
    private let viewModel: HomeViewModel
    private lazy var atmBarButton = createBarButton(image: .navATM, action: #selector(handleBack))
    private lazy var dollarBarButton = createBarButton(image: .navTransfer, action: #selector(handleBack))
    private lazy var scanBarButton = createBarButton(image: .navScan, action: #selector(handleBack))
    private let headerView = HeaderView()
    let emptyFriendsView = EmptyFriendsView()
    private var invitingFriends = [Friend]()
    var friends = [Friend]()
    @objc func handleBack(){
        navigationController?.popViewController(animated: true)
    }
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.keyboardDismissMode = .onDrag
        tableView.backgroundColor = .backgroundColor()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        return tableView
    }()
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return refreshControl
    }()
    @objc private func handleRefresh(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.fetchData()
        }
    }
    
    private let invitingFriendCellId = "invitingFriendCellId"
    private let friendCellId = "friendCellId"
    private func setupViews() {
        tableView.register(InvitingFriendCell.self, forCellReuseIdentifier: invitingFriendCellId)
        tableView.register(FriendCell.self, forCellReuseIdentifier: friendCellId)
        view.backgroundColor = .backgroundColor()
        navigationItem.leftBarButtonItems = [atmBarButton,dollarBarButton]
        navigationItem.rightBarButtonItem = scanBarButton
        view.addSubview(tableView)
        tableView.refreshControl = refreshControl
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
        setupKeyboardObservers()
        fetchData()
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
    @objc func handleKeyboardWillShow(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        adjustTableViewForKeyboard(show: true, keyboardFrame: keyboardFrame)
    }
    
    @objc private func handleKeyboardWillHide(notification: Notification) {
        adjustTableViewForKeyboard(show: false, keyboardFrame: .zero)
    }
    
    private func adjustTableViewForKeyboard(show: Bool, keyboardFrame: CGRect) {
        var contentInset = tableView.contentInset
        contentInset.bottom = show ? keyboardFrame.height + 300 : 0
        tableView.contentInset = contentInset
    }
    private func fetchData(){
        fetchUserData()
        fetchFriendsData()
    }
    private func fetchFriendsData(){
        viewModel.fetchFriends {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let friendsData):
                self.updateFriendList(with: friendsData)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    private func fetchUserData(){
        viewModel.fetchUserData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let userData):
                DispatchQueue.main.async {
                    self.headerView.configure(with: userData.name, kokoId: userData.kokoid)
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    private func updateFriendList(with data: FriendsData) {
        invitingFriends = data.invitingFriends
        friends = data.friends
        DispatchQueue.main.async {
            self.emptyFriendsView.isHidden = !data.isEmpty
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
        }
    }
    private func setupKeyboardObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleSearchNotification), name: .searchBarTextDidChange, object: nil)
    }
    private func createBarButton(image: UIImage, action: Selector) -> UIBarButtonItem {
        UIBarButtonItem(
            image: image.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: action)
    }
}
extension HomeController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionType = TableViewSection(rawValue: section) else { return 0 }
        switch sectionType {
        case .invitingFriends:
            return invitingFriends.count
        case .friends:
            return friends.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionType = TableViewSection(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        switch sectionType {
        case .invitingFriends:
            let cell = tableView.dequeueReusableCell(withIdentifier: invitingFriendCellId, for: indexPath) as! InvitingFriendCell
            cell.selectionStyle = .none
            cell.configure(with: invitingFriends[indexPath.row].name)
            return cell
        case .friends:
            let cell = tableView.dequeueReusableCell(withIdentifier: friendCellId, for: indexPath) as! FriendCell
            cell.configure(with: FriendCellViewModel(friend: friends[indexPath.row]))
            cell.selectionStyle = .none
            return cell
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        TableViewSection.allCases.count
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

//import SwiftUI
//struct HomeController_Previews: PreviewProvider {
//    static var previews: some View{
//        ContainerView()
//    }
//    struct ContainerView: UIViewControllerRepresentable {
//        func makeUIViewController(context: Context) -> some UIViewController {
//            let navController = UINavigationController(rootViewController: HomeController(state: .noFriends))
//            return navController
//        }
//        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//
//        }
//    }
//}
