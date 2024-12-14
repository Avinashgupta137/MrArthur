//
//  AppDelegate.swift
//  MrArthur
//
//  Created by Reille Sebastien on 18/08/2022.
//

import Foundation
import SwiftUI
import Amplitude
import UserNotifications
import Intercom
import FamilyControls
import IQKeyboardManagerSwift
import Purchasely
import Bugsnag
import AppsFlyerLib

let statusBarHeight = UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0

class AppDelegate: NSObject, UIApplicationDelegate {
    
    static var orientationLock = UIInterfaceOrientationMask.portrait
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        print("Current Data: \(DateService.shared.getCurrentDate())")
        // Amplitude tracking initialization
        IQKeyboardManager.shared.enable = true
        AmplitudeService.load()
        AppDelegate.orientationLock = .portrait
        Intercom.unreadConversationCount()
        
        PushNotificationsService.isAuthorized() { success in
            if (success) {
                let _ = PushNotificationsService.setPermission()
            }
        }
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.delegate = self
        
        // APPS FLYER
        AppsFlyerService.initialize()
//        AppsFlyerLib.shared().deepLinkDelegate = self
        // END APPS FLYER
        
        
        Bugsnag.start()
        
        PurshaselyService.preload()
        
//        Bugsnag.notifyError(NSError(domain:"com.example", code:408, userInfo:nil))
        
//        print("quinzepercent")
//        dump(ExtensionScreenTimeHelperService.get15PercentRoundedTo5MinutesFromSecond(second: 3600))
//        ExtensionDeviceActivityCorrectionService.scheduleEntertainmentCorrection()
//        print("activities")
//        ExtensionDeviceActivityService.stopMonitoringAllActivities()
//        ExtensionDeviceAcivitySlotService.stopMonitoringSlot()
//        ExtensionDeviceAcivitySlotService.scheduleSlotActivities()
//        ExtensionDeviceAcivitySlotService.checkStartMorning()
//        dump(ExtensionDeviceActivityService.getActivitiesOnGoing())
        Swift.print("CURRENT SCHEME: \(currentScheme)")
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        let token: String = deviceToken.reduce("") { $0 + String(format: "%02x", $1) }
        DeviceService.setDeviceToken(token: token)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error), error Detail = \(error.localizedDescription)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        print("didReceiveRemoteNotification = \(userInfo)")
        self.onNotificationAction(userInfo: userInfo as? [String:Any])
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .banner ,.sound, .badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("didReceive = \(response)")
        let userInfo = response.notification.request.content.userInfo
        
        self.onNotificationAction(userInfo: userInfo as? [String:Any])
        
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
    }
    
    private func onNotificationAction(userInfo: [String:Any]?) {
        print("onNotificationAction", userInfo ?? [:])
        if let dic = userInfo {
            if let dicData = dic["aps"] as? [String:Any] {
                if let notificationType = dicData["payload"] as? [String:Any]{
                    if let type = notificationType["notificationType"] as? String{
                        print("type of pushnotfication = \(type)")
                        if let eNotificationType = ENotificationType(rawValue: type) {
                            AppState.shared.notificationType = eNotificationType
                        }
                    }
                }
            }
        }
    }
}


extension UIApplication {
    
    var keyWindow: UIWindow? {
        
        return UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first(where: { $0 is UIWindowScene })
            .flatMap({ $0 as? UIWindowScene })?.windows
            .first(where: \.isKeyWindow)
    }
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


struct AppShared {
    static func shareSheet(items: [Any]) {
        DispatchQueue.main.async {
            let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
            if isiPad() {
                activityVC.popoverPresentationController?.sourceView = UIApplication.shared.keyWindow
                activityVC.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: 300, height: 350)
                activityVC.popoverPresentationController?.permittedArrowDirections = [.left]
            }
            UIApplication.shared.keyWindow?.rootViewController?.present(activityVC, animated: true, completion: nil)
        }
    }
    
    static func customShowAlert(title: String = "Mr Arthur", message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        if let viewController = UIApplication.shared.keyWindow?.rootViewController {
            viewController.present(alertController, animated: true, completion: nil)
        }
    }
}
