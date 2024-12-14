//
//  apps.flyer.service.swift
//  MrArthur
//
//  Created by Reille Sebastien on 13/01/2023.
//

import Foundation
import AppsFlyerLib
import Purchasely

enum EAppsFlyerEventKey: String {
    case PAYWALL = "PAYWALL"
    case SIGN_UP = "SIGN_UP"
    case TRACKING_ALLOWED = "TRACKING_ALLOWED"
    case TRACKING_DENIED = "TRACKING_DENIED"
    case TRACKING_RESTRICTED = "TRACKING_RESTRICTED"
    case TRACKING_NOT_DETERMINED = "TRACKING_NOT_DETERMINED"
}

class AppsFlyerService {
    static func initialize() -> Void {
        AppsFlyerLib.shared().waitForATTUserAuthorization(timeoutInterval: 60)
        AppsFlyerLib.shared().appsFlyerDevKey = !isProduction ? "fuSJHCxa8zYGUxbn4VZ2Cb" : "fuSJHCxa8zYGUxbn4VZ2Cb"
        AppsFlyerLib.shared().appleAppID = !isProduction ? "1111902343" : "6443722754"
        AppsFlyerLib.shared().isDebug = isSebastienEnv
        Purchasely.setAttribute(.appsflyerId, value: AppsFlyerLib.shared().getAppsFlyerUID())
    }
    
    static func start() -> Void {
        AppsFlyerLib.shared().start(completionHandler: { (dictionary, error) in
            if (error != nil){
                print(error ?? "")
                return
            } else {
                print(dictionary ?? "")
                return
            }
        })
    }
    
    static func setCUID(cuid: String?) -> Void {
        if let cuid = cuid {
            AppsFlyerLib.shared().customerUserID = cuid
        }
    }
    
    static func logEvent(key: EAppsFlyerEventKey, withValues: [String: Any] = [:]) -> Void {
//        dump("APPSFLYER LOG EVENT \(key.rawValue)")
        AppsFlyerLib.shared().logEvent(
            key.rawValue,
            withValues: withValues
        )
    }
}
