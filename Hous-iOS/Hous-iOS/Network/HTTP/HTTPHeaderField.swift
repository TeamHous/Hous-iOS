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
    case tokenSerial = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7Il9pZCI6IjYyZDQ4ZDc4YmE2N2Y4MzdhYjA1NWViZiJ9LCJpYXQiOjE2NTgwOTcwMTYsImV4cCI6MTY2MDY4OTAxNn0.GC02eOsEpvCunh218KnhHNEYVbiPvuLEAkbggULhJS0"
    case userId = "1"
}
