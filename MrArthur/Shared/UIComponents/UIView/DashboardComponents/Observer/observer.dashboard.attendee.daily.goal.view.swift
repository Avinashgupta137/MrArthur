//
//  observer.dashboard.attendee.daily.goal.view.swift
//  MrArthur
//
//  Created by BAPS on 13/12/22.
//

import SwiftUI
import RichText

struct OBSDashboardATTDailyGoalView: View {
    @Binding var educationalQuarterOnGoing: Int?
    @Binding var entertainmentTimeSpent: Int?
    @Binding var entertainementTotalTime: Int?
    @Binding var educationalTimeSpent: Int?
    @Binding var educationalTotalTime: Int?
    
    @ObservedObject var observer = OBSDashboardATTDailyGoalViewObserver()
    let attendeeName = UserDefaultsHelper.selectedAttendee?.attendeeName ?? "#ATTENDEE "
    
    var body: some View {
        VStack(spacing: 0) {
            
            ZStack {
                Image("AttendeeDashboardStarBigYellow")
                    .frame(width: 44.r, height: 44.r)
                    .background(Color.whiteColor)
                    .zIndex(1)
                
                Rectangle()
                    .fill(Color.primaryYellow)
                    .frame(width: 239.w, height: 3.h)
                    .padding(.top, 10.h)
            }
            
            Group{
                Text(attendeeName.localized)
                    .fontModifier(
                        font: .montserratBlack,
                        size: iPhoneFont15,
                        color: .primaryBlue
                    )
                +
                Text(" DAILY GOAL".localized)
                    .fontModifier(
                        font: .montserratBlack,
                        size: iPhoneFont15,
                        color: .primaryYellow
                    )
            }
            .padding(.top, 16.h)
            
            RichText(html: observer.getHtmlString(
                educationalQuarterOnGoing: educationalQuarterOnGoing ?? 0,
                entertainmentTimeSpent: entertainmentTimeSpent ?? 0,
                entertainementTotalTime: entertainementTotalTime ?? 0,
                educationalTimeSpent: educationalTimeSpent ?? 0,
                educationalTotalTime: educationalTotalTime ?? 0
            ))
            .customCSS(UtilityMethod.achivementCss)
        }
        .padding(16.r)
        .background(Color.white.cornerRadius(24.r))
    }
}

//struct observer_dashboard_attendee_daily_goal_view_Previews: PreviewProvider {
//    let quarterOngoing: Int = 0
//
//    static var previews: some View {
//        VStack{
//            Spacer()
//            OBSDashboardATTDailyGoalView(educationalQuarterOnGoing: .constant(110), entertainmentTimeSpent: .constant(110), entertainementTotalTime: .constant(110), educationalTimeSpent: .constant(110), educationalTotalTime: .constant(110))
//            Spacer()
//        }
//        .padding(24.w)
//        .fullScreenFrame
//        .background(Color.secondaryRed)
//    }
//}

extension OBSDashboardATTDailyGoalView{
    class OBSDashboardATTDailyGoalViewObserver: ObservableObject {
        
        func getHtmlString(
            educationalQuarterOnGoing: Int,
            entertainmentTimeSpent: Int,
            entertainementTotalTime: Int,
            educationalTimeSpent: Int,
            educationalTotalTime: Int
        ) -> String {
            let educationalMinutes = getSpendEducationalMinutes(
                quarterOngoing: educationalQuarterOnGoing,
                educationalTimeSpent: educationalTimeSpent,
                educationalTotalTime: educationalTotalTime
            )
            
            let entertainmentTime = getToUnlockedEntertainmentTime(
                quarterOngoing: educationalQuarterOnGoing,
                entertainmentTimeSpent: entertainmentTimeSpent,
                entertainmentTotalTime: entertainementTotalTime
            )
            
            let eachEducationalMinute = getEachEducationalMinute(educationalTotalTime: educationalTotalTime)
            
            let eachEducationalQuarter = getEntertainementMinuteByEachEducationalQuarter(entertainmentTotalTime: entertainementTotalTime)
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
        
        func getEntertainementMinuteByEachEducationalQuarter(entertainmentTotalTime: Int) -> String {
            let entertainmentQuarters: QuartersFromSecondModel = ExtensionScreenTimeHelperService.getQuartersFromSecond(second: entertainmentTotalTime)
            if (entertainmentQuarters.quarter1 != 0) {
                return UtilityMethod.getMinuteStringFromSecond(second: entertainmentQuarters.quarter1)
            } else {
                return "0 min"
            }
        }
        
        func getEachEducationalMinute(educationalTotalTime: Int) -> String {
            let educationalQuarters: QuartersFromSecondModel = ExtensionScreenTimeHelperService.getQuartersFromSecond(second: educationalTotalTime)
            if (educationalQuarters.quarter1 != 0) {
                return UtilityMethod.getMinuteStringFromSecond(second: educationalQuarters.quarter1)
            } else {
                return "0 min"
            }
        }
        
        func getSpendEducationalMinutes(
            quarterOngoing: Int,
            educationalTimeSpent: Int,
            educationalTotalTime: Int
        ) -> String {
            if (quarterOngoing != 4) {
                let timeSpent: Int = educationalTimeSpent
                let quarters: QuartersFromSecondModel = ExtensionScreenTimeHelperService.getQuartersFromSecond(second: educationalTotalTime)
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
        
        func getToUnlockedEntertainmentTime(
            quarterOngoing: Int,
            entertainmentTimeSpent: Int,
            entertainmentTotalTime: Int
        ) -> String {
            let entertainmentQuarters: QuartersFromSecondModel = ExtensionScreenTimeHelperService.getQuartersFromSecond(second: entertainmentTotalTime)
            if (quarterOngoing != 4) {
                return UtilityMethod.getMinuteStringFromSecond(second: entertainmentQuarters.quarter1)
            } else {
                return "0 min"
            }
        }
    }
}
