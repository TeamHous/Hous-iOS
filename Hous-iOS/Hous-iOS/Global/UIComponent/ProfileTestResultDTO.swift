//
//  ProfileTestResultDTO.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/18.
//

import UIKit
import Alamofire

// user/me/type

struct ProfileTestResultDTO: Decodable {
    let userName, typeName, typeColor: String
    let typeImg: String
    let typeOneComment, typeDesc, typeRulesTitle: String
    let typeRules: [String]
    let good, bad: Bad
}

struct Bad: Decodable {
    let typeName: String
    let typeImg: [String]
}



