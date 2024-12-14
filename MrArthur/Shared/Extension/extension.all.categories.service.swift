//
//  extension.all.category.service.swift
//  MrArthur
//
//  Created by Reille Sebastien on 03/10/2022.
//

import Foundation
import SwiftUI

let serialQueueAllCategoriesSTSecondSpentLocalDevice = DispatchQueue(
    label: "mrarthur.all.categories.local.second.spent.serial.queue"
)

class ExtensionAllCategoriesService {
    static func getAllCategoriesSTSecondSpentDayLocalDeviceDouble() -> Double {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.ALL_CATEGORIES_ST_SECOND_SPENT_DAY_LOCAL_DEVICE_DOUBLE,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var allCategoriesSTSecondSpentDayLocalDeviceDouble: Double = 0
        return allCategoriesSTSecondSpentDayLocalDeviceDouble
    }
    
    static func setAllCategoriesSTSecondSpentDayLocalDeviceDouble(second: Double) -> Void {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.ALL_CATEGORIES_ST_SECOND_SPENT_DAY_LOCAL_DEVICE_DOUBLE,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var allCategoriesSTSecondSpentDayLocalDeviceDouble: Double = 0
        allCategoriesSTSecondSpentDayLocalDeviceDouble = second
    }
    
    static func getAllCategoriesSTSecondSpentDayLocalDevice() -> Int {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.ALL_CATEGORIES_ST_SECOND_SPENT_DAY_LOCAL_DEVICE,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var allCategoriesSTSecondSpentDayLocalDevice: Int = 0
        return allCategoriesSTSecondSpentDayLocalDevice
    }
    
    static func setAllCategoriesSTSecondSpentDayLocalDevice(second: Int) -> Void {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.ALL_CATEGORIES_ST_SECOND_SPENT_DAY_LOCAL_DEVICE,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var allCategoriesSTSecondSpentDayLocalDevice: Int = 0
        allCategoriesSTSecondSpentDayLocalDevice = second
    }
    
    static func getAllCategoriesSTSecondSpentDayMultiDevice() -> Int {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.ALL_CATEGORIES_ST_SECOND_SPENT_DAY_MULTI_DEVICE,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var allCategoriesSTSecondSpentDayMultiDevice: Int = 0
        return allCategoriesSTSecondSpentDayMultiDevice
    }
    
    static func setAllCategoriesSTSecondSpentDayMultiDevice(second: Int) -> Void {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.ALL_CATEGORIES_ST_SECOND_SPENT_DAY_MULTI_DEVICE,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var allCategoriesSTSecondSpentDayMultiDevice: Int = 0
        allCategoriesSTSecondSpentDayMultiDevice = second
    }
    
    static func increaseAllCategoriesSTSecondSpentDayLocalDevice() -> Void {
        serialQueueAllCategoriesSTSecondSpentLocalDevice.async {
            let localSecondSpent: Int = ExtensionAllCategoriesService.getAllCategoriesSTSecondSpentDayLocalDevice()
            let localSecondSpentDouble: Double = ExtensionAllCategoriesService.getAllCategoriesSTSecondSpentDayLocalDeviceDouble()
            let maj: Double = localSecondSpentDouble + Double(ExtensionDeviceActivityService.constant.SECOND_ALL_CATEGORIES_EVENT_TIME) + 1.4
            ExtensionAllCategoriesService.setAllCategoriesSTSecondSpentDayLocalDeviceDouble(second: maj)

            let secondSpent: Int = Int(ceil(maj))
            if (secondSpent > localSecondSpent) {
                ExtensionAllCategoriesService.setAllCategoriesSTSecondSpentDayLocalDevice(second: secondSpent)
                // Api Call
                ExtensionApiCallService.postAttendeeTimeSpent(secondSpent: secondSpent, screenTimeType: .ALL_CATEGORIES)
            }
        }
    }
    
    static func increaseAllCategoriesSTSecondSpentDayMultiDevice(totalMultiDeviceSecondSpent: Int) -> Void {
        let multiDeviceSecondSpent: Int = ExtensionAllCategoriesService.getAllCategoriesSTSecondSpentDayMultiDevice()
        // Check if totalMultiDeviceSecondSpent is > than app storage value (latence request)
        if (multiDeviceSecondSpent < totalMultiDeviceSecondSpent) {
            ExtensionAllCategoriesService.setAllCategoriesSTSecondSpentDayMultiDevice(second: totalMultiDeviceSecondSpent)
        }
    }
}
