//
//  Follower.swift
//  Cumulative
//
//  Created by Marko Sinkovic on 08.05.2022..
//

import Foundation

struct Follower: Codable, Identifiable {
    var id: String { login }
    let login: String
    let avatarUrl: String
}
