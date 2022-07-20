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
    case tokenSerial = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7Il9pZCI6IjYyZDU2ZDhjMTVhNTYzMjE5ODY2NTQ4ZiJ9LCJpYXQiOjE2NTgzMzM0OTksImV4cCI6MTY2MDkyNTQ5OX0.PwDD-jeD5iBWDOp_wCuTLzMxZRe-NJftjHTGANwdpec"
    case userId = "1"
}
