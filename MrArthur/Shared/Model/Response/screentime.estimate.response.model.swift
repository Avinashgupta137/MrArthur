//
//  ScreenTimeEstimateResponse.swift
//  MrArthur
//
//  Created by IPS-169 on 24/08/22.
//

import Foundation


// MARK: - ScreenTimeEstimateResponse
struct ScreenTimeEstimateResponseModel: Codable {
    var totalScreenTimeMinutes:Int?
    var  dailyTVMinutes:Int?
    var  dailyVideoGameMinutes:Int?
    var  dailySharedScreenTimeMinutes: Int?
    var  dailyOwnSmartPhoneMinutes:Int?
    var  dailyOwnTabletMinutes:Int?
    var  dailyEducativeTimeMinutes:Int?
    var  increasePercent: Int?
    var  diagnosedScreenTimeMinutes: Int?
}
