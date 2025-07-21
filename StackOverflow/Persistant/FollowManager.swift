//
//  FollowManager.swift
//  StackOverflow
//
//  Created by Binshad Karekkatt Basheer on 21/07/2025.
//

import Foundation

struct FollowManager: FollowManagerProtocol {
    private let key = "FollowedUsers"
    
    func isFollowed(userId: Int) -> Bool {
        return followedUserIds.contains(userId)
    }
    
    func toggleFollow(userId: Int) {
        var ids = followedUserIds
        if ids.contains(userId) {
            ids.remove(userId)
        } else {
            ids.insert(userId)
        }
        UserDefaults.standard.set(Array(ids), forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    var followedUserIds: Set<Int> {
        let ids = UserDefaults.standard.array(forKey: key) as? [Int] ?? []
        return Set(ids)
    }
}
