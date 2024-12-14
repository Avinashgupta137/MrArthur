//
//  AttendeeListReponse.swift
//  MrArthur
//
//  Created by IPS-169 on 26/07/22.
//

import Foundation

// MARK: - AttendeeListResponseModel
struct AttendeeListResponseModel: Codable {
    var uuid : String?
    var type : String?
    var role: String?
    var name: String?
    var gender : String?
    var intercomEmail: String?
    var birthDate: String?
    var subscriptionUUID: String?
    var attendeeUserMediationList: [AttendeeUserMediationList]?
    var attendeeUserOnboarding: AttendeeUserOnboardingModel?
    var deviceList: [DeviceList]?
    var attendeeUserManifesto: AttendeeHowItsWorkResponse?
    var parentalControlSettings: ATTParentalControlSettings?
    
    var mediationAccepted: Bool {
        let lastStep = attendeeUserMediationList?.last?.stepListJsonb?.list?.last ?? nil
        return lastStep?.accepted ?? false
    }
    
    var mediationCompleted: Bool {
        let completed = attendeeUserManifesto?.done ?? false
        return completed
    }
    
    var attendeeName: String {
        return name ?? "User"
    }
    
    var attendeeDOB: Date {
        if let dob = birthDate, !dob.isEmpty {
            if let dDOB = dob.convertUTCStringToDate(dateFormat: "yyyy-mm-dd'T'hh:mm:ss.SSSZ") {
                return dDOB
            }
        }
        return Date()
    }
    
    var isMale: Bool {
        if gender != nil {
            return gender!.lowercased() == "male"
        }
        return true
    }
    
    var avtar: String {
        if isMale {
            return "iconAvatarProfileBoy"
        } else {
            return "iconAvatarProfileGirl"
        }
    }
    
    var age: Int {
        if let dob = birthDate, !dob.isEmpty {
            if let dDOB = dob.convertUTCStringToDate(dateFormat: "yyyy-mm-dd'T'hh:mm:ss.SSSZ") {
                let diff = Date().interval(ofComponent: .year, fromDate: dDOB)
                return diff
            }
        }
        return 0
    }
}
// MARK: - DeviceList
struct DeviceList: Codable, Identifiable {
    var id : String{
        return uuid ?? ""
    }
    var uuid : String?
    var name : String?
    var model: String?
    var appIdentifier: String?
    var pushNotificationToken: String?//JSONNull?
    var createdAt : String?
    var language : String?
    var updatedAt: String?
    var label: String{
        let name = name ?? ""
        let model = model ?? ""
        return model
    }
}

// MARK: - List
struct List: Codable {
    let accepted: Bool
    let createdAt, updatedAt: String
    let educativeTimePercent, totalTimeReductionPercent: Int
}

// MARK: - AttendeeUserMediationList
struct AttendeeUserMediationList: Codable {
    var uuid: String?
    var stepListJsonb: AttendeeUserMediationListStepListJsonb?
    var createdAt, updatedAt: String?
}

// MARK: - AttendeeUserMediationListStepListJsonb
struct AttendeeUserMediationListStepListJsonb: Codable {
    var list: [MediationStep]?
    var estimation: Estimation?
}

// MARK: - Estimation
struct Estimation: Codable {
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
struct AttendeeUserOnboardingModel: Codable {
    var uuid: String?
    var stepListJsonb: AttendeeUserOnboardingStepListJsonb?
    var createdAt, updatedAt: String?
    var done: Bool?
//    var attendeeUser: AttendeeUserResponseModel?
    var isOnbardingCompleted: Bool {
        return done ?? false
    }
}

// MARK: - AttendeeUserOnboardingStepListJsonb
struct AttendeeUserOnboardingStepListJsonb: Codable {
    var stepList: [StepList]?
    var createdAt: String?
}


struct ATTParentalControlSettings: Codable {
    var createdAt: String?
    var preset: String?
    var restPeriod: ERestPeriod?
    var updatedAt: String?
    var uuid: String?
}

enum ERestPeriod: String, Codable {
    case REST_23_TO_06 = "REST_23_TO_06"
    case REST_19_TO_08 = "REST_19_TO_08"
    case REST_21_TO_07 = "REST_21_TO_07"
    case NO_REST = "NO_REST"
    case NOT_SET_YET = "NOT_SET_YET"
}

enum Category: String, Codable {
    case onboardingHowItWorks = "ONBOARDING_HOW_IT_WORKS"
    case onboardingManifesto = "ONBOARDING_MANIFESTO"
    case onboardingQuestion = "ONBOARDING_QUESTION"
}

enum TypeEnum: String, Codable {
    case explanation = "EXPLANATION"
    case question = "QUESTION"
}

//typealias AttendeeListResponseModel = [AttendeeListResponseModelElement]

