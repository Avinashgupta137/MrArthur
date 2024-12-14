//
//  Constant.swift
//  MrArthur
//
//  Created by IPS-157 on 07/07/22.
//

import Foundation
import UIKit

enum ETabPage {
    case page_01, page_02, page_03, page_04
}

var isApplication: Bool {
#if UIApplication
    return true
#endif
    return false
}

enum EScheme {
    case PRODUCTION
    case DEVELOPEMENT
    case STAGING
    case SEBASTIEN
}

var currentScheme: EScheme {
    var scheme = EScheme.STAGING
#if ENV_DEV
    scheme = .DEVELOPEMENT
#elseif ENV_SEBASTIEN
    scheme = .SEBASTIEN
#elseif ENV_PROD
    scheme = .PRODUCTION
#endif
    return scheme
}

var isDevelop: Bool {
    return currentScheme == .SEBASTIEN || currentScheme == .DEVELOPEMENT
}

var isSebastienEnv: Bool {
    return currentScheme == .SEBASTIEN
}

var isStaging: Bool {
    return currentScheme == .STAGING
}

var isProduction: Bool {
    return currentScheme == .PRODUCTION
}

struct DeviceDetails {
    static let UDID = "DeviceUDID"
    static let Name = "DeviceName"
}

struct ConstantOfApp {
    static let kAppUrl = "https://apps.apple.com/us/app/mr-arthur-parental-control-app/id6443722754"
    static let kObserverUserToken = "token"
    static let kAttendeeUserToken = "attendeeToken"
    static let kIcloudAccountUUID = "iCloudAccountUUID"
    static let kCurrentUserRole = "currentUserRole"
    static let kUUIDForSubscription = "uuidForSubscription"
    static let kAttendeeUUID = "uuidOfAttendee"
    static let kUserType = "userType"
    static let kIdentifiedUser = "identifiedUser"
    static let kScreenNameList = "screenNameListOfApp"
    static let kArrOfAttendeeScreenList = "screenNameListOfAttendeeApp"
    static let kArrOfQuestion = "arrOfQuestion"
    static let kArrOfAttendeeQuestion = "arrOfAttendeeQuestion"
    static let kCurrentQuestion = "currentQuestion"
    static let kCurrentAttendeeQuestion = "currentAttendeeQuestion"
    static let kSelectedQuestion = "selectedQuestion"
    static let kAppSettingDone = "appSettingDone"
    static let kSelectedAttendeeQuestion = "selectedAttendeeQuestion"
    static let kEmailId = "emialOfUser"
    static let kObserverEmail = "observerEmail"
    static let kObserverUUID = "observerUUID"
    static let kMediationUDID = "attendeeMedationUDID"
    static let kMediationNotCreated = "meditetionNotCreatedyet"
    static let kMediationApproved = "meditationApproved"
    static let kMediationRejected = "meditetionRejected"
    static let kMediationUnderApproval = "meditationUnderApproval"
    static let kStatusOfMeditation = "statusOfMeditation"
    static let kObserverTokenSend = "parentTokenShouldSend"
    static let kAttendeeTokenSend = "attendeeTokenShouldSend"
    static let kNoneTokenSend = "noneTokenShouldSend"
    static let kCurrentUserObserver = "observer"
    static let kCurrentUserAttendee = "attendee"
    static let kErrorDefaultMessage = "Something went wrong"
    static let kIsUserNewOrExist  = "userNewOrExist"
    static let kNewUser = "newUser"
    static let kExistingUser = "existingUser"
    
    //MARK: Notification Type::
    static let kNotificationGoalRejectedAttendee = "goal-rejected-attendee-push"
    static let kNotificationGoalRejectedObserver = "goal-rejected-observer-push"
    static let kNotificationGoalSentObserver = "goal-sent-observer-push"
    static let kNotificationGoalSentAttendee = "goal-sent-attendee-push"
    static let kNotificationInstallOnAttendeeObserver = "install-on-child-phone-observer-push"
    static let kNotificationSendGoalAttendee = "send-your-goal-attendee-push"
    static let kNotificationSendGoalObserver = "send-your-goal-observer-push"
    static let kNotificationLatestStepObserver = "help-for-settings-observer-push"
}

func isiPad() -> Bool {
    return UIDevice.current.userInterfaceIdiom == .pad ? true : false
}

var isSimulator: Bool {
#if targetEnvironment(simulator)
    return true
#else
    return false
#endif
    
}
