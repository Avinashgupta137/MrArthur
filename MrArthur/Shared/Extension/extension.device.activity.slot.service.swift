//
//  extension.device.activity.slot.service.swift
//  MrArthur
//
//  Created by Reille Sebastien on 09/12/2022.
//

import SwiftUI
import Foundation
import FamilyControls
import DeviceActivity
import ManagedSettings

let serialQueueCheckStartMorning = DispatchQueue(
    label: "mrarthur.check.start.morning.serial.queue"
)

struct SlotSchedule {
    var activityName: DeviceActivityName
    var intervalStartHour, intervalEndHour, intervalStartMinute, intervalEndMinute: Int
}

struct SlotTime {
    var startSeconds, warningBeforeStartSeconds, warningBeforeEndSeconds, endSeconds: Int
}

enum ESlotIntervalEventType: String {
    case START = "START"
    case END = "END"
    case WARNING_START = "WARNING_START"
    case WARNING_END = "WARNING_END"
}

let factorSeconds: Int = 1800
let (warningHours, warningMinutes, warningSeconds) = DateService.secondsToHoursMinutesSeconds(factorSeconds)

class ExtensionDeviceAcivitySlotService {
    
    static func handleSlotIntervalEvent(
        activityName: DeviceActivityName,
        type: ESlotIntervalEventType
    ) -> Void {
//        ExtensionApiCallService.sendLog(log: "Slot \(activityName) type \(type)")
        
        // Check morning start
        ExtensionDeviceAcivitySlotService.checkStartMorning()
    }
    
    static func checkStartMorning() -> Bool {
        serialQueueCheckStartMorning.async {
            let startMorningDateIsSame: Bool = ExtensionRestPeriodService.morningStartDayMonthIsSameOfToday()
            let isInRestPeriod: Bool = ExtensionRestPeriodService.isInRestPeriod()
//            dump("startMorningDateIsSame: \(startMorningDateIsSame) - isInRestPeriod: \(isInRestPeriod)")
            if (!startMorningDateIsSame && !isInRestPeriod) {
                ExtensionDeviceActivityService.morningStart()
            } else if (isInRestPeriod) {
                ExtensionScreenTimePermissionService.blockAllCategories()
            }
        }
        return true
    }
    
    static func getSlotTime(
        activityName: DeviceActivityName
    ) -> SlotTime {
        let stringReplace: String = activityName.rawValue.replacingOccurrences(of: "slot", with: "")
        let slotNumber: Int? = Int(stringReplace.replacingOccurrences(of: "ActivityName", with: ""))
        
        var slotTime: SlotTime = SlotTime(
            startSeconds: 0,
            warningBeforeStartSeconds: 0,
            warningBeforeEndSeconds: 0,
            endSeconds: 0
        )
        if let slotNumber = slotNumber {
            let isLast: Bool = slotNumber == slotDeviceActivityNameList.count

            slotTime.startSeconds = (factorSeconds * 2 * slotNumber) + ((slotNumber - 1) * (factorSeconds * 2))
            slotTime.warningBeforeStartSeconds = slotTime.startSeconds - factorSeconds
            slotTime.warningBeforeEndSeconds = slotTime.startSeconds + factorSeconds
            slotTime.endSeconds = isLast ? 0 : slotTime.warningBeforeEndSeconds + factorSeconds
        }
        return slotTime
    }
    
    static func scheduleSlotActivities() -> Void {
        let scheduleCount: Int = slotDeviceActivityNameList.count
        dump("scheduleCount \(scheduleCount)")
        for i in 1...scheduleCount {
            let activityName: DeviceActivityName = slotDeviceActivityNameList[i - 1]
            let slotTime: SlotTime = ExtensionDeviceAcivitySlotService.getSlotTime(activityName: activityName)
            
            let (intervalStartHours, intervalStartMinute, intervalStartSecond) = DateService
                .secondsToHoursMinutesSeconds(slotTime.startSeconds)
            let (intervalEndHours, intervalEndMinute, intervalEndSecond) = DateService
                .secondsToHoursMinutesSeconds(slotTime.endSeconds)
            
            dump("start \(intervalStartHours)h\(intervalStartMinute):\(intervalStartSecond) - end \(intervalEndHours)h\(intervalEndMinute):\(intervalEndSecond)")
            
            let slotSchedule: SlotSchedule = SlotSchedule(
                activityName: activityName,
                intervalStartHour: intervalStartHours,
                intervalEndHour: intervalEndHours,
                intervalStartMinute: intervalStartMinute,
                intervalEndMinute: intervalEndMinute
            )
            
            ExtensionDeviceAcivitySlotService.scheduleSlot(slotSchedule: slotSchedule)
        }
    }
    
    static func scheduleSlot(slotSchedule: SlotSchedule) -> Void {
        dump("slotSchedule: \(slotSchedule)")
        let center = DeviceActivityCenter()
        let schedule = DeviceActivitySchedule(
            intervalStart: DateComponents(
                hour: slotSchedule.intervalStartHour,
                minute: slotSchedule.intervalStartMinute
            ),
            intervalEnd: DateComponents(
                hour: slotSchedule.intervalEndHour,
                minute: slotSchedule.intervalEndMinute
            ),
            repeats: true,
            warningTime: DateComponents(
                hour: warningHours,
                minute: warningMinutes,
                second: warningSeconds
            )
        )
        
        do {
            try center.startMonitoring(slotSchedule.activityName, during: schedule)
        } catch {
            ExtensionApiCallService.sendLog(log: "Start monitoring \(slotSchedule.activityName) error \(error)")
        }
    }
    
    static func stopMonitoringSlot() -> Void {
        let center = DeviceActivityCenter()
        center.stopMonitoring(slotDeviceActivityNameList)
        print("Stop monitoring all slot activities!")
    }
}
