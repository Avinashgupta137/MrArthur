//
//  api.call.extension.service.swift
//  MrArthur
//
//  Created by Reille Sebastien on 30/09/2022.
//

import Foundation
import SwiftUI

struct PostAttendeeTimeSpentResponse: Codable {
    var totalMultiDeviceSecondSpent, multiDeviceEducationalQuarterOngoing: Int
}

struct GetAttendeeScreenTimeReportDataResponse: Codable {
    var attendeeUserUUID: String
    var educationalTimeSpent,
        entertainmentTimeSpent,
        entertainmentScreenTimeSecondAllowed,
        educationalScreenTimeSecondCommitment,
        unlockedEntertainmentTime,
        averageScreenTimePerDay: Int
}

struct GetAttendeeScreenTimeTodayDataResponse: Codable {
    var attendeeUserUUID: String?
    var multiDeviceEducationalTimeSpent,
        multiDeviceEntertainmentTimeSpent,
        entertainmentScreenTimeSecondAllowed,
        educationalScreenTimeSecondCommitment,
        multiDeviceEducationalQuarterReached,
        multiDeviceUnlockedTime,
        totalSecondSavedFromBeginning: Int?
    
    var eduTimeSpent: Int {
        return multiDeviceEducationalTimeSpent ?? 0
    }
    var entTimeSpent: Int {
        return multiDeviceEntertainmentTimeSpent ?? 0
    }
    var entScreenTimeSecondAllowed: Int {
        return entertainmentScreenTimeSecondAllowed ?? 0
    }
    var eduScreenTimeSecondCommitment: Int {
        return educationalScreenTimeSecondCommitment ?? 0
    }
    var eduQuarterReached: Int {
        return multiDeviceEducationalQuarterReached ?? 0
    }
    var unlockedTime: Int {
        return multiDeviceUnlockedTime ?? 0
    }
    var totalSecondSaved: Int {
        return totalSecondSavedFromBeginning ?? 0
    }
}

enum EScreenTimeType: String {
    case ENTERTAINMENT = "ENTERTAINMENT"
    case EDUCATIONAL = "EDUCATIONAL"
    case ALL_CATEGORIES = "ALL_CATEGORIES"
}

class ExtensionApiCallService {
    static let shared: ExtensionApiCallService = ExtensionApiCallService()
    public var userToken: String? = nil // ExtensionApiCallService.getCurrentToken()
    
    static func getSendTimeSpentParameters(secondSpent: Int, screenTimeType: EScreenTimeType) -> Dictionary<String, Any> {
        let unlockedEntertainmentModel: EntertainmentUnlockedTimeModel = ExtensionScreenTimePermissionService
            .getUnlockedEntertainmentTimeModel()
        return [
            "screenTimeType": screenTimeType.rawValue,
            "secondSpent": secondSpent,
            "appIdentifier": ExtensionApiCallService.getAppIdentifier(),
            "entertainmentUnlockedTimeSecond": unlockedEntertainmentModel.entertainmentUnlockedTimeSecond,
            "educationalQuarterOngoing": unlockedEntertainmentModel.eudcationalQuarterOngoing,
            "dateTimeZone": ExtensionDeviceActivityService.getTodayDateTimeZoned(),
            "dateTimeZoneDescription": ExtensionDeviceActivityService.getTodayDateTimeZonedDescription(),
            //            "screenShotNumber": ExtensionDeviceActivityService.getTodayIncrementalNumber()
        ] as Dictionary<String, Any>
    }
    
    static func postAttendeeTimeSpent(secondSpent: Int, screenTimeType: EScreenTimeType, withModulo: Bool = true) -> Void {
        //        print("parameters: ")
        //        dump(ExtensionApiCallService.getSendTimeSpentParameters(secondSpent: secondSpent, screenTimeType: screenTimeType))
        if (withModulo && !ExtensionApiCallService.callHasToBeDoneFromModulo(secondSpent: secondSpent, screenTimeType: screenTimeType)) {
            return
        }
        
        ExtensionApiCallService.post(
            //            path: ExtensionApiCallService.getPostAttendeeScreenTimePath(screenTimeType: screenTimeType),
            path: "attendee-user/screen-time/time-spent",
            parameters: ExtensionApiCallService.getSendTimeSpentParameters(secondSpent: secondSpent, screenTimeType: screenTimeType),
            withToken: true
        ) { data in
            if let resData = data {
                let dData = Data(resData)
                if let model: PostAttendeeTimeSpentResponse = try? ExtensionApiCallService.decodeData(from: dData) {
                    ExtensionApiCallService.handlePostAttendeeScreenTimeResponse(
                        screenTimeType: screenTimeType,
                        model: model
                    )
                }
            }
        }
    }
    
    static func callHasToBeDoneFromModulo(secondSpent: Int, screenTimeType: EScreenTimeType) -> Bool {
        if (screenTimeType == .ALL_CATEGORIES) {
            return secondSpent % 60 < 5
        }
        return secondSpent % 10 < 5
    }
    
    static func handlePostAttendeeScreenTimeResponse(screenTimeType: EScreenTimeType, model: PostAttendeeTimeSpentResponse) -> Void {
        ExtensionEducationalService.setEducationalSTQuarterOnGoing(number: model.multiDeviceEducationalQuarterOngoing)
        //        ExtensionDeviceActivityService.setTodayIncrementalNumber(number: model.multiDeviceScreenShotNumber)
        switch screenTimeType {
        case EScreenTimeType.ENTERTAINMENT:
            ExtensionEntertainmentService.increaseEntertainmentSTSecondSpentDayMultiDevice(
                totalMultiDeviceSecondSpent: model.totalMultiDeviceSecondSpent
            )
        case EScreenTimeType.EDUCATIONAL:
            ExtensionEducationalService.increaseEducationalSTSecondSpentDayMultiDevice(
                totalMultiDeviceSecondSpent: model.totalMultiDeviceSecondSpent
            )
        case EScreenTimeType.ALL_CATEGORIES:
            ExtensionAllCategoriesService.increaseAllCategoriesSTSecondSpentDayMultiDevice(
                totalMultiDeviceSecondSpent: model.totalMultiDeviceSecondSpent
            )
        }
        let _ = ExtensionScreenTimePermissionService.getEntertainmentScreenTimeSecondLeftToday()
    }
    
    static func getAttendeeScreenTimeTodayData(
        attendeeUserUUID: String,
        completion: @escaping(GetAttendeeScreenTimeTodayDataResponse?) -> ()
    ) {
        ExtensionApiCallService.get(
            path: "attendee-user/screen-time/\(attendeeUserUUID)/today-data",
            withToken: true
        ) { data in
            if let resData = data {
                let dData = Data(resData)
                if let model: GetAttendeeScreenTimeTodayDataResponse = try? ExtensionApiCallService.decodeData(from: dData) {
                    completion(model)
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    static func getAttendeeScreenTimeReportData(
        attendeeUserUUID: String,
        numberOfDay: Int,
        completion: @escaping(GetAttendeeScreenTimeReportDataResponse?) -> ()
    ) {
        ExtensionApiCallService.get(
            path: "attendee-user/screen-time/\(attendeeUserUUID)/\(numberOfDay)/report-data",
            withToken: true
        ) { data in
            if let resData = data {
                let dData = Data(resData)
                if let model: GetAttendeeScreenTimeReportDataResponse = try? ExtensionApiCallService.decodeData(from: dData) {
                    completion(model)
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    static func sendLog(log: String) {
        let params = ["log": log] as Dictionary<String, Any>
        ExtensionApiCallService.post(
            path: "dev-helper/logs",
            parameters: params,
            withToken: false
        ) { data in }
    }
    
    static func post(
        path: String,
        parameters: Dictionary<String, Any>,
        withToken: Bool,
        completion: @escaping (Data?) -> Void
    ) {
        if let url = URL(string: "\(ExtensionApiCallService.getApiBaseUrl())\(path)"),  Reachability.isConnectedToNetwork() {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            if withToken {
                request.setValue( "Bearer \(ExtensionApiCallService.getCurrentToken())", forHTTPHeaderField: "Authorization")
            }
            
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                if let responseD = response as? HTTPURLResponse, responseD.statusCode == 201 {
                    if let resData = data, resData.count > 0 {
                        do {
                            let _ = try JSONSerialization.jsonObject(with: resData, options: .mutableContainers)
                            completion(resData)
                        } catch {
                            completion(nil)
                        }
                    } else {
                        completion(nil)
                    }
                } else if let _ = error {
                    completion(nil)
                }
            })
            task.resume()
        } else {
            completion(nil)
        }
    }
    
    static func get(
        path: String,
        withToken: Bool,
        completion: @escaping (Data?) -> Void
    ) {
        if let url = URL(string: "\(ExtensionApiCallService.getApiBaseUrl())\(path)"), Reachability.isConnectedToNetwork() {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            if withToken {
                request.setValue( "Bearer \(ExtensionApiCallService.getCurrentToken())", forHTTPHeaderField: "Authorization")
            }
            
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                if let responseD = response as? HTTPURLResponse, responseD.statusCode == 200 {
                    if let resData = data, resData.count > 0 {
                        do {
                            let _ = try JSONSerialization.jsonObject(with: resData, options: .mutableContainers)
                            completion(resData)
                        } catch {
                            completion(nil)
                        }
                    } else {
                        completion(nil)
                    }
                } else if let _ = error {
                    completion(nil)
                }
            })
            
            task.resume()
        } else {
            completion(nil)
        }
    }
    
    static func decodeData<T: Decodable>(from data: Data) throws -> T {
        try JSONDecoder().decode(T.self, from: data)
    }
    
    static func getAppIdentifier() -> String {
        UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
    
    static func getCurrentToken() -> String {
        if (ExtensionApiCallService.getUserTokenHasChanged() || ExtensionApiCallService.shared.userToken == nil) {
            let token = KeychainService.getKeychainGroupValue(key: EKeychainGroupKey.CURRENT_USER_TOKEN) ?? ""
            ExtensionApiCallService.shared.userToken = token
            //            ExtensionApiCallService.sendLog(log: "token: \(token)")
            ExtensionApiCallService.setUserTokenHasChanged(value: false)
        }
        if let token = ExtensionApiCallService.shared.userToken {
            //            ExtensionApiCallService.sendLog(log: "token2: \(token)")
            return token
        } else {
            //            ExtensionApiCallService.sendLog(log: "token3: \(ExtensionApiCallService.shared.userToken)")
            return ""
        }
    }
    
    static func getUserTokenHasChanged() -> Bool {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.USER_TOKEN_HAS_CHANGED,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var userTokenHasChanged: Bool = true
        return userTokenHasChanged
    }
    
    static func setUserTokenHasChanged(value: Bool) -> Void {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.USER_TOKEN_HAS_CHANGED,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var userTokenHasChanged = true
        userTokenHasChanged = value
    }
    
    static func getApiBaseUrl() -> String {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.API_BASE_URL,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var getApiBaseUrl: String = environmentUrl.defaultBaseUrl
        return getApiBaseUrl
    }
    
    static func setApiBaseUrl(url: String) -> Void {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.API_BASE_URL,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var apiBaseUrl: String = environmentUrl.defaultBaseUrl
        apiBaseUrl = url
    }
}
