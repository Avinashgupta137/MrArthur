//
//  attendeeModifyGoalProgressView.swift
//  MrArthur
//
//  Created by Troo on 04/08/22.
//

import SwiftUI

struct AttendeeModifyGoalProgressView: View {
    
    @Binding var dataChangedByAttendee:Bool
    //    @StateObject var observer = ModifyGoalObserved()
    let sReducedTotalScreenTime: String
    let sEducationalTotalScreenTime: String
    let goalEndAngel: Double
    let autoReduceEnabled: Bool
    let autoEducationalEnabled: Bool
    let totalTitle: String
    let goalTitle: String
    let reduceEnabled: Bool
    let educationalEnabled: Bool
    let reduceScreenTimeBy5: () -> ()
    let autoIncreaseReducedTotalScreenTimePercent: () -> ()
    let incEduicationalScreenTimeBy5: () -> ()
    let autoIncreaseEducationalTotalScreenTimePercent: () -> ()
    
    let lineWidth: CGFloat = 50.w
    let startdAngel:Double = 20
    let endAngel:Double = 160
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack(spacing: 16.w) {
                    VStack(spacing: 10.h){
                        Text(sReducedTotalScreenTime)
                            .fontModifier(font: .montserratBold, size: iPhoneFont20)
                            .padding(.vertical, 8.h)
                            .padding(.horizontal, 16.w)
                            .background(Color.primaryRed.cornerRadius(24.r))
                        
                        Text(totalTitle.localized)
                            .fontModifier(
                                font: .montserratBold,
                                size: iPhoneFont15,
                                color: .primaryBlue
                            )
                            .multilineTextAlignment(.center)
                    }
                    
                    VStack(spacing: 10.h){
                        Text(sEducationalTotalScreenTime)
                            .fontModifier(
                                font: .montserratBold,
                                size: iPhoneFont20
                            )
                            .padding(.vertical, 8.h)
                            .padding(.horizontal, 16.w)
                            .background(Color.primaryBlue.cornerRadius(24.r))
                        
                        Text(goalTitle.localized)
                            .fontModifier(
                                font: .montserratBold,
                                size: iPhoneFont15,
                                color: .primaryBlue
                            )
                            .multilineTextAlignment(.center)
                    }
                }
                .padding(.bottom, 60.h)
                
                Arc(
                    startAngle: .degrees(startdAngel),
                    endAngle: .degrees(endAngel),
                    clockWise: false
                )
                .stroke(
                    Color.primaryRed,
                    lineWidth: lineWidth
                )
                
                Arc(
                    startAngle: .degrees(startdAngel),
                    endAngle: .degrees(goalEndAngel),
                    clockWise: false
                )
                .stroke(
                    Color.primaryBlue,
                    lineWidth: lineWidth
                )
                .animation(.spring(), value: goalEndAngel)
            }
            .frame(
                width: 270.r,
                height: 270.r
            )
            .padding(.bottom, lineWidth/2)
            .padding(.horizontal, lineWidth/2)
            
            HStack(spacing: 24.w) {
                
                Button {
                    dataChangedByAttendee = true
                    AmplitudeService.sendEvent(key: .OBS_CO_8_MINUS_TOTAL_SCREEN_TIME)
                    reduceScreenTimeBy5()
                } label: {
                    Image("buttonScreenTimeLess")
                        .resizable()
                        .frame(
                            width: 65.r,
                            height: 65.r
                        )
                }
                .contentShape(Rectangle())
                .disabled(!reduceEnabled)
                .opacity(reduceEnabled ? 1 : 0.4)
                
                Button {
                    dataChangedByAttendee = true
                    AmplitudeService.sendEvent(key: .OBS_CO_8_AUTO_TOTAL_SCREEN_TIME)
                    autoIncreaseReducedTotalScreenTimePercent()
                    
                } label: {
                    Text("AUTO".localized)
                        .fontModifier(
                            font: .montserratBlack,
                            size: iPhoneFont20
                        )
                        .background(
                            Circle()
                                .fill(Color.primaryRed)
                                .frame(
                                    width: 86.r,
                                    height: 86.r
                                )
                        )
                }
                .contentShape(Rectangle())
                .disabled(!autoReduceEnabled)
                .opacity(autoReduceEnabled ? 1 : 0.4)
                
                Button {
                    dataChangedByAttendee = true
                    AmplitudeService.sendEvent(key: .OBS_CO_8_PLUS_EDUCATION)
                    incEduicationalScreenTimeBy5()
                } label: {
                    Image("buttonSmartTimePlus")
                        .resizable()
                        .frame(
                            width: 65.r,
                            height: 65.r
                        )
                }
                .contentShape(Rectangle())
                .disabled(!educationalEnabled)
                .opacity(educationalEnabled ? 1 : 0.4)
                
                Button {
                    dataChangedByAttendee = true
                    AmplitudeService.sendEvent(key: .OBS_CO_8_AUTO_EDUCATION)
                    autoIncreaseEducationalTotalScreenTimePercent()
                } label: {
                    Text("AUTO".localized)
                        .fontModifier(
                            font: .montserratBlack,
                            size: iPhoneFont20
                        )
                        .background(
                            Circle()
                                .fill(Color.primaryBlue)
                                .frame(
                                    width: 86.r,
                                    height: 86.r
                                )
                        )
                }
                .contentShape(Rectangle())
                .disabled(!autoEducationalEnabled)
                .opacity(autoEducationalEnabled ? 1 : 0.4)
            }
            .padding(.top, 24.h)
        }
    }
}


//struct AttendeeModifyGoalProgressView_Previews: PreviewProvider {
//    static var previews: some View {
//        AttendeeModifyGoalProgressView(
//            dataChangedByAttendee: .constant(false),
//            sReducedTotalScreenTime: "00h00",
//            sEducationalTotalScreenTime: "00h00",
//            goalEndAngel: 25,
//            autoReduceEnabled: false,
//            autoEducationalEnabled: false,
//            totalTitle: "Total\nscreen\ntime".localized,
//            goalTitle: "Educational\nscreen\ntime".localized,
//            reduceEnabled : false,
//            educationalEnabled : false,
//            reduceScreenTimeBy5: {},
//            autoIncreaseReducedTotalScreenTimePercent: {},
//            incEduicationalScreenTimeBy5: {},
//            autoIncreaseEducationalTotalScreenTimePercent: {}
//        )
//            .multiPreview
//    }
//}
