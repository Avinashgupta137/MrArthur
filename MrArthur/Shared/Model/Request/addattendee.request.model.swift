//
//  addAttendeeRequestModel.swift
//  MrArthur
//
//  Created by IPS-169 on 22/08/22.
//

import Foundation
struct AddAttendeeRequestModel:Codable {
    var subscriptionUUID: String?
    var attendeeName: String?
    var gender: String?
    var birthDate: String?
    var dailyTVMinutes:Int?
    var dailyVideoGameMinutes:Int?
    var dailySharedScreenTimeMinutes:Int?
    var dailyOwnSmartPhoneMinutes:Int?
    var dailyOwnTabletMinutes:Int?
    var dailyEducativeTimeMinutes:Int?
}
