//
//  MockUserService.swift
//  StackOverflow
//
//  Created by Binshad Karekkatt Basheer on 21/07/2025.
//

@testable import StackOverflow
import Combine
import Foundation

class MockUserService: UserApiServiceProtocol {
    var shouldThrowError = false
    
    func fetchUsers(page: Int, size: Int) -> AnyPublisher<[User], any Error> {
        if shouldThrowError {
            return Fail(error: NSError(domain: "Test", code: 1, userInfo: [NSLocalizedDescriptionKey: "Test error"]))
                .eraseToAnyPublisher()
        }
        else {
            return Just([User(id: 1, name: "Binshad", profileImage: nil, location: nil, reputation: 0)])
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
