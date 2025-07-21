//
//  UserViewModelTests.swift
//  StackOverflow
//
//  Created by Binshad Karekkatt Basheer on 21/07/2025.
//

import XCTest
@testable import StackOverflow
import Combine

class UserViewModelTests: XCTestCase {

    var viewModel: UserViewModel!
    var mockService: MockUserService!
    var mockFollowManager: MockFollowManager!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockService = MockUserService()
        mockFollowManager = MockFollowManager()
        viewModel = UserViewModel(userService: mockService, followManager: mockFollowManager)
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        mockFollowManager = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchUsers_success() {
        let expectation = XCTestExpectation(description: "Users fetched")

        viewModel.$users
            .dropFirst()
            .sink { users in
                XCTAssertEqual(users.count, 1)
                XCTAssertEqual(users.first?.name, "Binshad")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.fetchUsers()
        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchUsers_failure() {
        let expectation = XCTestExpectation(description: "Error received")
        mockService.shouldThrowError = true

        viewModel.$errorMessage
            .dropFirst()
            .sink { error in
                XCTAssertEqual(error, "Test error")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.fetchUsers()
        wait(for: [expectation], timeout: 1.0)
    }

    func testToggleFollow() {
        let userId = 123
        XCTAssertFalse(viewModel.isFollowed(userId: userId))

        viewModel.toggleFollow(userId: userId)
        XCTAssertTrue(viewModel.isFollowed(userId: userId))

        viewModel.toggleFollow(userId: userId)
        XCTAssertFalse(viewModel.isFollowed(userId: userId))
    }
}
