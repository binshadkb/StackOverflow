//
//  UserApiService.swift
//  StackOverflow
//
//  Created by Binshad Karekkatt Basheer on 21/07/2025.
//

import Foundation
import Combine

struct UserApiService: UserApiServiceProtocol {
    let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchUsers(page: Int, size: Int) -> AnyPublisher<[User], Error> {
        let urlString = Constants.BASEURL + Constants.USERS + "?page=\(page)&pagesize=\(size)&order=desc&sort=reputation&site=stackoverflow"
        
        guard let url = URL(string: urlString) else {
            return Fail(error: NSError(domain: "url", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
                .eraseToAnyPublisher()
        }
        
        let request = URLRequest(url: url)
        return networkManager.request(url: request)
            .map { (response: UserResponse) in
                return response.items
            }
            .eraseToAnyPublisher()
    }
}
