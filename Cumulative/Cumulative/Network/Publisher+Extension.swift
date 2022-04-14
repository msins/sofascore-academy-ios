//
// Created by Marko Sinkovic on 08.04.2022..
//

import Foundation
import Combine

extension Publisher where Output == Data {
    func decode<T: Decodable>(
        as type: T.Type = T.self,
        using decoder: JSONDecoder = .github
    ) -> Publishers.Decode<Self, T, JSONDecoder> {
        decode(type: type, decoder: decoder)
    }
}

extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    func validate() -> Publishers.TryMap<Self, Output> {
        tryMap { output in

            guard let httpResponse = output.response as? HTTPURLResponse else {
                throw ApiError.serverError
            }

            guard HttpCodes.success.contains(httpResponse.statusCode) else {
                throw ApiError.code(httpResponse.statusCode)
            }

            return output
        }
    }
}