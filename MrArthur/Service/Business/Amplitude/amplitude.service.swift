//
//  amplitude.service.swift
//  MrArthur
//
//  Created by Reille Sebastien on 13/09/2022.
//

import Foundation
import Amplitude

class AmplitudeService {
    static func sendEventWithData(key: EAmplitudeEventKey, data : [String:Any] = [:]) {
       // print("key = \(key) , data = \(data)")
//        Amplitude.instance().logEvent(key.rawValue, withEventProperties: data)
        AmplitudeService.sendEvent(key: key, data: data)
    }

    static func sendEvent(key: EAmplitudeEventKey, data: [String: Any] = [:]) {
      //  print("key = \(key) for Amplitude key")
//        let userId: String = CurrentUserService.
//        let userUUID: String
//        let userEmail: String
//        let observerEmail: String
        CurrentUserService.shared.getBasicInformation { info in
//            dump("INFO \(info)")
            if let info = info {
//                dump("INFO USER ID \(info.email ?? info.uuid)")
//                Amplitude.instance().setUserId(info.email ?? info.uuid)
                Amplitude.instance().setUserId(info.observerUUID)
                let properties = [
                    "user_uuid": info.uuid,
                    "email": info.email ?? "NULL",
                    "user_type": info.type.rawValue,
                    "observer_email": info.observerEmail ?? "NULL",
                    "anonymous_icloud_id": info.anonymousICloudId
                ].merging(data) {(current, _) in current}
                
                Amplitude.instance().logEvent(
                    key.rawValue,
                    withEventProperties: properties,
                    withUserProperties: properties
                )
            } else {
                let anonymousICloudId: String = CloudKitService.getAnonymousIcloudId()
//                Amplitude.instance().setUserId(anonymousICloudId)
                let properties = [
                    "user_uuid": "NULL",
                    "email": "NULL",
                    "observer_email": "NULL",
                    "user_type": "NULL",
                    "anonymous_icloud_id": anonymousICloudId
                ].merging(data) {(current, _) in current}
                
                Amplitude.instance().logEvent(
                    key.rawValue,
                    withEventProperties: properties,
                    withUserProperties: properties
                )
            }
        }
    }
    
    static func getAmplitudeKey() -> String {
        var key = "f612c93af7a98eaf8146efc677299c6c"
        if isStaging {
            key = "b8bd2dbc3ba0e11f80155f5ac374e683"
        } else if isProduction {
            key = "5d674b53e46a5de8cb785a9992683fe8"
        }
        return key
    }
    
    static func load() {
//        let trackingOptions: AMPTrackingOptions = AMPTrackingOptions(array: [])
//        Amplitude.instance().setTrackingOptions(trackingOptions)
        AmplitudeService.disableSensitiveDataAttendeeTracking()
        Amplitude.instance().trackingSessionEvents = true
        Amplitude.instance().initializeApiKey(AmplitudeService.getAmplitudeKey())
//        Amplitude.instance().setUserId(CloudKitService.getAnonymousIcloudId())
//        Amplitude.instance().logEvent("app_start")
        AmplitudeService.sendEvent(key: EAmplitudeEventKey.APP_START)
    }

    static func disableSensitiveDataAttendeeTracking() {
        Amplitude.instance().disableCoppaControl()
    }

    static func enableSensitiveDataAttendeeTracking() {
        Amplitude.instance().enableCoppaControl()
    }
}
