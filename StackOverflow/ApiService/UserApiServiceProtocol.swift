//
//  UserApiServiceProtocol.swift
//  StackOverflow
//
//  Created by Binshad Karekkatt Basheer on 21/07/2025.
//

import Combine

protocol UserApiServiceProtocol {
    func fetchUsers(page: Int, size: Int) -> AnyPublisher<[User], Error>
}
