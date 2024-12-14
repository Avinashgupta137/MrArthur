//
//  current.user.model.swift
//  MrArthur
//
//  Created by Reille Sebastien on 23/08/2022.
//

import Foundation

typealias CurrentUser = (observerUser: ObserverCurrentUser?, attendeeUser: AttendeeCurrentUser?)

//typealias userMe CurrentUser = ()

struct ObserverCurrentUser: Decodable {
    var uuid: String
    var type: EUserType
//    var subscriptionRoleList: [SubscriptionObserverUserRole]?
    var contact: ContactEmbeddedColumn?
}

struct ContactEmbeddedColumn: Decodable {
    let email: String?
}

struct SubscriptionObserverUserRole: Codable {
    var subscription: Subscription
    var uuid, createdAt, updatedAt: String
    var role: ESubscriptionUserRole
}

enum ESubscriptionUserRole: String, Codable {
    case USER = "USER"
    case ADMINISTRATOR = "ADMINISTRATOR"
    case REFERENT = "REFERENT"
}

// ATTENDEE

// MARK: - AttendeeCurrentUser
struct AttendeeCurrentUser: Decodable {
    var uuid: String
    var type: EUserType
    var intercomEmail: String
    var subscriptionUUID: String?
    var mediationList: [AttendeeUserMediation]?
    var attendeeUserOnboarding: AttendeeUserOnboardingModel?
}

// MARK: - Mediation

struct AttendeeUserMediation: Decodable {
    var uuid: String?
    var stepListJsonb: AttendeeMediationStepListJsonb?
    var createdAt: String?
    var updatedAt: String?
}

// MARK: - AttendeeUserMediationListStepListJsonb

struct AttendeeMediationStepListJsonb: Decodable {
    let list: [AttendeeMediationStep]
    let estimation: AttendeeEstimation
}

struct AttendeeMediationStep: Decodable {
    let totalTimeReductionPercent, educativeTimePercent: Int
    let accepted: Bool
    let createdAt, updatedAt: String
}

// MARK: - Estimation

struct AttendeeEstimation: Decodable {
    let dailyTVMinutes, totalScreenTimeMinutes: Int
}

// MARK: - AttendeeUserOnboarding

struct AttendeeOnboarding: Decodable {
    var uuid: String?
    var stepListJsonb: AttendeeOnboardingStepListJsonb?
    var createdAt: String?
    var updatedAt: String?
}

// MARK: - AttendeeUserOnboardingStepListJsonb

struct AttendeeOnboardingStepListJsonb: Decodable {
    var stepList: [AttendeeOnboardingStep]?
    var createdAt: String?
}

// MARK: - AttendeeUserOnboardingStep

struct AttendeeOnboardingStep: Decodable {
    var name: String?
    var type: String?
    var category: String?
    var updatedAt: String?
//    var answerList: [JSONAny]??
}

enum AttendeeOnboardingStepCategory: String, Codable {
    case ONBOARDING_HOW_IT_WORKS = "ONBOARDING_HOW_IT_WORKS"
    case ONBOARDING_MANIFESTO = "ONBOARDING_MANIFESTO"
    case ONBOARDING_QUESTION = "ONBOARDING_QUESTION"
}

enum AttendeeOnboardingStepType: String, Codable {
    case EXPLANATION = "EXPLANATION"
    case QUESTION = "QUESTION"
}

// MARK: - EUserType

enum EUserType: String, Codable {
    case ATTENDEE_USER = "ATTENDEE_USER"
    case OBSERVER_USER = "OBSERVER_USER"
}

enum EStepType: String, Codable {
    case EXPLANATION = "EXPLANATION"
    case QUESTION = "QUESTION"
}



// Current User new model
struct CurrentObserverUser: Codable {
    var uuid: String?
    var type: String?
    var role: String?
    var subscriptionRoleList: [UserRole]?
    var deviceList: [UserDevice]?
}

struct UserRole: Codable {
    var uuid: String?
    var role: String?
    var createdAt: String?
    var updatedAt: String?
    var subscription : RoleSubscription?
}

struct RoleSubscription: Codable {
    var uuid: String?
    var subscriptionOnboarding: RoleSubscriptionOnboarding?
}

struct RoleSubscriptionOnboarding: Codable {
    var uuid: String?
    var stepListJson: OnboardingStepList?
    var done: Bool?
    var createdAt: String?
    var updatedAt: String?
}

struct OnboardingStepList: Codable {
    var stepList: [OnboardingStep]?
    var createdAt: String?
}

struct OnboardingStep: Codable {
    var name: String?
    var type: EStepType?
    var category: String?
    var updatedAt: String?
    var answerList: [String]?
}


struct UserDevice: Codable {
    var uuid: String?
    var name: String?
    var model: String?
    var appIdentifier: String?
    var pushNotificationToken: String?
    var createdAt: String?
    var language: String?
    var updatedAt: String?
}
