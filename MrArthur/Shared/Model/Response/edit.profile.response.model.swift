//
//  edit.profile.response.model.swift
//  MrArthur
//
//  Created by IPS-172 on 21/10/22.
//

import Foundation

// MARK: - EditProfileResponseModel
struct EditProfileResponseModel: Codable {
    let type: String
    let subscription: SubscriptionEditProfile
    let name, gender, birthDate: String
}

// MARK: - Subscription
struct SubscriptionEditProfile: Codable {
    let uuid: String
    let name, maxAttendee: JSONNull?
    let createdAt, updatedAt: String
    let subscriptionObserverUserRoleList: [SubscriptionObserverUserRoleList]
}

// MARK: - SubscriptionObserverUserRoleList
struct SubscriptionObserverUserRoleList: Codable {
    let uuid, role, createdAt, updatedAt: String
    let observerUser: ObserverUser
}

// MARK: - ObserverUser
struct ObserverUser: Codable {
    let type, role, uuid: String
    let active: Bool
    let createdAt, updatedAt: String
    let contact: Contact
}

// MARK: - Contact
struct Contact: Codable {
    let mailNotificationAllowed: Bool
    let email: String
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
