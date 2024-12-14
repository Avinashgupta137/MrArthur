//
//  extension.screen.time.dev.test.scenario.swift
//  MrArthur
//
//  Created by Reille Sebastien on 07/10/2022.
//

import Foundation
import SwiftUI

class ExtensionScreenTimeDevTestScenarioService {
    static func loadBasicScenario() {
        ExtensionDeviceActivityService.stopMonitoringAllActivities()
        ExtensionScreenTimeDevTestScenarioService.setDeviceAndToken()
        // Rest period
        ExtensionRestPeriodService.setHasRestPeriod(value: true)
        ExtensionRestPeriodService.setRestPeriodStartTimeHour(hour: 23)
        ExtensionRestPeriodService.setRestPeriodEndTimeHour(hour: 1)
        // Total screen time
        
        // Entertainment time
        ExtensionEntertainmentService.setEntertainmentSTSecondPerDayAllowed(second: 87)
        // Educational time
        ExtensionEducationalService.setEducationalSTSecondPerDayCommitment(second: 27)
        // Set time spent edu + entertainment to 0
//        ExtensionEntertainmentService.setEntertainmentSTSecondSpentDayMultiDevice(second: 0)
//        ExtensionEntertainmentService.setEntertainmentSTSecondSpentDayLocalDevice(second: 0)
//        ExtensionEducationalService.setEducationalSTSecondSpentDayMultiDevice(second: 0)
//        ExtensionEducationalService.setEducationalSTSecondSpentDayLocalDevice(second: 0)
        // Start morning
        ExtensionApiCallService.sendLog(log: "loadBasicScenario")
        ExtensionDeviceActivityService.scheduleActivityRestPeriod()
//        ExtensionEntertainmentService.increaseEntertainmentSTSecondSpentDayLocalDevice()
    }
    
    static func setDeviceAndToken() {
        let token: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0eXBlIjoiQVRURU5ERUVfVVNFUiIsInJvbGUiOiJBVFRFTkRFRV9VU0VSIiwiaWQiOjMsImlhdCI6MTY2NTU5MTMwNX0.e6YeHe_GF7l-AO-6hVgBqnDbRHOIodCL5H0v77SxgCg"
        let _ = KeychainService.setKeychainValue(key: EKeychainKey.CURRENT_USER_TOKEN, value: token)
        let tokenGroup = ExtensionApiCallService.getCurrentToken()
        print("current token")
        dump(tokenGroup)
        DeviceService.registerDevice() { success in }
    }
}
