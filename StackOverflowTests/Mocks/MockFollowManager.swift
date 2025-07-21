//
//  MockFollowManager.swift
//  StackOverflow
//
//  Created by Binshad Karekkatt Basheer on 21/07/2025.
//

@testable import StackOverflow

class MockFollowManager: FollowManagerProtocol {
    var followedUsers: Set<Int> = []
    
    func isFollowed(userId: Int) -> Bool {
        followedUsers.contains(userId)
    }
    
    func toggleFollow(userId: Int) {
        if followedUsers.contains(userId) {
            followedUsers.remove(userId)
        } else {
            followedUsers.insert(userId)
        }
    }
}
