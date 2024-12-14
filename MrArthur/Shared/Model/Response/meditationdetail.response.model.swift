//
//  MeditationDetailResponse.swift
//  MrArthur
//
//  Created by IPS-169 on 08/08/22.
//

import Foundation

struct MediationDetailResponseModel: Codable,Identifiable {
    var id :String? =  UUID().uuidString
    var uuid: String?
    var entertainmentScreenTimeSecondAllowed, educationalScreenTimeSecondCommitment: Int?
    var stepListJsonb: StepListMeditationJsonbResponseModel?
    var createdAt, updatedAt, attendeeUserUUID: String?
    var attendeeUser: AttendeeUserResponseModel?
}

// MARK: - AttendeeUser
struct AttendeeUserResponseModel: Codable {
    var type, role, uuid: String?
    var active: Bool?
    var createdAt, updatedAt, name, gender: String?
    var birthDate: String?
    var subscription: MediationSubscriptionResponseModel?
}

// MARK: - Subscription
struct MediationSubscriptionResponseModel: Codable {
    var uuid: String?
    var name, maxAttendee: String?
    var createdAt, updatedAt: String?
    var subscriptionObserverUserRoleList: [SubscriptionObserverUserRoleListResponseModel]?
}
// MARK: - SubscriptionObserverUserRoleList
struct SubscriptionObserverUserRoleListResponseModel: Codable {
    var uuid, role, createdAt, updatedAt: String?
    var observerUser: ObserverUserResponseModel?
}
// MARK: - ObserverUser
struct ObserverUserResponseModel: Codable {
    var type, role, uuid: String?
    var active: Bool?
    var createdAt, updatedAt: String?
    var contact: ContactResponseModel?
}

// MARK: - Contact
struct ContactResponseModel: Codable {
    var email: String?
}


// MARK: - StepListJsonb
struct StepListMeditationJsonbResponseModel: Codable {
    var list: [MediationListResponseModel]?
    var estimation: MediationEstimationResponseModel?
}
// MARK: - List
struct MediationListResponseModel: Codable {
    var estimatedSmartPhoneMinutes : Int?
    var estimatedTabletMinutes : Int?
    var totalTimeReductionPercent: Int?
    var educativeTimePercent: Int?
    var totalTimeMinutes: Int?
    var educativeTimeMinutes: Int?
    var entertainmentTimeMinutes: Int?
    var accepted: Bool?
    var createdAt: String?
    var updatedAt: String?
}
// MARK: - Estimation
struct MediationEstimationResponseModel: Codable {
    var dailyEducativeTimeMinutes,dailyOwnSmartPhoneMinutes,dailyOwnTabletMinutes,dailySharedScreenTimeMinutes,dailyTVMinutes,dailyVideoGamMinutes,totalScreenTimeMinutes,diagnosedScreenTimeMinutes:Int?
    
}
