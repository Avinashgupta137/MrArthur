//
//  extension.device.activity.correction.service.swift
//  MrArthur
//
//  Created by Reille Sebastien on 18/11/2022.
//

import SwiftUI
import Foundation
import FamilyControls
import DeviceActivity
import ManagedSettings



let entertainmentCorrectionDeviceActivityList: Array<DeviceActivityName> = [
    DeviceActivityName.entertainmentCorrection1ActivityName,
//    DeviceActivityName.entertainmentCorrection2ActivityName,
//    DeviceActivityName.entertainmentCorrection3ActivityName,
//    DeviceActivityName.entertainmentCorrection4ActivityName,
//    DeviceActivityName.entertainmentCorrection5ActivityName,
//    DeviceActivityName.entertainmentCorrection6ActivityName,
//    DeviceActivityName.entertainmentCorrection7ActivityName,
//    DeviceActivityName.entertainmentCorrection8ActivityName,
//    DeviceActivityName.entertainmentCorrection9ActivityName,
//    DeviceActivityName.entertainmentCorrection10ActivityName
]

class ExtensionDeviceActivityCorrectionService {
    static func scheduleEntertainmentCorrection() {
//        ExtensionApiCallService.sendLog(log: "scheduleEntertainmentCorrection")

        let totalEntertainmentTimeAllowed: Int = ExtensionEntertainmentService.getEntertainmentSTSecondPerDayAllowed()
//        let entertainementQuarterOnGoingModel: QuartersOnGoingModel = ExtensionEntertainmentService.getQuarterOnGoing()
        
        let categoryTokenList: Set<ActivityCategoryToken> = ExtensionFamilyActivitySelectionService
            .getEntertainmentSelection().categoryTokens
        let numberOfSchedule: Int = entertainmentCorrectionDeviceActivityList.count
        let numberOfEvent: Int = correctionEventList.count * numberOfSchedule
        let dividedTimeList: Array<Int> = ExtensionScreenTimeHelperService.divideTotalSecondInIntegerParts(
            totalSecond: totalEntertainmentTimeAllowed,
//            totalSecond: entertainementQuarterOnGoingModel.second,
            listLen: numberOfEvent
        )
        let numberOfEventBySchedule: Int = correctionEventList.count
//        ExtensionApiCallService.sendLog(log: "numberOfEventBySchedule \(numberOfEventBySchedule)")
//        dump(dividedTimeList)
//        dump(totalEntertainmentTimeAllowed)
//        dump(numberOfEvent)
//        dump(numberOfSchedule)
//        dump(numberOfEventBySchedule)
//        dump(dividedTimeList.count)
        
        var lastEventThresholdSecond: Int = 0
        var eventIndex: Int = 0
        
        for i in 0...numberOfSchedule - 1 {
            let activityName: DeviceActivityName = entertainmentCorrectionDeviceActivityList[i]
            var eventList: [DeviceActivityEvent.Name : DeviceActivityEvent] = [:]
            
            
//            print("lastEventTrh \(lastEventThresholdSecond)")
            for a in 0...numberOfEventBySchedule - 1 {
                let isIndexValid: Bool = dividedTimeList.indices.contains(eventIndex)
                if (!isIndexValid) {
                    break
                }
                let eventName: DeviceActivityEvent.Name = correctionEventList[a]
                let time: Int = dividedTimeList[eventIndex] > 0 ? dividedTimeList[eventIndex] : 1
                let thresholdSecond: Int = lastEventThresholdSecond + time
                let (hour, minute, second) = DateService.secondsToHoursMinutesSeconds(thresholdSecond)
//                print("thresholdSecond \(thresholdSecond)")
//                dump(a)
//                dump(thresholdSecond)
                dump("hour \(hour) minute \(minute) second \(second)")
                eventList[eventName] = DeviceActivityEvent(
                    categories: categoryTokenList,
                    threshold: DateComponents(
                        hour: hour,
                        minute: minute,
                        second: second
//                        second: thresholdSecond
                    )
                )
                eventIndex += 1
                lastEventThresholdSecond = thresholdSecond
            }
            dump("eventList \(eventList.count)")
            ExtensionDeviceActivityCorrectionService.scheduleCorrectionEventsFromNow(
                categoryTokenList: categoryTokenList,
                deviceActivityName: activityName,
                eventList: eventList
            )
        }
    }
    
    static func scheduleCorrectionEventsFromNow(
        categoryTokenList: Set<ActivityCategoryToken>,
        deviceActivityName: DeviceActivityName,
        eventList: [DeviceActivityEvent.Name : DeviceActivityEvent]
    ) -> Void {
        let center = DeviceActivityCenter()
        let dateNow: IGetHourMinuteSecondFromNowResponse = DateService.getHourMinuteSecondFromNow()
        let schedule = DeviceActivitySchedule(
            intervalStart: DateComponents(hour: dateNow.hour, minute: dateNow.minute, second: dateNow.second),
            intervalEnd: DateComponents(
                hour: 23, // dateNow.hour,
                minute: 59, // dateNow.minute,
                second: 59 // dateNow.second + ExtensionDeviceActivityService.constant.SECOND_EVENT_TIME
            ),
            repeats: false
        )
        
//        var second: Int {
//            if (deviceActivityName.rawValue == DeviceActivityName.entertainmentActivityName.rawValue) {
//                return constant.SECOND_ENTERTAINMENT_EVENT_TIME
//            } else if (deviceActivityName.rawValue == DeviceActivityName.educationalActivityName.rawValue) {
//                return constant.SECOND_EDUCATIONAL_EVENT_TIME
//            } else if (deviceActivityName.rawValue == DeviceActivityName.allCategoriesActivityName.rawValue) {
//                return constant.SECOND_ALL_CATEGORIES_EVENT_TIME
//            } else {
//                return 1
//            }
//        }
//        ExtensionApiCallService.sendLog(log: "second: \(second) \(deviceActivityName) \(deviceActivityName.rawValue == DeviceActivityName.educationalActivityName.rawValue) \(DeviceActivityName.entertainmentActivityName.rawValue)")

//        let event = DeviceActivityEvent(
//            categories: categoryTokenList,
//            threshold: DateComponents(second: second)
//        )
        do {
//            try center.startMonitoring(deviceActivityName, during: schedule, events: [eventName : event])
            try center.startMonitoring(deviceActivityName, during: schedule, events: eventList)

//            print("Start monitoring for \(deviceActivityName) \(eventName)")
//            ExtensionApiCallService.sendLog(log: "Start monitoring for \(deviceActivityName) \(eventName)")
//            ExtensionApiCallService.sendLog(log: "Start monitoring for \(categoryTokenList)")
//            ExtensionApiCallService.sendLog(log: "Start monitoring for \(dateNow)")
        } catch {
            print ("Start monitoring \(deviceActivityName) error \(error)")
            ExtensionApiCallService.sendLog(log: "Start monitoring \(deviceActivityName) error \(error)")
        }
    }
    
    static func stopMonitoringEntertainmentCorrection() -> Void {
        let center = DeviceActivityCenter()
        center.stopMonitoring(entertainmentCorrectionDeviceActivityList)
        print("Stop monitoring all entertainment correction activities!")
    }
    
    static func entertainmentCorrectionCanBeSchedule() -> Bool {
        ExtensionScreenTimePermissionService.canUseEntertainmentCategory()
        && !ExtensionEntertainmentService.getEntertainmentCategoriesBlocked()
    }
}
