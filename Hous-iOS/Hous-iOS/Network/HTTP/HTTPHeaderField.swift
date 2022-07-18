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
    case tokenSerial = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7Il9pZCI6IjYyZDUyMTQ3NTc5ZmQ4ODg1OWJhNzAwZiJ9LCJpYXQiOjE2NTgxMzQ4NTUsImV4cCI6MTY2MDcyNjg1NX0.EI5EoPsnpyy1wWbkUD2WbNPaudP4RRITVOs3LUo1biU"
    case userId = "1"
}
