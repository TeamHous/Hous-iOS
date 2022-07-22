//
//  HTTPHeaderField.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/07.
//

import Foundation

enum HeaderType {
    case basic
    case auth
    case multiPart
    case multiPartWithAuth
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case accesstoken = "accesstoken"
    case userId = "userId"
}

enum ContentType: String {
    case json = "Application/json"
    case multiPart = "multipart/form-data"
    case tokenSerial = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7Il9pZCI6IjYyZDk0MmQ1YWQxZmExYzk4YTRmZmUwZiJ9LCJpYXQiOjE2NTg0MDYxNDgsImV4cCI6MTY2MDk5ODE0OH0.enJTfTw3swb0STJ3wbwCHvb1VKctyUf4S7q8VfMNDnw"
    case userId = "1"
}
