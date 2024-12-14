//
//  attendee.dashboard.progress.card.view.swift
//  MrArthur
//
//  Created by Troo on 31/08/22.
//

import SwiftUI

struct AttendeeDashboardProgressCardView: View {
    
    @Binding var entertainmentTimeLeft: Int
    @Binding var entertainmentTimeSpent: Int
    @Binding var entertainmentTotalTime: Int
    @Binding var educationalTimeSpent: Int
    @Binding var educationalTotalTime: Int
    
    var body: some View {
        VStack(spacing: 0) {
            
            EntertainmentTimeView(
                icon: "AttendeeDashboardStarSmallYellow",
                label: "Entertainment time left".localized,
                seconds: entertainmentTimeLeft,
                backgroundColor: .primaryYellow
            )
            .padding(.bottom, 8.h)
            
            EntertainmentTimeView(
                icon: "DashboardSEntertainmentTimeSpentIcon1",
                label: "Entertainment time spent".localized,
                seconds: entertainmentTimeSpent,
                backgroundColor: .primaryRed
            )
            .padding(.bottom, 16.h)
            
            VStack(alignment: .trailing, spacing: 8.h) {
                HStack(alignment: .bottom, spacing: 5.w) {
                    
                    Text(
                        UtilityMethod.getTimeStringBySeconds(
                            value: entertainmentTotalTime
                        )
                    )
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont10,
                            color: .primaryRed
                    )
                    
                    Image("DashboardSEntertainmentTimeSpentIcon2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16.r, height: 16.r)
                }
                ProgressHorizontalView(
                    timeLeft: $entertainmentTimeLeft,
                    timeSpent: $entertainmentTimeSpent,
                    totalTime: $entertainmentTotalTime
                )
            }
            .padding(.bottom, 34.h)
            
            VStack(alignment: .trailing, spacing: 8.h) {
                
                EntertainmentTimeView(
                    icon: "DashboardSEducationalTimeSpentIcon1",
                    label: "Educational time spent".localized,
                    seconds: educationalTimeSpent,
                    backgroundColor: .primaryBlue
                )
                
                HStack(alignment: .bottom, spacing: 5.w) {
                    Text(
                        UtilityMethod.getTimeStringBySeconds(
                            value: educationalTotalTime
                        )
                    )
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont10,
                            color: .primaryBlue
                    )
                    Image("DashboardSEducationalTimeSpentIcon2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16.r, height: 16.r)
                }
            }
            .padding(.bottom, 8.h)
            
            AchievementHorizontalView(
                educationalTimeSpent: $educationalTimeSpent,
                totalEducationalTime: $educationalTotalTime,
                totalEntertainmentTime: $entertainmentTotalTime
            )
            .padding(.bottom, 24.h)
            
            // Condition to user type, not displayed if observer
            AttendeeDashboardNoteView()
            
        }
        .padding()
        .background(Color.white.cornerRadius(22.r))
    }
}

struct AttendeeDashboardProgressCardViewPreviews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack {
                Spacer()
                AttendeeDashboardProgressCardView(
                    entertainmentTimeLeft: .constant(20),
                    entertainmentTimeSpent: .constant(30),
                    entertainmentTotalTime: .constant(100),
                    educationalTimeSpent: .constant(45),
                    educationalTotalTime: .constant(100)
                )
                Spacer()
            }
            .padding()
            .background(Color.secondaryRed)
        }
        .customNavigationView(title: "Dashboard".localized, color: .white)
        .multiPreview
    }
}
