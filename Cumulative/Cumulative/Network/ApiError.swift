//
// Created by Marko Sinkovic on 09.04.2022..
//

import Foundation

enum ApiError: Error {
    case code(_ code: HttpCode)
    case serverError
    case malformedUrl(_ url: String)
    case unknownError(_ error: Error?)
}

extension ApiError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .code(let code): return "Failed with code: \(code)"
        case .serverError: return "Server error"
        case .unknownError(let error): return "Unknown error: \(error?.localizedDescription ?? "")"
        case .malformedUrl(let url): return "Malformed url: \(url)"
        }
    }
}