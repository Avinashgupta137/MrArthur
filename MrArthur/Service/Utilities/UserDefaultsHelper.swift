//
//  UserDefaultsHelper.swift
//  MrArthur
//
//  Created by Troo on 06/08/22.
//

import Foundation

enum EUserDefaultsKeys: String {
    case appUserType = "io.mrarthur.app_user_type"
    case attendeeManifestoLatestStep = "io.mrarthur.app_user_child_manifesto_lates_step"
    case latestStep = "io.mrarthur.app_user_lates_step"
    case latestAddupStep = "io.mrarthur.app_user_latest_addup_attendee_step"
    case currentUserToken = "io.mrarthur.app_user_current_user_token"
    case educationalEvent = "io.mrarthur.app_educational_event"
    case REDIRECT_TO_SCREEN_ON_LAUNCH = "io.mrarthur.REDIRECT_TO_SCREEN_ON_LAUNCH"
    case SELECTED_ATTENDEE = "io.mrarthur.SELECTED_ATTENDEE"
    case CREATE_ATTENDEE = "io.mrarthur.CREATE_ATTENDEE"
    case SIGN_IN_ROUTE = "io.mrarthur.SIGN_IN_ROUTE"
    case PARING_DEVICE = "io.mrarthur.PARING_DEVICE"
    case CURRENT_USER_ATTENDEE_LIST = "io.mrarthur.CURRENT_USER_ATTENDEE_LIST"
    case SCREEN_TIME_TODAY_ATTENDEE_LIST = "io.mrarthur.SCREEN_TIME_TODAY_ATTENDEE_LIST"
    case SCREEN_TIME_REPORT_7_DAYS_ATTENDEE_LIST = "io.mrarthur.SCREEN_TIME_REPORT_7_DAYS_ATTENDEE_LIST"
    case SCREEN_TIME_REPORT_30_DAYS_ATTENDEE_LIST = "io.mrarthur.SCREEN_TIME_REPORT_30_DAYS_ATTENDEE_LIST"
    case ATTENDEE_SCREEN_TIME_FLAG = "io.mrarthur.ATTENDEE_SCREEN_TIME_FLAG"
    case USER_SUBSCIPTION_FLAG = "io.mrarthur.USER_SUBSCIPTION_FLAG"
    case USER_ACCEPTED_PRIVACY_POLICY = "io.mrarthur.USER_ACCEPTED_PRIVACY_POLICY"
}

typealias ScreenTimeTodayAttendeeListModel = [GetAttendeeScreenTimeTodayDataResponse]
typealias ScreenTimeReportAttendeeListModel = [GetAttendeeScreenTimeReportDataResponse]

class UserDefaultsHelper {
    
    static var userHasAcceptedPrivacyPolicy: Bool {
        get {
            let accepted = UserDefaultsHelper().getData(type: Bool.self, forKey: .USER_ACCEPTED_PRIVACY_POLICY)
            return accepted ?? false
        }
        set {
            UserDefaultsHelper().setData(value: newValue, key: .USER_ACCEPTED_PRIVACY_POLICY)
        }
    }
    
    static var userHasValidSubscription: Bool? {
        get {
            let isValid = UserDefaultsHelper().getData(type: Bool.self, forKey: .USER_SUBSCIPTION_FLAG)
            return isValid
        }
        set {
            UserDefaultsHelper().setData(value: newValue, key: .USER_SUBSCIPTION_FLAG)
        }
    }
    
    static func observerCanAccessToAttendeeSceenTimeDashboard() -> Bool {
        if let attendee = UserDefaultsHelper.selectedAttendee, let uuid = attendee.uuid {
            return UserDefaultsHelper.getAttendeeScreenTimeFlag(uuid: uuid) && attendee.mediationAccepted
        }
        return false
    }
    
    static func getAttendeeScreenTimeFlag(uuid: String?) -> Bool {
        if let uuid = uuid {
            let _key = "io.mrarthur.ATTENDEE_SCREEN_TIME_FLAG_\(uuid)"
            let defaults = UserDefaults.standard
            let value = defaults.object(forKey: _key) as? Bool
            return value ?? false
        }
        return false
    }
    
    static func setAttendeeScreenTimeFlag(uuid: String) {
        let _key = "io.mrarthur.ATTENDEE_SCREEN_TIME_FLAG_\(uuid)"
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: _key)
        defaults.synchronize()
    }
    
    static var signInResponeRoute: SignInResponeRoute? {
        get {
            if let data: Data = UserDefaultsHelper()
                .getData(
                    type: Data.self,
                    forKey: .SIGN_IN_ROUTE
                ) {
                return try? APIHelper().decodeStickers(from: data)
            }
            return nil
        }
        set {
            print("signInResponeRoute SET \(newValue?.manifestoIndex ?? 0)")
            let encoded = try? JSONEncoder().encode(newValue)
            UserDefaultsHelper()
                .setData(
                    value: encoded,
                    key: .SIGN_IN_ROUTE
                )
        }
    }
    
    static var currentUserAttenseeListData: Data? {
        get {
            if let data: Data = UserDefaultsHelper()
                .getData(
                    type: Data.self,
                    forKey: .CURRENT_USER_ATTENDEE_LIST
                ) {
                return data
            }
            return nil
        }
        
        set {
            if let data = newValue {
                UserDefaultsHelper()
                    .setData(
                        value: data,
                        key: .CURRENT_USER_ATTENDEE_LIST
                    )
            }
        }
    }
    
    static var selectedAttendee: AttendeeListResponseModel? {
        get {
            if let data: Data = UserDefaultsHelper()
                .getData(
                    type: Data.self,
                    forKey: .SELECTED_ATTENDEE
                ) {
                return try? APIHelper().decodeStickers(from: data)
            }
            return nil
        }
        set {
            let encoded = try? JSONEncoder().encode(newValue)
            UserDefaultsHelper()
                .setData(
                    value: encoded,
                    key: .SELECTED_ATTENDEE
                )
            ExtensionWidgetDataSource.setCurrrentAttendeeUUID(newValue?.uuid)
        }
    }
    
    static var screenTimeTodayAttendeeList: ScreenTimeTodayAttendeeListModel? {
        get {
            if let data: Data = UserDefaultsHelper().getData(type: Data.self,forKey: .SCREEN_TIME_TODAY_ATTENDEE_LIST) {
                return try? APIHelper().decodeStickers(from: data)
            }
            return []
        }
        
        set {
            if let data = newValue as ScreenTimeTodayAttendeeListModel? {
                let encoded = try? JSONEncoder().encode(data)
                UserDefaultsHelper().setData(value: encoded, key: .SCREEN_TIME_TODAY_ATTENDEE_LIST)
            }
        }
    }
    
    static var screenTimeReport7DaysAttendeeList: ScreenTimeReportAttendeeListModel? {
        get {
            if let data: Data = UserDefaultsHelper().getData(type: Data.self,forKey: .SCREEN_TIME_REPORT_7_DAYS_ATTENDEE_LIST) {
                return try? APIHelper().decodeStickers(from: data)
            }
            return []
        }
        
        set {
            if let data = newValue as ScreenTimeReportAttendeeListModel? {
                let encoded = try? JSONEncoder().encode(data)
                UserDefaultsHelper().setData(value: encoded, key: .SCREEN_TIME_REPORT_7_DAYS_ATTENDEE_LIST)
            }
        }
    }
    
    static var screenTimeReport30DaysAttendeeList: ScreenTimeReportAttendeeListModel? {
        get {
            if let data: Data = UserDefaultsHelper().getData(type: Data.self,forKey: .SCREEN_TIME_REPORT_30_DAYS_ATTENDEE_LIST) {
                return try? APIHelper().decodeStickers(from: data)
            }
            return []
        }
        
        set {
            if let data = newValue as ScreenTimeReportAttendeeListModel? {
                let encoded = try? JSONEncoder().encode(data)
                UserDefaultsHelper().setData(value: encoded, key: .SCREEN_TIME_REPORT_30_DAYS_ATTENDEE_LIST)
            }
        }
    }
    
    
    static var paringDevice: ParingDeviceModel {
        get {
            if let data: Data = UserDefaultsHelper().getData(
                type: Data.self,
                forKey: .PARING_DEVICE
            ) {
                do {
                    return try APIHelper().decodeStickers(from: data)
                } catch let errormodel  {
                    print(errormodel)
                }
            }
            return ParingDeviceModel(
                settingFamilyandInviteChildDone: false,
                paringDevicesDone: false,
                appCategoryPickingDone: false,
                contentFilteringDone: false,
                educationAppInstallationDone: false
            )
        }
        set {
            print("selectedAttendee SET \(newValue.educationAppInstallationDone )")
            let encoded = try? JSONEncoder().encode(newValue)
            UserDefaultsHelper()
                .setData(
                    value: encoded,
                    key: .PARING_DEVICE
                )
        }
    }

    //createAttendeeModel
    static var createAttendee: AddAttendeeRequestModel? {
        get {
            if let data: Data = UserDefaultsHelper()
                .getData(
                    type: Data.self,
                    forKey: .CREATE_ATTENDEE
                ) {
                return try? APIHelper().decodeStickers(from: data)
            }
            return nil
        }
        set {
            print("createAttendee SET \(newValue?.attendeeName ?? "")")
            let encoded = try? JSONEncoder().encode(newValue)
            UserDefaultsHelper()
                .setData(
                    value: encoded,
                    key: .CREATE_ATTENDEE
                )
        }
    }
    
    static var redirectToScreenOnLaunch: ERootView {
        get {
            let name = UserDefaultsHelper().getData(type: String.self, forKey: .REDIRECT_TO_SCREEN_ON_LAUNCH) ?? ""
            return ERootView(rawValue: name) ?? .welcome
        }
        set {
            print("redirectToScreenOnLaunch SET \(newValue.rawValue)")
            UserDefaultsHelper().setData(value: newValue.rawValue, key: .REDIRECT_TO_SCREEN_ON_LAUNCH)
        }
    }
    
    static var currentUserToken: String? {
        get {
            let token = UserDefaultsHelper().getData(type: String.self, forKey: .currentUserToken) ?? ""
            return token
        }
        set {
            UserDefaultsHelper().setData(value: newValue, key: .currentUserToken)
        }
    }
    
    static var appUserType: AppIsUsedBy? {
        get {
            let type = UserDefaultsHelper().getData(type: String.self, forKey: .appUserType) ?? ""
            
            return AppIsUsedBy(rawValue: type) ?? .observer
        }
        set {
            print("appUserType SET \(String(describing: newValue))")
            UserDefaultsHelper().setData(value: newValue?.rawValue, key: .appUserType)
        }
    }
    
    static var latestStep: Int? {
        get {
            return UserDefaultsHelper().getData(type: Int.self, forKey: .latestStep)
        }
        set {
            print("latestStep SET \(String(describing: newValue))")
            UserDefaultsHelper().setData(value: newValue, key: .latestStep)
        }
    }
    
    static var latestAddUpState: Int? {
        get {
            let step = UserDefaultsHelper().getData(type: Int.self, forKey: .latestAddupStep)
            print("latestAddupStep GET \(step ?? 0)")
            return step
        }
        set {
            print("latestAddupStep SET \(String(describing: newValue))")
            UserDefaultsHelper().setData(value: newValue, key: .latestAddupStep)
        }
    }
    
    static var attendeeManifestoLatestStep: Int? {
        get {
            let step = UserDefaultsHelper().getData(type: Int.self, forKey: .attendeeManifestoLatestStep)
            print("attendeeManifestoLatestStep GET \(step ?? 0)")
            return step
        }
        set {
            print("attendeeManifestoLatestStep SET \(String(describing: newValue))")
            UserDefaultsHelper().setData(value: newValue, key: .attendeeManifestoLatestStep)
        }
    }
    
    
}

// MARK: functions
extension UserDefaultsHelper {
    
    static func setQuestionForID(_ data: AnswerModel) {
        if let encoded = try? JSONEncoder().encode(data), let quesID = data.id {
            let key = "QUES_ID_\(quesID)"
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: key)
            defaults.synchronize()
        } else {
            print("failed to setQuestionForID")
        }
    }
    
    static func getQuestionForID(_ quesID: Int) -> AnswerModel? {
        let key = "QUES_ID_\(quesID)"
        let defaults = UserDefaults.standard
        if let value = defaults.object(forKey: key) as? Data {
            return try? APIHelper().decodeStickers(from: value)
        }
        return nil
    }
    static func removeQuestionForID(_ quesID: Int){
        let key = "QUES_ID_\(quesID)"
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key)
    }
    
    private func setData<T>(value: T, key: EUserDefaultsKeys) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key.rawValue)
        defaults.synchronize()
    }
    
    private func getData<T>(type: T.Type, forKey: EUserDefaultsKeys) -> T? {
        let defaults = UserDefaults.standard
        let value = defaults.object(forKey: forKey.rawValue) as? T
        return value
    }
    
    static func remove(_ forKey: EUserDefaultsKeys) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: forKey.rawValue)
    }
}
