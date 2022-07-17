//
//  HTTPStatusCode.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/18.
//

import Foundation

enum HTTPStatusCode: Int {
    case OK = 200
    case UNSUBSCRIBED_USER = 404
    case INVALID = 409
    case SERVER_ERROR = 500

    enum SignupCode: Int {
        case SIGNUP_OK = 201
    }
}
