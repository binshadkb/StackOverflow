//
//  FollowManagerProtocol.swift
//  StackOverflow
//
//  Created by Binshad Karekkatt Basheer on 21/07/2025.
//

protocol FollowManagerProtocol {
    func isFollowed(userId: Int) -> Bool
    func toggleFollow(userId: Int)
}
