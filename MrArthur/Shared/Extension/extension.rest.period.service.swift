//
//  extension.rest.period.service.swift
//  MrArthur
//
//  Created by Reille Sebastien on 01/10/2022.
//

import Foundation
import SwiftUI

class ExtensionRestPeriodService {
    static func getRestPeriodStartTimeHour() -> Int {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.REST_PERIOD_ST_START_TIME_HOUR,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var restPeriodStartTimeHour: Int = 0
        return restPeriodStartTimeHour
    }
    
    static func setRestPeriodStartTimeHour(hour: Int) -> Void {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.REST_PERIOD_ST_START_TIME_HOUR,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var restPeriodStartTimeHour: Int = 0
        restPeriodStartTimeHour = hour
    }
    
    static func getRestPeriodEndTimeHour() -> Int {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.REST_PERIOD_ST_END_TIME_HOUR,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var restPeriodEndTimeHour: Int = 0
        return restPeriodEndTimeHour
    }
    
    static func setRestPeriodEndTimeHour(hour: Int) -> Void {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.REST_PERIOD_ST_END_TIME_HOUR,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var restPeriodEndTimeHour: Int = 0
        restPeriodEndTimeHour = hour
    }
    
    static func getIsRestPeriod() -> Bool {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.IS_REST_PERIOD_ST_BOOLEAN,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var isRestPeriod: Bool = false
        return isRestPeriod
    }
    
    static func setIsRestPeriod(value: Bool) -> Void {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.IS_REST_PERIOD_ST_BOOLEAN,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var isRestPeriod: Bool = false
        isRestPeriod = value
    }
    
    static func getHasRestPeriod() -> Bool {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.HAS_REST_PERIOD_ST_BOOLEAN,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var hasRestPeriod: Bool = false
        return hasRestPeriod
    }
    
    static func setHasRestPeriod(value: Bool) -> Void {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.HAS_REST_PERIOD_ST_BOOLEAN,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var hasRestPeriod = false
        hasRestPeriod = value
    }
    
    static func getRestPeriodHasAlreadyStartedToday() -> Bool {
        @AppStorage(
                ExtensionSharedAppGroupService.keys.REST_PERIOD_HAS_ALREADY_STARTED_TODAY_ST_BOOLEAN,
                store: ExtensionSharedAppGroupService.sharedDefault
        ) var restPeriodHasAlreadyStartedToday: Bool = false
        return restPeriodHasAlreadyStartedToday
    }

    static func setRestPeriodHasAlreadyStartedToday(value: Bool) -> Void {
        @AppStorage(
                ExtensionSharedAppGroupService.keys.REST_PERIOD_HAS_ALREADY_STARTED_TODAY_ST_BOOLEAN,
                store: ExtensionSharedAppGroupService.sharedDefault
        ) var restPeriodHasAlreadyStartedToday = false
        restPeriodHasAlreadyStartedToday = value
    }
    
    static func getMorningStartDayMonth() -> String {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.MORNING_START_DAY_MONTH,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var morningStartDayMonth: String = ""
        return morningStartDayMonth
    }
    
    static func setMorningStartDayMonth(dayMonth: String) -> Void {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.MORNING_START_DAY_MONTH,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var morningStartDayMonth: String = ""
        morningStartDayMonth = dayMonth
    }
    
    static func setMorningStartDayMonthFromToday() -> Void {
        ExtensionRestPeriodService.setMorningStartDayMonth(
            dayMonth: ExtensionRestPeriodService.getTodayDayMonthString()
        )
    }
    
    static func morningStartDayMonthIsSameOfToday() -> Bool {
        let morningStartDayMonth: String = ExtensionRestPeriodService.getMorningStartDayMonth()
        return morningStartDayMonth == ExtensionRestPeriodService.getTodayDayMonthString()
    }
    
    static func getTodayDayMonthString() -> String {
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        return "\(day)/\(month)"
    }
    
    static func isInRestPeriod() -> Bool {
        let hasRestPeriod: Bool = ExtensionRestPeriodService.getHasRestPeriod()
        let timeStart: Int = ExtensionRestPeriodService.getRestPeriodStartTimeHour()
        let timeEnd: Int = ExtensionRestPeriodService.getRestPeriodEndTimeHour()
        let time: IGetHourMinuteSecondFromNowResponse = DateService.getHourMinuteSecondFromNow()
        if (hasRestPeriod) {
            return time.hour >= timeStart || time.hour < timeEnd
        } else {
            return false
        }
    }
}
