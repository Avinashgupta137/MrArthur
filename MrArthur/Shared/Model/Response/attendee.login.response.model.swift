//
//  AttendeeLoginResponse.swift
//  MrArthur
//
//  Created by IPS-169 on 01/08/22.
//

import Foundation

// MARK: - AttendeeLoginResponse
struct AttendeeLoginResponseModel: Codable, Identifiable {
    var id :String?
    var token: String?
    var user: AttendeeListResponseModel?
}

// MARK: - User
struct AttendeeUserLoginResponseModel: Codable {
    var uuid, type, role, subscriptionUUID: String?
    var name, intercomEmail, gender, birthDate: String?
    var attendeeUserMediationList: [AttendeeAttendeeUserMediationListModel]?
    var attendeeUserOnboarding: AttendeeAttendeeUserOnboardingModel?
    var deviceList: [DeviceList]?
}

// MARK: - AttendeeUserMediationList
struct AttendeeAttendeeUserMediationListModel: Codable {
    var uuid: String?
    var stepListJsonb: AttendeeUserMediationListStepListLoginResponseJsonbModel?
    var createdAt, updatedAt: String?
   
}

// MARK: - AttendeeUserMediationListStepListJsonb
struct AttendeeUserMediationListStepListLoginResponseJsonbModel: Codable {
//    var list: [JSONAny]?
    var estimation: AttendeeEstimationLoginResponseModel?
}

// MARK: - Estimation
struct AttendeeEstimationLoginResponseModel: Codable {
    var dailyTVMinutes: Int?
    var dailyOwnTabletMinutes: Int?
    var dailyVideoGameMinutes: Int?
    var totalScreenTimeMinutes: Int?
    var dailyEducativeTimeMinutes: Int?
    var dailyOwnSmartPhoneMinutes: Int?
    var diagnosedScreenTimeMinutes: Int?
    var dailySharedScreenTimeMinutes: Int?
    
}

// MARK: - AttendeeUserOnboarding
struct AttendeeAttendeeUserOnboardingModel: Codable {
    var uuid: String?
    var stepListJsonb: AttendeeUserOnboardingStepListLoginResponseJsonbModel?
    var createdAt, updatedAt: String?
    var done: Bool?
    var attendeeUser: AttendeeUserResponseModel?
    
    var isOnbardingCompleted: Bool {
        return done ?? false
    }
}

// MARK: - AttendeeUserOnboardingStepListJsonb
struct AttendeeUserOnboardingStepListLoginResponseJsonbModel: Codable {
    var stepList: [AttendeeStepListModel]?
    var createdAt: String?
}

// MARK: - StepList
struct AttendeeStepListModel: Codable {
    var name: String?
    var type: String?
    var category: String?
    var updatedAt: String?

}
