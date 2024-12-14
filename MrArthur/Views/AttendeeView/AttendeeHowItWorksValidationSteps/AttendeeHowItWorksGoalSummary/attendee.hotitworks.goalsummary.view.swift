//
//  attendee.hotitworks.goalsummary.view.swift
//  MrArthur
//
//  Created by IPS-169 on 02/09/22.
//

import SwiftUI

struct AttendeeHotItWorksGoalSummary: View {
    @Binding var iReducedTotalScreenTimePercent: Int
    @Binding var sReducedTotalScreenTime : String
    @Binding var iEducationalTotalScreenTimePercent: Int
    @Binding var sEducationalTotalScreenTime : String
    
    var body: some View {
        HStack(spacing: 0){
            VStack(spacing: 0){
                VStack(alignment: .leading, spacing: 3.h){
                    Text("GOAL SUMMARY".localized)
                        .fontModifier(
                            font: .montserratExtraBold,
                            size: iPhoneFont15,
                            color:.primaryBlue
                        )
                        .padding(.top, statusBarHeight + 16.h)
                        .padding(.bottom, 3.h)
                    
                    ATTGoalSummaryTextView(
                        rPercentage: iReducedTotalScreenTimePercent,
                        rDuration: sReducedTotalScreenTime,
                        ePercentage: iEducationalTotalScreenTimePercent,
                        eDuration: sEducationalTotalScreenTime
                        
                    )
                    
                    Spacer(minLength: 16.h)
                }
                .padding(.top, 40.h)
                Spacer(minLength: 16.h)
            }
        }
        .padding(.horizontal, 30.h)
        .background(
            LinearGradient(
                gradient: Gradient(
                    stops: [
                        Gradient.Stop(
                            color: .lightPink, location: 0.5
                        ),
                        Gradient.Stop(
                            color: .secondaryRed, location: 0.9
                        ),
                    ]
                ),
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}

//struct AttendeeHotItWorksGoalSummary_Previews: PreviewProvider {
//    static var previews: some View {
//        AttendeeHotItWorksGoalSummary(
//            iReducedTotalScreenTimePercent: .constant(22),
//            sReducedTotalScreenTime: .constant("00h00"),
//            iEducationalTotalScreenTimePercent: .constant(22),
//            sEducationalTotalScreenTime: .constant("00h00")
//        )
//            .multiPreview
//    }
//}
