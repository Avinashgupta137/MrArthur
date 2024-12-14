//
//  screen.timeschedule.service.swift
//  MrArthur
//
//  Created by IPS-157 on 13/09/22.
//

//import SwiftUI
//import Foundation
//import FamilyControls
//import DeviceActivity
//import ManagedSettings
//
//class ScreenTimeSchedule: ObservableObject {
//    @AppStorage(
//        ExtensionSharedAppGroupService.keys.ENTERTAINMENT_FAMILY_ACTIVITY_SELECTION,
//        store: ExtensionSharedAppGroupService.sharedDefault
//    ) var entertainmentFamilyActivitySelection = FamilyActivitySelection()
//    
//    let eventime : Int  = 10
//
//    static let shared = ScreenTimeSchedule()
//
//    let storeManagingsetting = ManagedSettingsStore()
//    
//
//    private init() {}
//
//    var entertainmentTimeSelection = FamilyActivitySelection() {
//        willSet {
//            print ("App Details: -  \(newValue)")
//            let applications = newValue.applicationTokens
//            let categories = newValue.categoryTokens
//            storeManagingsetting.shield.applications = applications.isEmpty ? nil : applications
//            storeManagingsetting.shield.applicationCategories = nil // ShieldSettings.ActivityCategoryPolicy.specific(categories, except: Set())
//            storeManagingsetting.shield.webDomainCategories = nil // ShieldSettings.ActivityCategoryPolicy.specific(categories, except: Set())
//
//        }
//    }
//
//    func setSchedule() {
//        let dateNow: IGetHourMinuteSecondFromNowResponse = DateService.getHourMinuteSecondFromNow()
////        ExtensionDeviceActivityService.scheduleEntertainment(
////                hour: dateNow.hour,
////                minute: dateNow.minute,
////                categoryTokens: entertainmentFamilyActivitySelection.categoryTokens
////        )
//        ExtensionDeviceActivityService.scheduleEntertainmentActivity()
//    }
//
////    func setSchedule() {
////        let schedule = DeviceActivitySchedule(
////                intervalStart: DateComponents(hour: 0, minute: 0),
////                intervalEnd: DateComponents(hour: 23, minute: 59),
////                repeats: true
//////                warningTime: nil
////        )
////
////        let event = DeviceActivityEvent(
//////            applications: entertainmentTimeSelection.applicationTokens,
////            categories: entertainmentTimeSelection.categoryTokens,
////            threshold: DateComponents(minute: 1)// DateComponents(second: eventime)
////        )
////
////        let center = DeviceActivityCenter()
////        do {
////            try center.startMonitoring(
////                .dailyDeviceSchedule,
////                during: schedule,
////                events: [.tenseconds : event]
////            )
////            print("Start monitoring")
////        } catch {
////            print ("Could not start monitoring \(error)")
////        }
////    }
//
//    func printTestData(eventwillCall :String){
//        print(" Test Data Call in Device Activity Schedule")
//    }
//    
//    static func stopMonitoring() {
//        let center = DeviceActivityCenter()
////        center.stopMonitoring([.dailyDeviceSchedule])
//        center.stopMonitoring()
//        print("Stop monitoring")
//        ExtensionSharedAppGroupService.sharedDefault?.set(
//            "Stop monitoring \(ExtensionDeviceActivityService.currentTime())",
//            forKey: ExtensionSharedAppGroupService.keys.TEST_KEY
//        )
////        do {
////
////        } catch {
////            print ("Could not stop monitoring \(error)")
////        }
//    }
//
//}
//
//extension DeviceActivityName {
//    static let dailyDeviceSchedule = Self("daily")
//}
//
//extension DeviceActivityEvent.Name{
//    static let tenseconds = Self("threshold.seconds.ten")
//}
