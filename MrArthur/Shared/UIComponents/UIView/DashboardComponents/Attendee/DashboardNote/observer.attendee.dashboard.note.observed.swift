//
//  observed.attendee.dashboard.note.view.swift
//  MrArthur
//
//  Created by Reille Sebastien on 10/11/2022.
//

import Foundation
import SwiftUI
extension AttendeeDashboardNoteView{
    class AttendeeDashboardNoteViewObserver: ObservableObject {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.EDUCATIONAL_ST_SECOND_QUARTER_1,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var educationalSTSecondQuarter1: Int = 0
        
        @AppStorage(
            ExtensionSharedAppGroupService.keys.ENTERTAINMENT_ST_SECOND_QUARTER_1,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var entertainmentSTSecondQuarter1: Int = 0
        
        
        func getHtmlString(educationalSTQuarterOnGoing: Int) -> String {
            let educationalMinutes = getSpendEducationalMinutes(quarterOngoing: educationalSTQuarterOnGoing)
            
            let entertainmentTime = getToUnlockedEntertainmentTime(
                quarterOngoing: educationalSTQuarterOnGoing
            )
            
            let eachEducationalMinute = getEachEducationalMinute()
            
            let eachEducationalQuarter = getEntertainementMinuteByEachEducationalQuarter()
            return """
            <p>
                \("Spend ".localized)
                <span class="primaryBlueBg">\(educationalMinutes)</span>
                \(" more".localized)<br>
                \("to unlock".localized)
                <span class="primaryRedBg">\(entertainmentTime)</span>
                \(" of entertainment time.".localized)<br>
            </p>
            <p>
                \("Each ".localized)
                <span class="primaryBlueBg">\(eachEducationalMinute)</span>
                \(" unlock".localized)
                <span class="primaryYellowBg">\(eachEducationalQuarter)</span>
            </p>
"""
        }
        func getEntertainementMinuteByEachEducationalQuarter() -> String {
            if (entertainmentSTSecondQuarter1 != 0) {
                return UtilityMethod.getMinuteStringFromSecond(second: entertainmentSTSecondQuarter1)
            } else {
                return "0 min"
            }
        }
        
        func getEachEducationalMinute() -> String {
            if (educationalSTSecondQuarter1 != 0) {
                return UtilityMethod.getMinuteStringFromSecond(second: educationalSTSecondQuarter1)
            } else {
                return "0 min"
            }
        }
        
        func getSpendEducationalMinutes(quarterOngoing: Int) -> String {
            if (quarterOngoing != 4) {
                let timeSpentLocal: Int = ExtensionEducationalService.getEducationalSTSecondSpentDayLocalDevice()
                let timeSpentMulti: Int = ExtensionEducationalService.getEducationalSTSecondSpentDayMultiDevice()
                let timeSpent: Int = timeSpentMulti > timeSpentLocal ? timeSpentMulti : timeSpentLocal
                let quarters: QuartersFromSecondModel = ExtensionEducationalService.getAllQuarters()
                var timeToSpend: Int = 0

                if (quarterOngoing == 0) {
                    timeToSpend = quarters.quarter1 - timeSpent
                } else if (quarterOngoing == 1) {
                    timeToSpend = (quarters.quarter1 + quarters.quarter2) - timeSpent
                } else if (quarterOngoing == 2) {
                    timeToSpend = (quarters.quarter1 + quarters.quarter2 + quarters.quarter3) - timeSpent
                } else if (quarterOngoing == 3) {
                    timeToSpend = (quarters.quarter1 + quarters.quarter2 + quarters.quarter3 + quarters.quarter4) - timeSpent
                }
                return UtilityMethod.getTimeStringBySeconds(value: timeToSpend)
            } else {
                return "00:00:00"
            }
        }
        
        func getToUnlockedEntertainmentTime(quarterOngoing: Int) -> String {
            if (quarterOngoing != 4) {
                return UtilityMethod.getMinuteStringFromSecond(second: entertainmentSTSecondQuarter1)
            } else {
                return "0 min"
            }
        }
    }
}
