//
// Created by Marko Sinkovic on 09.04.2022..
//

import Foundation

struct GithubFollowerResponse: Decodable {
    let id: Int
    let login: String
    let avatarUrl: String
}
