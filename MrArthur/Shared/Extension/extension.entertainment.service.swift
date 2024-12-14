//
//  extension.entertainment.service.swift
//  MrArthur
//
//  Created by Reille Sebastien on 03/10/2022.
//

import SwiftUI
import Foundation

let serialQueueEntertainementSTSecondSpentLocalDevice = DispatchQueue(
    label: "mrarthur.entertainment.local.second.spent.serial.queue"
)

class ExtensionEntertainmentService {
    static func getEntertainmentCategoriesBlocked() -> Bool {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.ENTERTAINMENT_CATEGORIES_BLOCKED,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var entertainmentCategoriesBlocked: Bool = false
        return entertainmentCategoriesBlocked
    }
    
    static func setEntertainmentCategoriesBlocked(value: Bool) -> Void {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.ENTERTAINMENT_CATEGORIES_BLOCKED,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var entertainmentCategoriesBlocked: Bool = false
        entertainmentCategoriesBlocked = value
    }
    
    static func getEntertainmentSTSecondPerDayAllowed() -> Int {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.ENTERTAINMENT_ST_SECOND_PER_DAY_ALLOWED,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var entertainmentSTSecondPerDayAllowed: Int = 0
        return entertainmentSTSecondPerDayAllowed
    }
    
    static func setEntertainmentSTSecondPerDayAllowed(second: Int) -> Void {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.ENTERTAINMENT_ST_SECOND_PER_DAY_ALLOWED,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var entertainmentSTSecondPerDayAllowed: Int = 0
        entertainmentSTSecondPerDayAllowed = second
        // Set the entertainment quarters
        ExtensionEntertainmentService.setQuarters()
        // set the morning advance
        ExtensionEntertainmentService.setMorningAdvance()
    }
    
    static func getEntertainmentSTSecondSpentDayLocalDeviceDouble() -> Double {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.ENTERTAINMENT_ST_SECOND_SPENT_DAY_LOCAL_DEVICE_DOUBLE,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var entertainmentSTSecondSpentDayLocalDeviceDouble: Double = 0
        return entertainmentSTSecondSpentDayLocalDeviceDouble
    }
    
    static func setEntertainmentSTSecondSpentDayLocalDeviceDouble(second: Double) -> Void {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.ENTERTAINMENT_ST_SECOND_SPENT_DAY_LOCAL_DEVICE_DOUBLE,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var entertainmentSTSecondSpentDayLocalDeviceDouble: Double = 0
        entertainmentSTSecondSpentDayLocalDeviceDouble = second
    }
    
    static func getEntertainmentSTSecondSpentDayLocalDevice() -> Int {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.ENTERTAINMENT_ST_SECOND_SPENT_DAY_LOCAL_DEVICE,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var entertainmentSTSecondSpentDayLocalDevice: Int = 0
        return entertainmentSTSecondSpentDayLocalDevice
    }
    
    static func setEntertainmentSTSecondSpentDayLocalDevice(second: Int) -> Void {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.ENTERTAINMENT_ST_SECOND_SPENT_DAY_LOCAL_DEVICE,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var entertainmentSTSecondSpentDayLocalDevice: Int = 0
        entertainmentSTSecondSpentDayLocalDevice = second
    }
    
    static func getEntertainmentSTSecondSpentDayMultiDevice() -> Int {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.ENTERTAINMENT_ST_SECOND_SPENT_DAY_MULTI_DEVICE,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var entertainmentSTSecondSpentDayMultiDevice: Int = 0
        return entertainmentSTSecondSpentDayMultiDevice
    }
    
    static func setEntertainmentSTSecondSpentDayMultiDevice(second: Int) -> Void {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.ENTERTAINMENT_ST_SECOND_SPENT_DAY_MULTI_DEVICE,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var entertainmentSTSecondSpentDayMultiDevice: Int = 0
        entertainmentSTSecondSpentDayMultiDevice = second
    }
    
    static func getEntertainmentSTSecondQuarter1() -> Int {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.ENTERTAINMENT_ST_SECOND_QUARTER_1,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var entertainmentSTSecondQuarter1: Int = 0
        return entertainmentSTSecondQuarter1
    }
    
    static func setEntertainmentSTSecondQuarter1(second: Int) -> Void {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.ENTERTAINMENT_ST_SECOND_QUARTER_1,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var entertainmentSTSecondQuarter1: Int = 0
        entertainmentSTSecondQuarter1 = second
    }
    
    static func getEntertainmentSTSecondQuarter2() -> Int {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.ENTERTAINMENT_ST_SECOND_QUARTER_2,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var entertainmentSTSecondQuarter2: Int = 0
        return entertainmentSTSecondQuarter2
    }
    
    static func setEntertainmentSTSecondQuarter2(second: Int) -> Void {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.ENTERTAINMENT_ST_SECOND_QUARTER_2,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var entertainmentSTSecondQuarter2: Int = 0
        entertainmentSTSecondQuarter2 = second
    }
    
    static func getEntertainmentSTSecondQuarter3() -> Int {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.ENTERTAINMENT_ST_SECOND_QUARTER_3,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var entertainmentSTSecondQuarter3: Int = 0
        return entertainmentSTSecondQuarter3
    }
    
    static func setEntertainmentSTSecondQuarter3(second: Int) -> Void {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.ENTERTAINMENT_ST_SECOND_QUARTER_3,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var entertainmentSTSecondQuarter3: Int = 0
        entertainmentSTSecondQuarter3 = second
    }
    
    static func getEntertainmentSTSecondQuarter4() -> Int {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.ENTERTAINMENT_ST_SECOND_QUARTER_4,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var entertainmentSTSecondQuarter4: Int = 0
        return entertainmentSTSecondQuarter4
    }
    
    static func setEntertainmentSTSecondQuarter4(second: Int) -> Void {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.ENTERTAINMENT_ST_SECOND_QUARTER_4,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var entertainmentSTSecondQuarter4: Int = 0
        entertainmentSTSecondQuarter4 = second
    }
    
    static func getEntertainmentSTSecondMorningAdvance() -> Int {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.ENTERTAINMENT_ST_SECOND_MORNING_ADVANCE,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var entertainmentSTSecondMorningAdvance: Int = 0
        return entertainmentSTSecondMorningAdvance
    }
    
    static func setEntertainmentSTSecondMorningAdvance(second: Int) -> Void {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.ENTERTAINMENT_ST_SECOND_MORNING_ADVANCE,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var entertainmentSTSecondMorningAdvance: Int = 0
        entertainmentSTSecondMorningAdvance = second
    }
    
    static func getEntertainmentSTSecondAdvantageOverYesterdayConsumption() -> Int {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.ENTERTAINMENT_ST_SECOND_ADVANTAGE_OVER_YESTERDAY_CONSUMPTION,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var entertainmentSTSecondAdvantageOverYesterdayConsumption: Int = 0
        return entertainmentSTSecondAdvantageOverYesterdayConsumption
    }
    
    static func setEntertainmentSTSecondAdvantageOverYesterdayConsumption(second: Int) -> Void {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.ENTERTAINMENT_ST_SECOND_ADVANTAGE_OVER_YESTERDAY_CONSUMPTION,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var entertainmentSTSecondAdvantageOverYesterdayConsumption: Int = 0
        entertainmentSTSecondAdvantageOverYesterdayConsumption = second
    }
    
    static func getEntertainmentSTSecondTimeLeft() -> Int {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.ENTERTAINMENT_ST_SECOND_TIME_LEFT,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var entertainmentSTSecondTimeLeft: Int = 0
        return entertainmentSTSecondTimeLeft
    }
    
    static func setEntertainmentSTSecondTimeLeft(second: Int) -> Void {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.ENTERTAINMENT_ST_SECOND_TIME_LEFT,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var entertainmentSTSecondTimeLeft: Int = 0
        entertainmentSTSecondTimeLeft = second
    }
    
    static func setQuarters() -> Void {
        let totalEntertainmentTime: Int = ExtensionEntertainmentService.getEntertainmentSTSecondPerDayAllowed()
        let quarters: QuartersFromSecondModel = ExtensionScreenTimeHelperService.getQuartersFromSecond(second: totalEntertainmentTime)
        ExtensionEntertainmentService.setEntertainmentSTSecondQuarter1(second: quarters.quarter1)
        ExtensionEntertainmentService.setEntertainmentSTSecondQuarter2(second: quarters.quarter2)
        ExtensionEntertainmentService.setEntertainmentSTSecondQuarter3(second: quarters.quarter3)
        ExtensionEntertainmentService.setEntertainmentSTSecondQuarter4(second: quarters.quarter4)
    }
    
    static func setMorningAdvance() -> Void {
        let totalEntertainmentTime: Int = ExtensionEntertainmentService.getEntertainmentSTSecondPerDayAllowed()
        let morningAdvance: Int = ExtensionScreenTimeHelperService.get15PercentRoundedTo5MinutesFromSecond(second: totalEntertainmentTime)
//        ExtensionApiCallService.sendLog(log: "timeAllowed/morningAdvance: \(totalEntertainmentTime)/\(morningAdvance)")
        ExtensionEntertainmentService.setEntertainmentSTSecondMorningAdvance(second: morningAdvance)
    }
    
    static func increaseEntertainmentSTSecondSpentDayLocalDevice() -> Void {
        serialQueueEntertainementSTSecondSpentLocalDevice.async {
            let localSecondSpent: Int = ExtensionEntertainmentService.getEntertainmentSTSecondSpentDayLocalDevice()
            let localSecondSpentDouble: Double = ExtensionEntertainmentService.getEntertainmentSTSecondSpentDayLocalDeviceDouble()
            let maj: Double = localSecondSpentDouble + Double(ExtensionDeviceActivityService.constant.SECOND_ENTERTAINMENT_EVENT_TIME) + 1.4
            ExtensionEntertainmentService.setEntertainmentSTSecondSpentDayLocalDeviceDouble(second: maj)
            
            let secondSpent: Int = Int(ceil(maj))
            if (secondSpent > localSecondSpent) {
                ExtensionEntertainmentService.setEntertainmentSTSecondSpentDayLocalDevice(second: secondSpent)
                // Api Call
                ExtensionApiCallService.postAttendeeTimeSpent(secondSpent: secondSpent, screenTimeType: .ENTERTAINMENT)
            }
        }
    }
    
//    static func setCorrectionEntertainmentSTSecondSpentDayLocalDevice(second: Int?) -> Void {
//        if let sec = second {
//            ExtensionApiCallService.sendLog(log: "SECOND \(sec)")
//            let localSecondSpent: Int = ExtensionEntertainmentService.getEntertainmentSTSecondSpentDayLocalDevice()
//            if (sec > localSecondSpent) {
//                serialQueueEntertainementSTSecondSpentLocalDevice.async {
//                    let secondSpent: Int = sec
//                    ExtensionEntertainmentService.setEntertainmentSTSecondSpentDayLocalDevice(second: secondSpent)
//                    // Api Call
//                    ExtensionApiCallService.postAttendeeTimeSpent(secondSpent: secondSpent, screenTimeType: .ENTERTAINMENT)
//                }
//            }
//        }
//    }
    
    static func increaseEntertainmentSTSecondSpentDayMultiDevice(totalMultiDeviceSecondSpent: Int) -> Void {
        let multiDeviceSecondSpent: Int = ExtensionEntertainmentService.getEntertainmentSTSecondSpentDayMultiDevice()
        // Check if totalMultiDeviceSecondSpent is > than app storage value (latence request)
//        ExtensionApiCallService.sendLog(log: "set multi Device ent \(totalMultiDeviceSecondSpent)")
        if (multiDeviceSecondSpent < totalMultiDeviceSecondSpent) {
//            ExtensionApiCallService.sendLog(log: "good")
            ExtensionEntertainmentService.setEntertainmentSTSecondSpentDayMultiDevice(second: totalMultiDeviceSecondSpent)
        }
    }
    
    static func getQuarterOnGoing() -> QuartersOnGoingModel {
        let timeSpent: Int = ExtensionScreenTimePermissionService.getEntertainmentTimeSecondSpentToday()
        let quarters: QuartersFromSecondModel = ExtensionEntertainmentService.getAllQuarters()
        var quarterOnGoingModel: QuartersOnGoingModel = QuartersOnGoingModel(
            second: 0,
            number: 0,
            previousQuarterAmountSecond: 0
        )
        let quarter2Amout: Int = quarters.quarter1 + quarters.quarter2
        let quarter3Amount: Int = quarter2Amout + quarters.quarter3
        let quarter4Amount: Int = quarter3Amount + quarters.quarter4
        
        if (timeSpent < quarters.quarter1) {
            quarterOnGoingModel.second = quarters.quarter1
            quarterOnGoingModel.number = 1
            quarterOnGoingModel.previousQuarterAmountSecond = 0
        } else if (timeSpent >= quarters.quarter1 && timeSpent < quarter2Amout) {
            quarterOnGoingModel.second = quarters.quarter2
            quarterOnGoingModel.number = 2
            quarterOnGoingModel.previousQuarterAmountSecond = quarters.quarter1
        } else if (timeSpent >= quarter2Amout && timeSpent < quarter3Amount) {
            quarterOnGoingModel.second = quarters.quarter3
            quarterOnGoingModel.number = 3
            quarterOnGoingModel.previousQuarterAmountSecond = quarter2Amout
        } else if (timeSpent >= quarter3Amount && timeSpent < quarter4Amount) {
            quarterOnGoingModel.second = quarters.quarter4
            quarterOnGoingModel.number = 4
            quarterOnGoingModel.previousQuarterAmountSecond = quarter3Amount
        }
        
        return quarterOnGoingModel
    }
    
    static func getAllQuarters() -> QuartersFromSecondModel {
        QuartersFromSecondModel(
            quarter1: ExtensionEntertainmentService.getEntertainmentSTSecondQuarter1(),
            quarter2: ExtensionEntertainmentService.getEntertainmentSTSecondQuarter2(),
            quarter3: ExtensionEntertainmentService.getEntertainmentSTSecondQuarter3(),
            quarter4: ExtensionEntertainmentService.getEntertainmentSTSecondQuarter4()
        )
    }
}
