//
//  attendee.howitwork.context.View.swift
//  MrArthur
//
//  Created by Nirav Patel on 17/10/22.
//

import SwiftUI

struct AttendeeHowitworkContextView: View {
    @StateObject var observer = ATTHowItWorkObserver()
    @EnvironmentObject private var attendeeHowItWorkPageObs: AttendeeHowItWorkPageObs
    var body: some View {
        switch attendeeHowItWorkPageObs.currentPage {
        case .CONGRATS:
            AttendeeHowItWorksAvoidedNightmareView()
        case .SUMMARY:
            AttendeeHotItWorksGoalSummary(
                iReducedTotalScreenTimePercent: $observer.iReducedTotalScreenTimePercent,
                sReducedTotalScreenTime: $observer.sReducedTotalScreenTime,
                iEducationalTotalScreenTimePercent: $observer.iEducationalTotalScreenTimePercent,
                sEducationalTotalScreenTime: $observer.sEducationalTotalScreenTime
            )
        case .MECHANICS_INTRO:
            AttendeeHowItWorksExplainMechanics()
        case .EDUCATIONAL_APPS:
            AttendeeHowItWorksParentEduc()
        case .UNLOCK_ENTERTAINMENT_TIME:
            AttendeeHowItWorksUnlock()
        case .DAILY_ADVANCE_ENTERTAINMENT_TIME:
            AttendeeHowItWorksAttendeeMinadvance()
        case .SAVE_ENTERTAINMENT_TIME:
            AttendeeHowItWorksReadyForNextDay()
        case .LOOK_AT_DASHBOARD:
            AttendeeHowItWorksLookAtDashboard()
        }
    }
}
