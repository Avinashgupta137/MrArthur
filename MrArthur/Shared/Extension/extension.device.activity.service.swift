//
//  device.activity.extensions.share.service.swift
//  MrArthur
//
//  Created by Reille Sebastien on 02/09/2022.
//
import SwiftUI
import Foundation
import FamilyControls
import DeviceActivity
import ManagedSettings

class ExtensionDeviceActivityService {
    
    struct constant {
        static let TEST_TOTAL_SCREEN_TIME = 600
        static let TEST_ENTERTAINMENT_SECOND = 200
        static let SECOND_EVENT_TIME = 1
        static let SECOND_ENTERTAINMENT_EVENT_TIME = 4
        static let SECOND_EDUCATIONAL_EVENT_TIME = 4
        static let SECOND_ALL_CATEGORIES_EVENT_TIME = 20
    }
    
    static func scheduleActivityRestPeriod() -> Void {
        let hasRestPeriod: Bool = ExtensionRestPeriodService.getHasRestPeriod()
        dump(ExtensionRestPeriodService.getRestPeriodEndTimeHour())
        let schedule = DeviceActivitySchedule(
            intervalStart: DateComponents(
                hour: hasRestPeriod ? ExtensionRestPeriodService.getRestPeriodEndTimeHour() : 0,
                minute: 0,
                second: 0
            ),
            intervalEnd: DateComponents(
                hour: hasRestPeriod ? ExtensionRestPeriodService.getRestPeriodStartTimeHour() : 23,
                minute: hasRestPeriod ? 0 : 59,
                second: hasRestPeriod ? 0 : 59
            ),
            repeats: true
        )
        
        let center = DeviceActivityCenter()
        do {
            try center.startMonitoring(DeviceActivityName.restPeriodActivityName, during: schedule)
            print("Start monitoring rest period!")
        } catch {
            print ("Start monitoring rest period error: \(error)")
        }
    }
    
    static func stopMonitoringRestPeriod() -> Void {
        let center = DeviceActivityCenter()
        center.stopMonitoring([DeviceActivityName.restPeriodActivityName])
        print("Stop monitoring rest period!")
    }
    
    static func basicScheduleFromNowToEventTimeSecond(
        categoryTokenList: Set<ActivityCategoryToken>,
        deviceActivityName: DeviceActivityName,
        eventName: DeviceActivityEvent.Name,
        includesAllActivity: Bool = false
    ) -> Void {
        let center = DeviceActivityCenter()
//        center.stopMonitoring([deviceActivityName])
        
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
        
        var second: Int {
            if (deviceActivityName.rawValue == DeviceActivityName.entertainmentActivityName.rawValue) {
                return constant.SECOND_ENTERTAINMENT_EVENT_TIME
            } else if (deviceActivityName.rawValue == DeviceActivityName.educationalActivityName.rawValue) {
                return constant.SECOND_EDUCATIONAL_EVENT_TIME
            } else if (deviceActivityName.rawValue == DeviceActivityName.allCategoriesActivityName.rawValue) {
                return constant.SECOND_ALL_CATEGORIES_EVENT_TIME
            } else {
                return 1
            }
        }
//        ExtensionApiCallService.sendLog(log: "second: \(second) \(deviceActivityName) \(deviceActivityName.rawValue == DeviceActivityName.educationalActivityName.rawValue) \(DeviceActivityName.entertainmentActivityName.rawValue)")

        let event: DeviceActivityEvent
        if (includesAllActivity) {
            event = DeviceActivityEvent(threshold: DateComponents(second: second))
        } else {
            event = DeviceActivityEvent(
                categories: categoryTokenList,
    //            threshold: DateComponents(second: ExtensionDeviceActivityService.constant.SECOND_EVENT_TIME)
                threshold: DateComponents(second: second)
            )
        }
        
//        let thresold = center.events(for: DeviceActivityName.entertainment).popFirst().value.threshold
//        let newDate = DateComponents(second: thresold.second ExtensionDeviceActivityService.constant.SECOND_EVENT_TIME)
        
        do {
//            try center.startMonitoring(deviceActivityName, during: schedule, events: [eventName : event])
            try center.startMonitoring(deviceActivityName, during: schedule, events: [eventName : event])

            print("Start monitoring for \(deviceActivityName) \(eventName)")
//            ExtensionApiCallService.sendLog(log: "Start monitoring for \(deviceActivityName) \(eventName)")
//            ExtensionApiCallService.sendLog(log: "Start monitoring for \(categoryTokenList)")
//            ExtensionApiCallService.sendLog(log: "Start monitoring for \(dateNow)")
        } catch {
            print ("Start monitoring \(deviceActivityName) error \(error)")
            ExtensionApiCallService.sendLog(log: "Start monitoring \(deviceActivityName) error \(error)")
        }
    }
    
    static func scheduleEntertainmentActivity() -> Void {
        ExtensionDeviceActivityService.basicScheduleFromNowToEventTimeSecond(
            categoryTokenList: ExtensionFamilyActivitySelectionService.getEntertainmentSelection().categoryTokens,
            deviceActivityName: DeviceActivityName.entertainmentActivityName,
            eventName: DeviceActivityEvent.Name.entertainmentEventName
        )
    }

    static func stopMonitoringEntertainment() -> Void {
        let center = DeviceActivityCenter()
        center.stopMonitoring([DeviceActivityName.entertainmentActivityName])
        print("Stop monitoring entertainment!")
    }
    
    static func scheduleEducationalActivity() -> Void {
        ExtensionDeviceActivityService.basicScheduleFromNowToEventTimeSecond(
            categoryTokenList: ExtensionFamilyActivitySelectionService.getEducationalSelection().categoryTokens,
            deviceActivityName: DeviceActivityName.educationalActivityName,
            eventName: DeviceActivityEvent.Name.educationalEventName
        )
    }

    static func stopMonitoringEducational() -> Void {
        let center = DeviceActivityCenter()
        center.stopMonitoring([DeviceActivityName.educationalActivityName])
        print("Stop monitoring educational!")
    }
    
    static func scheduleAllCategoriesActivity() -> Void {
        ExtensionDeviceActivityService.basicScheduleFromNowToEventTimeSecond(
            categoryTokenList: ExtensionFamilyActivitySelectionService.getAllCategoriesSelection().categoryTokens,
            deviceActivityName: DeviceActivityName.allCategoriesActivityName,
            eventName: DeviceActivityEvent.Name.allCategoriesEventName,
            includesAllActivity: true
        )
    }

    static func stopMonitoringAllCategories() -> Void {
        let center = DeviceActivityCenter()
        center.stopMonitoring([DeviceActivityName.allCategoriesActivityName])
        print("Stop monitoring all categories!")
    }
    
    static func stopMonitoringAllActivities() -> Void {
        let center = DeviceActivityCenter()
        center.stopMonitoring()
        print("stop all activities")
    }
    
    static func morningStart() -> Void {
        // TODO: Api call Post last time and get multi device (with date timezoned)
        // First of all, compute the advantage of yesterday
        let advantageOfYesterday: Int = ExtensionScreenTimePermissionService
            .getComputedEntertainmentSTSecondAdvantageOverYesterdayConsumption()
        ExtensionEntertainmentService
                .setEntertainmentSTSecondAdvantageOverYesterdayConsumption(second: advantageOfYesterday)
//        ExtensionApiCallService.sendLog(log: "advantageOfYesterday: \(advantageOfYesterday)")
        
        // Set morning advance
        ExtensionEntertainmentService.setMorningAdvance()
//        ExtensionApiCallService.sendLog(log: "advanceTotal: \(ExtensionScreenTimePermissionService.getAdvanceOfToday())")

        // Set educational and entertainment and categories time spent to  0
        ExtensionEntertainmentService.setEntertainmentSTSecondSpentDayLocalDevice(second: 0)
        ExtensionEntertainmentService.setEntertainmentSTSecondSpentDayLocalDeviceDouble(second: 0)
        ExtensionEntertainmentService.setEntertainmentSTSecondSpentDayMultiDevice(second: 0)
        ExtensionEducationalService.setEducationalSTSecondSpentDayLocalDevice(second: 0)
        ExtensionEducationalService.setEducationalSTSecondSpentDayLocalDeviceDouble(second: 0)
        ExtensionEducationalService.setEducationalSTSecondSpentDayMultiDevice(second: 0)
        ExtensionAllCategoriesService.setAllCategoriesSTSecondSpentDayLocalDevice(second: 0)
        ExtensionAllCategoriesService.setAllCategoriesSTSecondSpentDayLocalDeviceDouble(second: 0)
        ExtensionAllCategoriesService.setAllCategoriesSTSecondSpentDayMultiDevice(second: 0)
        
        // Set quarter on going to 0
        ExtensionEducationalService.setEducationalSTQuarterOnGoing(number: 0)
        
        let _ = ExtensionScreenTimePermissionService.getEntertainmentScreenTimeSecondLeftToday()
        
        let dateDescription: DateTimeZoneAndDescriptionModel = ExtensionScreenTimeHelperService
            .getDateTimeZoneWithDescriptionFromNow()
        ExtensionDeviceActivityService.setTodayDateTimeZoned(date: dateDescription.dateTimeZone)
        ExtensionDeviceActivityService.setTodayDateTimeZonedDescription(description: dateDescription.description)

        // Unblock all categories
        ExtensionScreenTimePermissionService.unblockAllCategories()
        
        // Start new activity
        ExtensionDeviceActivityService.scheduleEntertainmentActivity()
        ExtensionDeviceActivityService.scheduleEducationalActivity()
        ExtensionDeviceActivityService.scheduleAllCategoriesActivity()
        
        // Set morning start day month of today
        ExtensionRestPeriodService.setMorningStartDayMonthFromToday()
    }
    
    static func getTodayDateTimeZoned() -> String {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.TODAY_DATE_TIME_ZONED,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var todayDateTimeZoned: String = DateService.getFormatedDateFromNow()
        return todayDateTimeZoned
    }
    
    static func setTodayDateTimeZoned(date: String) -> Void {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.TODAY_DATE_TIME_ZONED,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var todayDateTimeZoned: String = DateService.getFormatedDateFromNow()
        todayDateTimeZoned = date
    }
    
    static func getTodayDateTimeZonedDescription() -> String {
//        let date: Date = Date()
        @AppStorage(
            ExtensionSharedAppGroupService.keys.TODAY_DATE_TIME_ZONED_DESCRIPTION,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var todayDateTimeZonedDescription: String = Date().description(with: .current)
        return todayDateTimeZonedDescription
    }
    
    static func setTodayDateTimeZonedDescription(description: String) -> Void {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.TODAY_DATE_TIME_ZONED_DESCRIPTION,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var todayDateTimeZonedDescription: String = Date().description(with: .current)
        todayDateTimeZonedDescription = description
    }
    
    static func isScreenTimeProcessOnGoing() -> Bool {
        let center = DeviceActivityCenter()
        let activities: [DeviceActivityName] = center.activities
        return activities.contains(.restPeriodActivityName)
    }
    
    static func isScreenTimeEntertainementActivityOnGoing() -> Bool {
        let center = DeviceActivityCenter()
        let activities: [DeviceActivityName] = center.activities
        return activities.contains(.entertainmentActivityName)
    }
    
    static func isScreenTimeEducationalActivityOnGoing() -> Bool {
        let center = DeviceActivityCenter()
        let activities: [DeviceActivityName] = center.activities
        return activities.contains(.educationalActivityName)
    }
    
    static func getActivitiesOnGoing() -> [DeviceActivityName] {
        let center = DeviceActivityCenter()
        let activities: [DeviceActivityName] = center.activities
        return activities
    }

    
    static func getDeviceActivityCenter() -> DeviceActivityCenter {
        DeviceActivityCenter()
    }
    
//    static func computeEventList() -> [DeviceActivityEvent.Name : DeviceActivityEvent] {
//        let num: Int = ExtensionDeviceActivityService.constant.TEST_ENTERTAINMENT_SECOND /
//        ExtensionDeviceActivityService.constant.SECOND_EVENT_TIME
//        var eventList: [DeviceActivityEvent.Name : DeviceActivityEvent] = [:]
//        for i in 1...num {
//            eventList.push
//        }
//    }
    
    static func getEvent(activityName: DeviceActivityName, eventName: DeviceActivityEvent.Name) -> DeviceActivityEvent? {
        let center: DeviceActivityCenter = ExtensionDeviceActivityService.getDeviceActivityCenter()
        let eventList: [DeviceActivityEvent.Name: DeviceActivityEvent] = center.events(for: activityName)
        return eventList[eventName]
    }
    
    static func getSecondFromEvent(activityName: DeviceActivityName, eventName: DeviceActivityEvent.Name) -> Int? {
        let event: DeviceActivityEvent? = ExtensionDeviceActivityService.getEvent(
            activityName: activityName,
            eventName: eventName
        )
        if let ev = event {
//            return second
            return DateService.hoursMinutesSecondToSeconds(dateComponent: ev.threshold)
        } else {
            return nil
        }
    }

    static func currentTime() -> String {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        return "\(hour):\(minutes):\(seconds)"
    }
}
