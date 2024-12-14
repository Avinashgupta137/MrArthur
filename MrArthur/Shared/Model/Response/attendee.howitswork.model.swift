//
//  attendee.howitswork.model.swift
//  MrArthur
//
//  Created by BAPS on 02/11/22.
//

import Foundation

enum EHowItsWork: String, Codable{
    case CONGRATS
    case SUMMARY
    case MECHANICS_INTRO
    case EDUCATIONAL_APPS
    case UNLOCK_ENTERTAINMENT_TIME
    case DAILY_ADVANCE_ENTERTAINMENT_TIME
    case SAVE_ENTERTAINMENT_TIME
    case LOOK_AT_DASHBOARD
}

struct AttendeeHowItsWorkResponse: Codable {
    var uuid: String?
    var stepListJsonb: AttendeeHowItsWorkStepListJsonb?
    var done: Bool?
    var createdAt: String?
    var updatedAt: String?
    var attendeeUser: AttendeeHowItsWorkAttendeeUser?
}


struct AttendeeHowItsWorkStepListJsonb: Codable {
    var stepList: [AttendeeHowItsWorkStepName]?
    var createdAt: String?
}

struct AttendeeHowItsWorkStepName: Codable {
    var stepName: String?
    var updatedAt: String?
}

struct AttendeeHowItsWorkAttendeeUser : Codable {
    var type: String?
    var role: String?
    var uuid: String?
    var active: Bool?
    var createdAt: String?
    var updatedAt: String?
    var name: String?
    var gender: String?
    var birthDate: String?
}
