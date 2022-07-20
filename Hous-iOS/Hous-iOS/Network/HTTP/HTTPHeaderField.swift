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
    case tokenSerial = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7Il9pZCI6IjYyZDQ4ZDc4YmE2N2Y4MzdhYjA1NWViZiJ9LCJpYXQiOjE2NTgzNDQ5MzcsImV4cCI6MTY2MDkzNjkzN30.7rALDrR8cNxp4VIjiDR2YjVWIxs8i1psmQQrd0rlt6g"
    case userId = "1"
}
