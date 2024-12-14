//
//  AddstrpmeditationResponse.swift
//  MrArthur
//
//  Created by Sébastien Reille on 19/08/22.
//

import Foundation

// MARK: - RegisterDeviceResponseModel
struct DeviceResponseModel: Decodable { // }, Identifiable {
//    var id :String? =  UUID().uuidString ?? ""
    let uuid, name, model, appIdentifier, createdAt, updatedAt: String
    let language: ELanguage
//    let iosIcloudAccount: IosIcloudAccountResponseModel?
}

// MARK - ParentalControlSeetingsResponse
struct ParentalControlSettingsResponse: Decodable {
    let uuid, createdAt, updatedAt: String
    let preset: EParentalControlSettingsPreset
    let restPeriod: EResetTime
}

// MARK: - IosIcloudAccountResponse
struct IosIcloudAccountResponseModel: Decodable { // }, Identifiable {
//    var id :String? =  UUID().uuidString ?? ""
    let uuid, model, appVendorIdentifier, createdAt, updatedAt: String
    let userRecordId: String?
    let parentalControlSettingsJSONB: ParentalControlSettingsJSONBResponseModel?
    let parentalControlSettingsPreset: EParentalControlSettingsPreset
}

// MARK: - ParentalControlSettingsJSONBResponse
struct ParentalControlSettingsJSONBResponseModel: Decodable {
    let appStoreSettings: AppStoreSettingsResponseModel
    let mediaSettings: MediaSettingsResponseModel
    let webContentSettings: WebContentSettingsResponseModel
}

// MARK: - AppStoreSettingsResponse
struct AppStoreSettingsResponseModel: Decodable {
    let maximumRating: Int
}

// MARK: - MediaSettingsResponse
struct MediaSettingsResponseModel: Decodable {
        let maximumMovieRating: Int
        let maximumTVShowRating: Int
        let denyExplicitContent: Bool
        let denyBookStoreErotica: Bool
}

// MARK: - WebContentSettingsResponse
struct WebContentSettingsResponseModel: Decodable {
    let filterPolicy: EFilterPolicy
}

// MARK: - EFilterPolicy
enum EFilterPolicy: String, Codable {
    case ALL = "ALL"
    case AUTO = "AUTO"
    case NONE = "NONE"
    case SPECIFIC = "SPECIFIC"
}

// MARK: - EParentalControlSettingsPreset
enum EParentalControlSettingsPreset: String, Codable {
    case NOT_SET_YET = "NOT_SET_YET"
    case FROM_08 = "FROM_08"
    case FROM_10 = "FROM_10"
    case FROM_12 = "FROM_12"
    case NO_FILTER = "NO_FILTER"
}

//MARK: EResetTime
enum EResetTime: String,Codable{
    case TO19_08 = "REST_19_TO_08"
    case TO23_06 = "REST_23_TO_06"
    case TO21_07 = "REST_21_TO_07"
    case NO_REST  = "NO_REST"
    case NOT_SET_YET = "NOT_SET_YET"
}
