//
//  ParticipantsDataModel.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/12.
//

import UIKit

struct ParticipantsDataModel {
  let participantName: String
  let participantImage: UIImage
}

extension ParticipantsDataModel {
  static let sampleData: [ParticipantsDataModel] = [
    ParticipantsDataModel(participantName: "최인영", participantImage: R.Image.faceGreen),
    ParticipantsDataModel(participantName: "최소현", participantImage: R.Image.faceRed),
    ParticipantsDataModel(participantName: "이다영", participantImage: R.Image.faceBlue),
    ParticipantsDataModel(participantName: "박예원", participantImage: R.Image.facePurple),
    ParticipantsDataModel(participantName: "박예원", participantImage: R.Image.facePurple),
    ParticipantsDataModel(participantName: "박예원", participantImage: R.Image.facePurple),
    ParticipantsDataModel(participantName: "박예원", participantImage: R.Image.facePurple)
  ]
}
