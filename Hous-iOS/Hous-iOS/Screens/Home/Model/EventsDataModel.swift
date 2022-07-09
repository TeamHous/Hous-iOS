//
//  EventsDataModel.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/09.
//

import Foundation

struct EventDataModel {
    let dday: Int
    var ddayString: String {
        return "D-\(dday)"
    }
}

extension EventDataModel {
    static let sampleData: [EventDataModel] = [
        EventDataModel(dday: 1),
        EventDataModel(dday: 3),
        EventDataModel(dday: 4),
        EventDataModel(dday: 11),
        EventDataModel(dday: 42),
        EventDataModel(dday: 11),
        EventDataModel(dday: 1),
        EventDataModel(dday: 4),
        EventDataModel(dday: 5)
    ]
}
