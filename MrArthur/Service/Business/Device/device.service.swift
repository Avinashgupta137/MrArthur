//
//  device.service.swift
//  MrArthur
//
//  Created by Reille Sebastien on 18/08/2022.
//

import Foundation
import SwiftUI
import DeviceKit

class DeviceService {
    static func registerDevice(completion: @escaping(Bool?) -> ()) {
//        dump("REGISTERDEVICE")
        let appIdentifier = DeviceService.getAppIdentifier()
        let deviceName = DeviceService.getDeviceName()
        let deviceModel = DeviceService.getDeviceModel()
        let deviceLanguage: ELanguage = DeviceService.getDeviceLanguage()
//        let iCloudUserRecordId = await CloudKitService.userRecordId()
        let timeZoneSecondsFromGMT = DeviceService.getDeviceTimeZoneSecondsFromGMT()
        
        var parameters = RegisterDeviceParameters(
            appIdentifier: appIdentifier,
            name: deviceName,
            model: deviceModel,
            language: deviceLanguage
        )

        if let seconds = timeZoneSecondsFromGMT {
            parameters.timeZoneSecondsFromGMT = seconds
        }

//        if let iCloudUserRecordId = iCloudUserRecordId {
//            parameters.iCloudUserRecordId = iCloudUserRecordId
//        }
        
        CloudKitService.userRecordId() { id in
            if let iCloudUserRecordId = id {
                parameters.iCloudUserRecordId = iCloudUserRecordId
            }
            DeviceApiCall().register(param: parameters) { errorMessage, deviceResponse in
                if let device = deviceResponse {
//                    print("device registered: ")
//                    dump(device)
                    completion(true)
                } else {
                    dump("error while registering device \(errorMessage)")
                    completion(nil)
                }
            }
        }
    }
    
    static func setDeviceToken(token: String) -> Void {
        let appIdentifier = DeviceService.getAppIdentifier()
        let parameters = SetDeviceTokenParameters(appIdentifier: appIdentifier, pushNotificationToken: token)
        
//        await DeviceService.registerDevice()
        DeviceService.registerDevice() { success in
            if let success = success, success {
                DeviceApiCall().setToken(param: parameters) { errorMessage, deviceResponse in
//                    if let device = deviceResponse {
//                        print("device token set: ")
//                        dump(device)
//                    }
                }
            }
        }
        
//        await NetworkService.postMethod(path: "/device/ios/set-token", parameters: parameters, withUserToken: true)
    }
    
    static func getAppIdentifier() -> String {
        let appIdentifier: String = UIDevice.current.identifierForVendor!.uuidString
        print("appIdentifier: \(appIdentifier)")
        return appIdentifier
    }
    
    static func getDeviceName() -> String {
        let deviceName: String = UIDevice.current.name
//        UIDevice.current.accessibilityLanguage
        print("device name: \(deviceName)")
        return deviceName
    }
    
    static func getDeviceModel() -> String {
        let deviceModel: String = "\(Device.current)"
        print("device model: \(deviceModel)")
        return deviceModel
    }

    static func getDeviceLanguage() -> ELanguage {
        let deviceLanguage = String(Locale.preferredLanguages[0].components(separatedBy: "-")[0])
//        print("device language: \(deviceLanguage)")
        switch deviceLanguage {
        case "en":  return .en
        case "fr": return .fr
        default: return .en
        }
    }

    static func getDeviceTimeZoneSecondsFromGMT() -> Int? {
        return Int(TimeZone.current.secondsFromGMT())
    }
    
    static func getCountryCode() -> String{
        let localRegion = Locale.current
        let countryCode = localRegion.regionCode!
        return countryCode
    }
}

