//
//  AttendeeModifyGoalView.swift
//  MrArthur
//
//  Created by Troo on 04/08/22.
//

import SwiftUI

struct AttendeeModifyGoalView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var observer = ModifyGoalObserved()
    @State public var dataChangedByAttendee : Bool = false
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                Text("Current goal".localized)
                    .fontModifier(
                        font: .montserratBlack,
                        size: iPhoneFont25,
                        color: .primaryBlue
                    )
                AttendeeModifyGoalProgressView(
                    dataChangedByAttendee: $dataChangedByAttendee,
                    sReducedTotalScreenTime: observer.sReducedTotalScreenTime,
                    sEducationalTotalScreenTime: observer.sEducationalTotalScreenTime,
                    goalEndAngel: observer.goalEndAngel,
                    autoReduceEnabled: observer.autoReduceEnabled,
                    autoEducationalEnabled: observer.autoEducationalEnabled,
                    totalTitle: "Total\nscreen\ntime".localized,
                    goalTitle: "Educational\nscreen\ntime".localized,
                    reduceEnabled : observer.reduceEnabled,
                    educationalEnabled : observer.educationalEnabled,
                    reduceScreenTimeBy5: {
                        observer.reduceScreenTimeBy5()
                    },
                    autoIncreaseReducedTotalScreenTimePercent: {
                        observer.autoIncreaseReducedTotalScreenTimePercent()
                    },
                    incEduicationalScreenTimeBy5: {
                        observer.incEduicationalScreenTimeBy5()
                    },
                    autoIncreaseEducationalTotalScreenTimePercent: {
                        observer.autoIncreaseEducationalTotalScreenTimePercent()
                    }
                )
                
                ZStack {
                    Rectangle()
                        .fill(Color.white)
                        .frame(height: 1)
                        .padding(.horizontal, 10.w)
                    
                    Image(observer.mrImage)
                        .resizable()
                        .frame(width: 110.r, height: 110.r)
                }
                .padding(.top, 20.h)
                
                Text(observer.mrText)
                    .fontModifier(
                        font: .montserratExtraBoldItalic,
                        size: iPhoneFont18, color: .primaryBlue
                    )
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 24.h)
                    .padding(.horizontal, 50.h)
                
                Spacer()
                
                HStack(spacing: 12) {
                    BlueRoundedButton("RESET", color: .primaryRed) {
                        observer.resetScreenTimes()
                        AmplitudeService.sendEvent(
                            key: .OBS_CO_8_RESET
                        )
                    }
                    .opacity(dataChangedByAttendee ? 1 : 0.4)
                    .disabled(!dataChangedByAttendee)
                    
                    BlueRoundedButton("SEND") {
                        observer.sendGoal {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        AmplitudeService.sendEventWithData(
                            key: .OBS_CO_8_SEND,
                            data: ["reduceScreenTimeInPercentage" : observer.iReducedTotalScreenTimePercent]
                        )
                    }
                    .opacity(dataChangedByAttendee ? 1 : 0.4)
                    .disabled(!dataChangedByAttendee)
                }
            }
            .padding(.vertical, 34.w)
        }
        .padding(.horizontal, 24.w)
        .customNavigationViewWithoutBackWithAmplitudeEvent(
            title: "Modify goal".localized,
            color: .white,
            amplitudeEvent: .OBS_CO_8_BACK
        )
        
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
        .edgesIgnoringSafeArea(.bottom)
    }
}

/*
struct AttendeeModifyGoalView_Previews: PreviewProvider {
    static var previews: some View {
        AttendeeModifyGoalView()
            .multiPreview
    }
}*/
