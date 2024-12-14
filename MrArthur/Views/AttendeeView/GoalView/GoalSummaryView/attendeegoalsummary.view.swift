//
//  AttendeeGoalSummary.swift
//  MrArthur
//
//  Created by IPS-157 on 10/08/22.
//

import SwiftUI

struct AttendeeGoalSummary: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var iReducedTotalScreenTimePercent : Int
    @Binding var iEducationalTotalScreenTimePercent : Int
    @Binding var sReducedTotalScreenTime : String
    @Binding var sEducationalTotalScreenTime : String
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            Button {
                AmplitudeService.sendEvent(
                    key: .ATT_CO_4_BIS_BACK
                )
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "chevron.backward")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.secondaryBlue)
                    .frame(width: 25, height: 25, alignment: .leading)
            }
            .padding(.top, 40.h)
            
            Text("GOAL".localized)
                .fontModifier(
                    font: .montserratBlack,
                    size: iPhoneFont25,
                    color:.secondaryBlue
                )
                .padding(.top, 32.h)
            
            Group{
                Text("STATUS : ".localized)
                    .fontModifier(
                        font: .montserratBold,
                        size: iPhoneFont15,
                        color:.secondaryBlue
                    )
                +
                Text("currently being reviewed".localized)
                    .fontModifier(
                        font: .montserratBold,
                        size: iPhoneFont15,
                        color:.primaryOrange
                    )
            }
            .padding(.top, 3.h)
            
            Rectangle()
                .fill(Color.thirdRed)
                .frame(height: 1.h)
                .padding(.vertical, 8.h)
            
            Text("SUMMARY".localized)
                .fontModifier(
                    font: .montserratBold,
                    size: iPhoneFont15,
                    color:.secondaryBlue
                )
            
            ATTGoalSummaryTextView(
                rPercentage: iReducedTotalScreenTimePercent,
                rDuration: sReducedTotalScreenTime,
                ePercentage: iEducationalTotalScreenTimePercent,
                eDuration: sEducationalTotalScreenTime
            )
            
            Spacer(minLength: 24.h)
        }
        .padding(.horizontal, 24.w)
        .frame(width: UIScreen.screenWidth)
        .hideNavigation
        .statusBarStyle(color: .statusBarColor)
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

/*
struct AttendeeGoalSummary_Previews: PreviewProvider {
    static var previews: some View {
        AttendeeGoalSummary(
            iReducedTotalScreenTimePercent: .constant(23),
            iEducationalTotalScreenTimePercent: .constant(23),
            sReducedTotalScreenTime: .constant("00h00"),
            sEducationalTotalScreenTime: .constant("00h00")
        )
        .multiPreview
    }
}*/
