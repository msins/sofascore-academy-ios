//
// Created by Marko Sinkovic on 09.04.2022..
//

import Foundation

extension JSONDecoder {

    static let github: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}