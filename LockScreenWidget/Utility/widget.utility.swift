//
//  widget.utility.swift
//  MrArthur
//
//  Created by BAPS on 16/01/23.
//

import Foundation

class WidgetUtility {
    static func getTimeString(_ value: Int) -> String {
        let (h, m, s) = UtilityMethod.secondsToHoursMinutesSeconds(value)
        if (h < 0 || m < 0 || s < 0) {
            return "-" + abs(h)._toTimeFormate + ":" + abs(m)._toTimeFormate + ":" + abs(s).toTimeFormate
        } else {
            return h.toTimeFormate + ":" + m.toTimeFormate + ":" + s.toTimeFormate
        }
    }
    
    static func getTotalTimeSave(_ value: Int) -> String {
        let (h, m) = (value / 3600, (value % 3600) / 60)
        return "\(h)h\(m.toTimeFormate)"
    }
    
    static func getStringFromERestPeriod(restPeriod: ERestPeriod?) -> String {
        if let restPeriod = restPeriod {
            switch restPeriod {
            case ERestPeriod.REST_19_TO_08:
                return "19h-08h"
            case ERestPeriod.REST_21_TO_07:
                return "21h-07h"
            case ERestPeriod.REST_23_TO_06:
                return "23h-06h"
            default:
                return "-"
            }
        } else {
            return "-"
        }
    }
}
