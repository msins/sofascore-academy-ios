//
//  NetworkManager.swift
//  Cumulative
//
//  Created by Marko Sinkovic on 08.04.2022..
//

import Foundation
import Combine

struct NetworkManager {
    private init() {
    }

    static let shared = NetworkManager()

    func fetchGithubProfile(of username: String) -> AnyPublisher<GithubProfileResponse, ApiError> {
        let url = "https://api.github.com/users/\(username)"

        return get(GithubProfileResponse.self, url: url)
    }

    func fetchGithubFollowers(of username: String) -> AnyPublisher<[GithubFollowerResponse], ApiError> {
        let url = "https://api.github.com/users/\(username)/followers"

        return get([GithubFollowerResponse].self, url: url)
    }

    private func get<T: Decodable>(_ type: T.Type, url: String) -> AnyPublisher<T, ApiError> {
        guard let url = URL(string: url) else {
            return Fail(error: ApiError.malformedUrl(url)).eraseToAnyPublisher()
        }

        return get(type, url: url)
    }

    private func get<T: Decodable>(_ type: T.Type, url: URL) -> AnyPublisher<T, ApiError> {
        URLSession.shared.dataTaskPublisher(for: url)
                  .validate()
                  .map { $0.data }
                  .decode(as: T.self, using: .github)
                  .mapError { error -> ApiError in
                      guard let error = error as? ApiError else {
                          return ApiError.unknownError(error)
                      }
                      return error
                  }
                  .eraseToAnyPublisher()
    }
}
