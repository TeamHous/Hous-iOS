//
//  EventsDataModel.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/09.
//

import UIKit

struct EventDataModel {
  let dday: Int
  var ddayString: String {
    return "D-\(dday)"
  }
  let eventImage: UIImage?
}

extension EventDataModel {
  static let sampleData: [EventDataModel] = [
    EventDataModel(dday: 1, eventImage: R.Image.beerYellow),
    EventDataModel(dday: 3, eventImage: R.Image.cakeYellow),
    EventDataModel(dday: 4, eventImage: R.Image.coffeeYellow),
    EventDataModel(dday: 11, eventImage: R.Image.partyYellow),
    EventDataModel(dday: 42, eventImage: R.Image.partyYellow),
    EventDataModel(dday: 11, eventImage: R.Image.partyYellow),
    EventDataModel(dday: 1, eventImage: R.Image.coffeeYellow),
    EventDataModel(dday: 4, eventImage: R.Image.coffeeYellow),
    EventDataModel(dday: 5, eventImage: R.Image.cakeYellow)
  ]
}
