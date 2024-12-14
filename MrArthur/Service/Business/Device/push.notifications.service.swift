//
//  push.notifications.service.swift
//  MrArthur
//
//  Created by Reille Sebastien on 18/08/2022.
//

import Foundation
import SwiftUI
import os

class PushNotificationsService {
    static func setPermission(completion: ((Bool)->())? = nil) {
        UNUserNotificationCenter.current().requestAuthorization(
                options: [.alert, .sound, .badge]
        ) { (allowed, error) in
            if allowed {
                os_log(.debug, "Push notification Allowed from user")
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                    UNUserNotificationCenter.current().getNotificationSettings { settings in
                        print("Notification settings: \(settings)")
                    }
                }
                completion?(true)
            } else {
                os_log(.debug, "Push notification Refused or Error")
                completion?(false)
            }
        }
    }
    
    static func hasNotAlreadyBeenRequestedForAuthorization() async -> Bool {
        let notificationSettings: UNNotificationSettings = await UNUserNotificationCenter
                .current().notificationSettings()
        return notificationSettings.authorizationStatus == UNAuthorizationStatus.notDetermined
    }

    static func hasAlreadyBeenRequestedForAuthorization() async -> Bool {
        let notificationSettings: UNNotificationSettings = await UNUserNotificationCenter
                .current().notificationSettings()
        return notificationSettings.authorizationStatus != UNAuthorizationStatus.notDetermined
    }

    static func isAuthorized(completion: @escaping(Bool) -> ()) -> Void {
//        let notificationSettings: UNNotificationSettings = await UNUserNotificationCenter
//                .current().notificationSettings()
        UNUserNotificationCenter.current().getNotificationSettings() { settings in
            completion(settings.authorizationStatus == UNAuthorizationStatus.authorized)
//            if let set = settings {
//                completion(set.authorizationStatus == UNAuthorizationStatus.authorized)
//            } else {
//                completion(false)
//            }
        }
//        return notificationSettings.authorizationStatus == UNAuthorizationStatus.authorized
    }
}
