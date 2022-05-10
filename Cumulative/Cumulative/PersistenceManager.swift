//
//  PersistenceManager.swift
//  Cumulative
//
//  Created by Marko Sinkovic on 08.05.2022..
//

import Foundation
import Combine

enum PersistenceActionType {
    case add, remove
}

enum GithubError: Error, LocalizedError {
    case alreadyFavorited
    case failedToChangeFavorites
    
    var errorDescription: String? {
        switch self {
        case .alreadyFavorited:
            return "User already favorited."
        case .failedToChangeFavorites:
            return "Failed to change favorites."
        }
    }
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func favorites() -> AnyPublisher<[Follower], Never> {
        return Just(takeFromUserDefaults(key: Keys.favorites, returnType: [Follower].self) ?? []).eraseToAnyPublisher()
    }
    
    static func favorite(_ action: PersistenceActionType, follower: Follower) -> AnyPublisher<Follower, GithubError> {
        var favorites = takeFromUserDefaults(key: Keys.favorites, returnType: [Follower].self) ?? []
        
        switch action {
        case .add:
            if favorites.contains(where: { $0.login == follower.login }) {
                return Fail(error: .alreadyFavorited).eraseToAnyPublisher()
            }
            favorites.append(follower)
        case .remove:
            favorites.removeAll(where: { $0.login == follower.login })
        }
        
        guard save(key: Keys.favorites, item: favorites) else {
            return Fail(error: .failedToChangeFavorites).eraseToAnyPublisher()
        }
        
        return Just(follower).setFailureType(to: GithubError.self).eraseToAnyPublisher()
    }
    
    private static func takeFromUserDefaults<T: Decodable>(key: String, returnType: T.Type) -> T? {
        if let data = defaults.data(forKey: key) {
            do {
                return try JSONDecoder().decode(returnType, from: data)
            } catch {}
        }
        
        return nil
    }
    
    static func save<T: Encodable>(key: String, item: T) -> Bool {
        do {
            let data = try JSONEncoder().encode(item)
            defaults.set(data, forKey: key)
            return true
        } catch {
            return false
        }
    }
    
}
