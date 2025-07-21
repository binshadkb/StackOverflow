//
//  NetworkManagerProtocol.swift
//  StackOverflow
//
//  Created by Binshad Karekkatt Basheer on 21/07/2025.
//

import Foundation
import Combine

protocol NetworkManagerProtocol {
    func request<T: Decodable>(url: URLRequest) -> AnyPublisher<T, Error>
}
