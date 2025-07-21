//
//  NetworkManager.swift
//  StackOverflow
//
//  Created by Binshad Karekkatt Basheer on 21/07/2025.
//

import Foundation
import Combine

struct NetworkManager: NetworkManagerProtocol {
    func request<T: Decodable>(url: URLRequest) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResp = response as? HTTPURLResponse, httpResp.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
