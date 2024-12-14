//
//  AddstrpmeditationResponse.swift
//  MrArthur
//
//  Created by IPS-169 on 09/08/22.
//

import Foundation

// MARK: - AddStepMeditationlResponse
struct AddStepMediationResponseModel: Codable,Identifiable {
    var id :String? =  UUID().uuidString
    var uuid: String?
    var stepListJsonb: AddMediationStepListJsonbResposeModel?
    var list:[MediationStep]?
    var createdAt, updatedAt, attendeeUserUUID: String?
}
// MARK: - MediationStep
struct MediationStep: Codable{
    var accepted: Bool?
    var createdAt: String?
    var updatedAt: String?
    var totalTimeMinutes: Int?
    var educativeTimeMinutes: Int?
    var educativeTimePercent: Int?
    var entertainmentTimeMinutes: Int?
    var totalTimeReductionPercent: Int?
}
// MARK: - StepListJsonb
struct AddMediationStepListJsonbResposeModel: Codable {
    var list: [AddMediationListResponseModel]?
    var estimation: AddMediationEstimationResponseModel?
}

// MARK: - Estimation
struct AddMediationEstimationResponseModel: Codable {
}

// MARK: - List
struct AddMediationListResponseModel: Codable {
    var accepted: Bool??
    var createdAt, updatedAt: String?
    var educativeTimePercent, totalTimeReductionPercent: Int?
}
