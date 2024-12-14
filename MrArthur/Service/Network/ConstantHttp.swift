//
//  ConstantHttp.swift
//  MrArthur
//
//  Created by IPS-169 on 12/07/22.
//

import Foundation

struct ConstantHttp {
    
    //MARK: Observer app url
    static let constantFirstLaunchURL = String.init(format: "\(environmentUrl.appBaseURL)\("observer-user/first-launch")")
    static let onboardingExplanationURL = String.init(format: "\(environmentUrl.appBaseURL)\("observer-user/onboarding-step/explanation")")
    static let observerQuestionListURL = String.init(format: "\(environmentUrl.appBaseURL)\("observer-user/onboarding-step/question")")
    static let observerLoginURL = String.init(format: "\(environmentUrl.appBaseURL)\("observer-user/login-email")")
    static let validateCodeURL = String.init(format: "\(environmentUrl.appBaseURL)\("observer-user/validate-code")")
    static let validateSubscriptionURL = (environmentUrl.appBaseURL) + "subscription/"
    //MARK: Attende app url
    static let getAttendee = String.init(format: "\(environmentUrl.appBaseURL)\("observer-user/attendee-user/")")
    static let createAttendeeURL = String.init(format: "\(environmentUrl.appBaseURL)\("observer-user/create-attendee-with-time-estimate")")
    static let attendeeListURL = String.init(format:"\(environmentUrl.appBaseURL)\("observer-user/subscription/")")
    static let attendeeAddEstimateURL = String.init(format:"\(environmentUrl.appBaseURL)\("observer-user/add-up-step/attendee-user-screen-time-estimate")")
    
    static let attendeeLoginURL = String.init(format: "\(environmentUrl.appBaseURL)\("observer-user/attendee-user/")")
    static let attendeeOnboardingExplanationURL = String.init(format: "\(environmentUrl.appBaseURL)\("attendee-user/onboarding-step/explanation")")
    static let attendeeQuestionListURL = String.init(format: "\(environmentUrl.appBaseURL)\("attendee-user/onboarding-step/question")")
    
    //MARK: Mediation url
    
    static let approveMediationURL = String.init(format: "\(environmentUrl.appBaseURL)\("attendee-user-mediation/")")
    static let attendeeMediationDetailURL = String.init(format: "\(environmentUrl.appBaseURL)\("attendee-user-mediation/")")
    static let addStepMeditationURL = String.init(format: "\(environmentUrl.appBaseURL)\("attendee-user-mediation/")")
    static let getScreenEstimateTimeURL = String.init(format: "\(environmentUrl.appBaseURL)\("attendee-user-mediation/")")
    static let getLatestAcceptedMediation = String.init(format: "\(environmentUrl.appBaseURL)attendee-user-mediation/\("\(UtilityMethod().getValueForKey(key: ConstantOfApp.kAttendeeUUID) as? String ?? "")/latest-accepted")")
    
    //MARK: Device app url
    static let deviceRegisterURL = String.init(format: "\(environmentUrl.appBaseURL)\("device/ios/register")")
    static let deviceSetTokenURL = String.init(format: "\(environmentUrl.appBaseURL)\("device/ios/set-token")")
    
    //MARK: User url
    static let userGetMeURL = String.init(format: "\(environmentUrl.appBaseURL)\("user/me")")
    
    
    //MARK: iCloud Url
    static let getDetailsiCloudAccountURL = String.init(format: "\(environmentUrl.appBaseURL)\("attendee-user/\(UtilityMethod().getValueForKey(key: ConstantOfApp.kAttendeeUUID) as? String ?? "")/parental-control-settings")")
    static let getParentSettingURL = String.init(format: "\(environmentUrl.appBaseURL)\("attendee-user/")")
    static let updateParentControlSettingURL = String.init(format: "\(environmentUrl.appBaseURL)\("attendee-user/\(UtilityMethod().getValueForKey(key: ConstantOfApp.kAttendeeUUID) as? String ?? "")/parental-control-settings/preset")")
    static let getRestPeriodURL = String.init(format: "\(environmentUrl.appBaseURL)\("attendee-user/")")
    
    //MARK: Recommended Application
    static let getRecommendedAppURL = String.init(format: "\(environmentUrl.appBaseURL)\("device/ios/recommended-mobile-application/")")
    static let getListOfMediaURL = String.init(format: "\(environmentUrl.appBaseURL)\("media/")")
    static let installrecommendedAppURL = String.init(format: "\(environmentUrl.appBaseURL)\("device/ios/\(DeviceService.getAppIdentifier())/installed-recommended-mobile-application")")
    static let deleteAttendeeURL = String.init(format: "\(environmentUrl.appBaseURL)\("attendee-user/")")
    static let deleteSubscriptionURL = String.init(format: "\(environmentUrl.appBaseURL)\("subscription/")")
    static let editAttendeeURL = String.init(format: "\(environmentUrl.appBaseURL)\("attendee-user/")")
    
    //MARK: How its work Attendee Validation
    static let mediationApproveSteps = String.init(format: "\(environmentUrl.appBaseURL)\("attendee-user-manifesto/step-validation")")
}
