//
// Created by Marko Sinkovic on 08.04.2022..
//

import Foundation

struct GithubProfileResponse: Decodable {
    let id: Int
    let login: String
    let avatarUrl: String
    let name: String?
    let publicRepos: Int
    let publicGists: Int
    let followers: Int
    let following: Int
    let company: String?
    let bio: String?
}
