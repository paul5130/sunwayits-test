//
//  HomeControllerTests.swift
//  sunwayitsTests
//
//  Created by Paul Wen on 2025/1/2.
//

import XCTest
@testable import sunwayits

class HomeControllerTests: XCTestCase{
    var sut: HomeController!
    var mockViewModel: HomeViewModel!
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockViewModel = HomeViewModel(friendState: .noFriends)
        sut = HomeController(state: .noFriends)
        sut.loadViewIfNeeded()
    }
    override func tearDownWithError() throws {
        sut = nil
        mockViewModel = nil
        try super.tearDownWithError()
    }
    func test_ViewDidLoad_ConfiguresTableView() {
        XCTAssertNotNil(sut.tableView, "TableView should be iniltiazed")
        XCTAssertEqual(sut.tableView.numberOfSections, 2, "TableView should have 2 sections")
    }
    func test_EmptyFriendsView_ShouldBeVisible_WhenNoFriends() {
        XCTAssertTrue(sut.emptyFriendsView.isHidden == false, "emptyFriendsView should shown when no friends")
    }
    
    func test_BackButton_PopsViewController() {
        let mockNavigationController = MockNavigationController(rootViewController: sut)
        
        sut.handleBack()
        XCTAssertTrue(mockNavigationController.isPopped, "Back button should triggered popViewController")
    }
    
    func test_RefreshControl_ShouldBeConfigured() {
        XCTAssertNotNil(sut.refreshControl, "RefreshControl should be initialized")
        XCTAssertTrue(sut.tableView.refreshControl === sut.refreshControl, "RefreshControl should bind to TableView")
    }
    
    class MockNavigationController: UINavigationController {
        var isPopped = false
        
        override func popViewController(animated: Bool) -> UIViewController? {
            isPopped = true
            return super.popViewController(animated: animated)
        }
    }
}
