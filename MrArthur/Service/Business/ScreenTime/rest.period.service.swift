//
//  rest.period.service.swift
//  MrArthur
//
//  Created by Reille Sebastien on 07/11/2022.
//

import Foundation

class RestPeriodService {
    static func setLocalRestPeriod(restPeriod: EResetTime) {
        ExtensionRestPeriodService.setHasRestPeriod(value: restPeriod != .NO_REST)
        
        if (restPeriod == .TO19_08) {
            ExtensionRestPeriodService.setRestPeriodStartTimeHour(hour: 19)
            ExtensionRestPeriodService.setRestPeriodEndTimeHour(hour: 8)
        } else if (restPeriod == .TO21_07) {
            ExtensionRestPeriodService.setRestPeriodStartTimeHour(hour: 21)
            ExtensionRestPeriodService.setRestPeriodEndTimeHour(hour: 7)
        } else if (restPeriod == .TO23_06) {
            ExtensionRestPeriodService.setRestPeriodStartTimeHour(hour: 23)
            ExtensionRestPeriodService.setRestPeriodEndTimeHour(hour: 6)
        }
    }
}
