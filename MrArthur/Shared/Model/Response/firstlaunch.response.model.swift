//
//  firstlaunchResponse.swift
//  MrArthur
//
//  Created by IPS-169 on 12/07/22.
//

import Foundation


// MARK: - FirstLaunch
struct FirstLaunch: Codable , Identifiable {
    var id :String? =  UUID().uuidString
    var token: String?
    var user: User?
}

// MARK: - User
struct User: Codable {
    var uuid, type, role: String?
    var subscriptionRoleList: [SubscriptionRoleList]?
}

// MARK: - SubscriptionRoleList
struct SubscriptionRoleList: Codable {
    var uuid, role, createdAt, updatedAt: String?
    var subscription: Subscription?
}

// MARK: - Subscription
struct Subscription: Codable {
    var uuid: String?
    var subscriptionOnboarding: SubscriptionOnboarding?
}

// MARK: - SubscriptionOnboarding
struct SubscriptionOnboarding: Codable {
 //   let id: Int
    var uuid: String?
    var stepListJsonb: StepListJsonb?
    var done: Bool?
    var createdAt, updatedAt: String?
}

// MARK: - StepListJsonb
struct StepListJsonb: Codable {
    var stepList: [StepList]?
    var createdAt: String?
}

// MARK: - StepList
struct StepList: Codable {
    var name: String?
    var type: String?
    var category: String?
    var updatedAt: String?
    var answerList: [String]?

}
