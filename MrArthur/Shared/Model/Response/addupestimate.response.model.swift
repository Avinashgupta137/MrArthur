//
//  AddupEstimateResponse.swift
//  MrArthur
//
//  Created by IPS-169 on 17/08/22.
//

import Foundation
struct AddupEstimateResponseModel: Codable {
    var dailyTVMinutes: Int?
    var dailyVideoGamMinutes: Int?
    var dailyOwnTabletMinutes: Int?
    var totalScreenTimeMinutes: Int?
    var dailyOwnSmartPhoneMinutes: Int?
    var dailySharedScreenTimeMinutes: Int?
    var dailyEducativeTimeMinutes: Int?
}
