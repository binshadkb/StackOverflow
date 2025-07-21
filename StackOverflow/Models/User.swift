//
//  User.swift
//  StackOverflow
//
//  Created by Binshad Karekkatt Basheer on 21/07/2025.
//

struct User: Codable {
    let id: Int
    let name: String
    let profileImage: String?
    let location: String?
    let reputation: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "account_id"
        case name = "display_name"
        case profileImage = "profile_image"
        case location = "location"
        case reputation = "reputation"
    }
}
