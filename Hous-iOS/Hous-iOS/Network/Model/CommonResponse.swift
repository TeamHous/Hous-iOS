//
//  CommonResponse.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/18.
//

import Foundation

struct CommonResponse<T: Codable>: Codable {

    let status: Int
    let success: Bool
    let message: String
    let data: T?
}
