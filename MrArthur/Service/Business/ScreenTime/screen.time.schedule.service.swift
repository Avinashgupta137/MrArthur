//
//  screen.time.schedule.swift
//  MrArthur
//
//  Created by Reille Sebastien on 31/08/2022.
//

import Foundation
import DeviceActivity
import ManagedSettings

//extension DeviceActivityName {
//    static let dailySchedule = Self("daily")
//}

//extension DeviceActivityEvent.Name {
//    static let entertainment = Self("entertainment")
//    static let educational = Self("educational")
//    static let all = Self("all")
//}

//class ScreenTimeScheduleService {
//
//    static public func setSchedule() {
//        let center = DeviceActivityCenter()
//
//        do {
//            try center.startMonitoring(
//                    .dailySchedule,
//                    during: ScreenTimeScheduleService.computeSchedule(),
//                    events: ScreenTimeScheduleService.computeEvents()
//            )
//            print("Schedule set")
//            dump(AppSelectionObserved.shared.educationalTimeSelection.categoryTokens)
//        } catch {
//            print("Error monitoring schedule: ", error)
//        }
//    }
//
//    static public func computeSchedule() -> DeviceActivitySchedule {
//        // TODO: set interval according to settings selected by observer ("rest time")
//        DeviceActivitySchedule(
//                intervalStart: DateComponents(hour: 0, minute: 0),
//                intervalEnd: DateComponents(hour: 23, minute: 59),
//                repeats: true
//        )
//    }
//
//    static public func computeEvents() -> [DeviceActivityEvent.Name: DeviceActivityEvent] {
//        [
//            .educational: DeviceActivityEvent(
//                    categories: AppSelectionObserved.shared.educationalTimeSelection.categoryTokens,
//                    threshold: DateComponents(minute: 1)
//            ),
//            .entertainment: DeviceActivityEvent(
//                    categories: AppSelectionObserved.shared.entertainmentTimeSelection.categoryTokens,
//                    threshold: DateComponents(minute: 1)
//            ),
////            .all: DeviceActivityEvent(
////                    categories: AppSelectionObserved.shared.allCategoriesTimeSelection.categoryTokens,
////                    threshold: DateComponents(minute: 1)
////            )
//        ]
//    }
//    func startDeviceActivityMonitoring(includeUsageThreshold: Bool = true) {
//        // APP: Monitor a DeviceActivitySchedule
//        let dateComponents = Calendar.current.dateComponents([.hour, .minute, .second],
//                                                             from: Date())
//
//        let schedule = DeviceActivitySchedule(
//            intervalStart: DateComponents(hour: dateComponents.hour,
//                                          minute: dateComponents.minute,
//                                          second: dateComponents.second),
//            intervalEnd: DateComponents(hour: 23, minute: 59),
//            repeats: true
//        )
//
//        let event = DeviceActivityEvent(applications: $ScreenTimeObserved.entertainmentTimeSelection.applicationTokens,
//                                        threshold: DateComponents(second: 10))
//
//        let center = DeviceActivityCenter()
//        do {
//            try center.startMonitoring(.daily,
//                                       during: schedule,
//                                       events: includeUsageThreshold ? [.tenSeconds : event] : [:])
//            print("Monitoring started")
//        } catch {
//            print("Unexpected error: \(error).")
//        }
//    }

//}
