//
//  extension.educational.service.swift
//  MrArthur
//
//  Created by Reille Sebastien on 03/10/2022.
//

import Foundation
import SwiftUI

let serialQueueEducationalSTSecondSpentLocalDevice = DispatchQueue(
    label: "mrarthur.educational.local.second.spent.serial.queue"
)

class ExtensionEducationalService {
    static func getEducationalSTSecondPerDayCommitment() -> Int {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.EDUCATIONAL_ST_SECOND_PER_DAY_COMMITMENT,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var educationalSTSecondPerDayCommitment: Int = 0
        return educationalSTSecondPerDayCommitment
    }
    
    static func setEducationalSTSecondPerDayCommitment(second: Int) -> Void {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.EDUCATIONAL_ST_SECOND_PER_DAY_COMMITMENT,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var educationalSTSecondPerDayCommitment: Int = 0
        educationalSTSecondPerDayCommitment = second
        // Set the quarters of educational time
        ExtensionEducationalService.setQuarters()
    }
    
    static func getEducationalSTSecondSpentDayLocalDeviceDouble() -> Double {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.EDUCATIONAL_ST_SECOND_SPENT_DAY_LOCAL_DEVICE_DOUBLE,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var educationalSTSecondSpentDayLocalDeviceDouble: Double = 0
        return educationalSTSecondSpentDayLocalDeviceDouble
    }
    
    static func setEducationalSTSecondSpentDayLocalDeviceDouble(second: Double) -> Void {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.EDUCATIONAL_ST_SECOND_SPENT_DAY_LOCAL_DEVICE_DOUBLE,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var educationalSTSecondSpentDayLocalDeviceDouble: Double = 0
        educationalSTSecondSpentDayLocalDeviceDouble = second
    }
    
    static func getEducationalSTSecondSpentDayLocalDevice() -> Int {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.EDUCATIONAL_ST_SECOND_SPENT_DAY_LOCAL_DEVICE,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var educationalSTSecondSpentDayLocalDevice: Int = 0
        return educationalSTSecondSpentDayLocalDevice
    }
    
    static func setEducationalSTSecondSpentDayLocalDevice(second: Int) -> Void {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.EDUCATIONAL_ST_SECOND_SPENT_DAY_LOCAL_DEVICE,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var educationalSTSecondSpentDayLocalDevice: Int = 0
        educationalSTSecondSpentDayLocalDevice = second
    }
    
    static func getEducationalSTSecondSpentDayMultiDevice() -> Int {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.EDUCATIONAL_ST_SECOND_SPENT_DAY_MULTI_DEVICE,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var educationalSTSecondSpentDayMultiDevice: Int = 0
        return educationalSTSecondSpentDayMultiDevice
    }
    
    static func setEducationalSTSecondSpentDayMultiDevice(second: Int) -> Void {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.EDUCATIONAL_ST_SECOND_SPENT_DAY_MULTI_DEVICE,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var educationalSTSecondSpentDayMultiDevice: Int = 0
        educationalSTSecondSpentDayMultiDevice = second
    }
    
    static func getEducationalSTSecondQuarter1() -> Int {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.EDUCATIONAL_ST_SECOND_QUARTER_1,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var educationalSTSecondQuarter1: Int = 0
        return educationalSTSecondQuarter1
    }
    
    static func setEducationalSTSecondQuarter1(second: Int) -> Void {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.EDUCATIONAL_ST_SECOND_QUARTER_1,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var educationalSTSecondQuarter1: Int = 0
        educationalSTSecondQuarter1 = second
    }
    
    static func getEducationalSTSecondQuarter2() -> Int {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.EDUCATIONAL_ST_SECOND_QUARTER_2,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var educationalSTSecondQuarter2: Int = 0
        return educationalSTSecondQuarter2
    }
    
    static func setEducationalSTSecondQuarter2(second: Int) -> Void {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.EDUCATIONAL_ST_SECOND_QUARTER_2,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var educationalSTSecondQuarter1: Int = 0
        educationalSTSecondQuarter1 = second
    }
    
    static func getEducationalSTSecondQuarter3() -> Int {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.EDUCATIONAL_ST_SECOND_QUARTER_3,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var educationalSTSecondQuarter3: Int = 0
        return educationalSTSecondQuarter3
    }
    
    static func setEducationalSTSecondQuarter3(second: Int) -> Void {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.EDUCATIONAL_ST_SECOND_QUARTER_3,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var educationalSTSecondQuarter3: Int = 0
        educationalSTSecondQuarter3 = second
    }
    
    static func getEducationalSTSecondQuarter4() -> Int {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.EDUCATIONAL_ST_SECOND_QUARTER_4,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var educationalSTSecondQuarter4: Int = 0
        return educationalSTSecondQuarter4
    }
    
    static func setEducationalSTSecondQuarter4(second: Int) -> Void {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.EDUCATIONAL_ST_SECOND_QUARTER_4,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var educationalSTSecondQuarter4: Int = 0
        educationalSTSecondQuarter4 = second
    }
    
    static func getEducationalSTQuarterOnGoing() -> Int {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.EDUCATIONAL_ST_QUARTER_ON_GOING,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var educationalSTQuarterOnGoing: Int = 0
        return educationalSTQuarterOnGoing
    }
    
    static func setEducationalSTQuarterOnGoing(number: Int) -> Void {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.EDUCATIONAL_ST_QUARTER_ON_GOING,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var educationalSTQuarterOnGoing: Int = 0
        educationalSTQuarterOnGoing = number
    }
    
    static func setQuarters() -> Void {
        let totalEducationalTime: Int = ExtensionEducationalService.getEducationalSTSecondPerDayCommitment()
        let quarters: QuartersFromSecondModel = ExtensionScreenTimeHelperService.getQuartersFromSecond(second: totalEducationalTime)
        ExtensionEducationalService.setEducationalSTSecondQuarter1(second: quarters.quarter1)
        ExtensionEducationalService.setEducationalSTSecondQuarter2(second: quarters.quarter2)
        ExtensionEducationalService.setEducationalSTSecondQuarter3(second: quarters.quarter3)
        ExtensionEducationalService.setEducationalSTSecondQuarter4(second: quarters.quarter4)
    }
    
    static func getAllQuarters() -> QuartersFromSecondModel {
        QuartersFromSecondModel(
            quarter1: ExtensionEducationalService.getEducationalSTSecondQuarter1(),
            quarter2: ExtensionEducationalService.getEducationalSTSecondQuarter2(),
            quarter3: ExtensionEducationalService.getEducationalSTSecondQuarter3(),
            quarter4: ExtensionEducationalService.getEducationalSTSecondQuarter4()
        )
    }
    
    static func increaseEducationalSTSecondSpentDayLocalDevice() -> Void {
        serialQueueEducationalSTSecondSpentLocalDevice.async {
            let localSecondSpent: Int = ExtensionEducationalService.getEducationalSTSecondSpentDayLocalDevice()
            let localSecondSpentDouble: Double = ExtensionEducationalService.getEducationalSTSecondSpentDayLocalDeviceDouble()
            let maj: Double = localSecondSpentDouble + Double(ExtensionDeviceActivityService.constant.SECOND_EDUCATIONAL_EVENT_TIME) + 1.4
            ExtensionEducationalService.setEducationalSTSecondSpentDayLocalDeviceDouble(second: maj)

            let secondSpent: Int = Int(ceil(maj))
            if (secondSpent > localSecondSpent) {
                ExtensionEducationalService.setEducationalSTSecondSpentDayLocalDevice(second: secondSpent)
                // Api Call
                ExtensionApiCallService.postAttendeeTimeSpent(secondSpent: secondSpent, screenTimeType: .EDUCATIONAL)
            }
        }
    }
    
    static func increaseEducationalSTSecondSpentDayMultiDevice(totalMultiDeviceSecondSpent: Int) -> Void {
        let multiDeviceSecondSpent: Int = ExtensionEducationalService.getEducationalSTSecondSpentDayMultiDevice()
        // Check if totalMultiDeviceSecondSpent is > than app storage value (latence request)
        if (multiDeviceSecondSpent < totalMultiDeviceSecondSpent) {
            ExtensionEducationalService.setEducationalSTSecondSpentDayMultiDevice(second: totalMultiDeviceSecondSpent)
        }
    }
}
