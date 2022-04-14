//
// Created by Marko Sinkovic on 09.04.2022..
//

import Foundation

typealias HttpCode = Int
typealias HttpCodes = Range<HttpCode>

extension HttpCodes {
    static let success = 200..<300
}