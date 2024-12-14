//
//  ValidateCodeResponse.swift
//  MrArthur
//
//  Created by IPS-169 on 04/08/22.
//

import Foundation

// MARK: - ValidationCodeResponse
enum ESubscriptionValidity: String, Codable {
    case SUBSCRIPTION_ALREADY_VALID = "SUBSCRIPTION_ALREADY_VALID"
    case SUBSCRIPTION_TRIAL_ONGOING = "SUBSCRIPTION_TRIAL_ONGOING"
    case SUBSCRIPTION_TRIAL_EXPIRED = "SUBSCRIPTION_TRIAL_EXPIRED"
    case SUBSCRIPTION_TRIAL_NOT_STARTED = "SUBSCRIPTION_TRIAL_NOT_STARTED"
}

struct SubscriptionIsValidREsponseModel: Codable {
//    var isValid: Bool?
    var subscriptionValidity: ESubscriptionValidity?
}

// MARK: - ValidationCodeResponse
struct ValidationCodeResponseModel: Codable,Identifiable {
    var id :String? =  UUID().uuidString
    var token: String?
    var user: ValidatedUserResponseModel?
}

// MARK: - User
struct ValidatedUserResponseModel: Codable {
    var uuid, type, role: String?
    var contact: ContactResponseModel?
    var subscriptionRoleList: [ValidatedSubscriptionRoleListResponseModel]?
}

// MARK: - SubscriptionRoleList
struct ValidatedSubscriptionRoleListResponseModel: Codable {
    var uuid, role, createdAt, updatedAt: String?
    var subscription: ValidatedSubscriptionResponseModel?
}

// MARK: - Subscription
struct ValidatedSubscriptionResponseModel: Codable {
    var uuid: String?
    var subscriptionOnboarding: ValidatedSubscriptionOnboardingResponseModel?
}

// MARK: - SubscriptionOnboarding
struct ValidatedSubscriptionOnboardingResponseModel: Codable {
    var uuid: String?
    var stepListJsonb: ValidatedStepListJsonbResponseModel?
    var done: Bool?
    var createdAt, updatedAt: String?
}

// MARK: - StepListJsonb
struct ValidatedStepListJsonbResponseModel: Codable {
    var stepList: [ValidatedStepListResponseModel]?
    var createdAt: String?
}

// MARK: - StepList
struct ValidatedStepListResponseModel: Codable {
    var name: String?
    var type: String?
    var category: String?
    var updatedAt: String?
    var answerList: [String]?
}

