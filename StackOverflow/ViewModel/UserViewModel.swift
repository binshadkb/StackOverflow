//
//  UserViewModel.swift
//  StackOverflow
//
//  Created by Binshad Karekkatt Basheer on 21/07/2025.
//

import Foundation
import Combine

class UserViewModel {
    @Published var users: [User] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    private var currentPage: Int = 1
    private var pageSize: Int = 20
    private var cancellables = Set<AnyCancellable>()
    
    let userService: UserApiServiceProtocol
    let followManager: FollowManagerProtocol
    
    init(userService: UserApiServiceProtocol = UserApiService(), followManager: FollowManagerProtocol = FollowManager()) {
        self.userService = userService
        self.followManager = followManager
    }
    
    func fetchUsers() {
        userService.fetchUsers(page: currentPage, size: pageSize)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: {[weak self] users in
                self?.users = users
            })
            .store(in: &cancellables)
    }
    
    func isFollowed(userId: Int) -> Bool {
        followManager.isFollowed(userId: userId)
    }
    
    func toggleFollow(userId: Int) {
        followManager.toggleFollow(userId: userId)
    }
}
