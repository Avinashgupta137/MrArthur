//
//  MeditationApprovalResponse.swift
//  MrArthur
//
//  Created by IPS-169 on 10/08/22.
//

import Foundation
// MARK: - MeditationApprovalResponse
struct MediationApprovalResponseModel: Codable,Identifiable {
    var id :String? =  UUID().uuidString
    var uuid: String?
    var stepListJsonb: MediationApprovalStepListJsonbResponseModel?
    var createdAt, updatedAt, attendeeUserUUID: String?
}

// MARK: - StepListJsonb
struct MediationApprovalStepListJsonbResponseModel: Codable {
    var estimation: MediationApprovalEstimationResponseModel?
    var list: [MediationApprovalListResponseModel]?
}

// MARK: - Estimation
struct MediationApprovalEstimationResponseModel: Codable {
    var totalScreenTimeMinutes, dailyTVMinutes, dailyVideoGamMinutes, dailySharedScreenTimeMinutes: Int?
    var dailyOwnSmartPhoneMinutes, dailyOwnTabletMinutes, dailyEducativeTimeMinutes, increasePercent: Int?
}

// MARK: - List
struct MediationApprovalListResponseModel: Codable {
    var totalTimeReductionPercent, educativeTimePercent: Int?
    var accepted: Bool?
    var createdAt, updatedAt: String?
}
