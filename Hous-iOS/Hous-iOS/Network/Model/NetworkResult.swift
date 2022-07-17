//
//  NetworkResult.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/07.
//

import Foundation

enum NetworkResult<T> {
    case success(T?)
    case requestErr(String)
    case serverErr
    case pathErr
    case networkFail
}

protocol NetworkResultProtocol {
    func resultMethod()
}

struct Success<T: Codable>: NetworkResultProtocol {

    var response: T?
    func resultMethod() {
        print("성공")
    }
}

struct RequestErr: NetworkResultProtocol {

    var errorMessage: String
    func resultMethod() {
        print(errorMessage)
    }
}

struct ServerErr: NetworkResultProtocol {

    func resultMethod() {
        print("servererror")
    }
}

struct PathErr: NetworkResultProtocol {

    func resultMethod() {
        print("patherr")
    }
}

struct NetworkFail: NetworkResultProtocol {

    func resultMethod() {
        print("네트워크fail")
    }
}

struct NetworkResultFactory {

    static func makeResult<T: Codable>(resultType: NetworkResult<T>) -> NetworkResultProtocol {
        switch resultType {
        case .success(let response):
            return Success(response: response)
        case .requestErr(let message):
            return RequestErr(errorMessage: message)
        case .serverErr:
            return ServerErr()
        case .pathErr:
            return PathErr()
        case .networkFail:
            return NetworkFail()
        }
    }
}
