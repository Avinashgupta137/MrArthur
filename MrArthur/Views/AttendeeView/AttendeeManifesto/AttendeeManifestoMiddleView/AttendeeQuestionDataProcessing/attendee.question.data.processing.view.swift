//
//  AttendeeQuestionDataProcessing.swift
//  MrArthur
//
//  Created by IPS-157 on 03/08/22.
//

import SwiftUI

struct AttendeeQuestionDataProcessing: View {
    
    @StateObject private var observed = AttendeeQuestionDataProcessingObserver()
    @Binding var questionState:StateOfQuestion
    @State var headLabel = "mr.arthur".localized
    @State var subLabel = "AI initialisation".localized
    @State var progress = "0%"
    @State var percentage  = 0
    let arrofscreenname = UtilityMethod().getValueForKey(key: ConstantOfApp.kScreenNameList) as? [String] ?? [String]()
    
    @EnvironmentObject private var attendeemanifestoPageObs:AttendeeManifestoObserver
    @EnvironmentObject private var rootViewObserver: RootViewObserver
    
    var body: some View {
        VStack(spacing: 0) {
            
            Spacer(minLength: 16.h)
            
            Text(headLabel.localized)
                .fontModifier(
                    font: (percentage < 80) ? .montserratBlack : .montserratRegular,
                    size: iPhoneFont25 ,
                    color: (percentage < 80) ? .primaryBlue : .white
                )
            
            Text(subLabel.localized)
                .fontModifier(
                    font: .montserratRegular,
                    size: iPhoneFont25,
                    color: .white
                )
                .padding(.top, 5.h)
             
//            CircularProgressView(
//                onComplete: {
//                print("Progress completion handler")
//                AmplitudeService.sendEvent(key: .AT_BTN_NEXT_ATT_DATA_PROCESSING)
//                observed.nextStepOnBordingAttendeeAPICall { error, onboardingresponse in
//                    if let error = error, !error.isEmpty {
//                        print("error message =\(error ?? "")")
//                    } else {
//                        attendeemanifestoPageObs.currentHowItsWorkIndex = attendeemanifestoPageObs.currentIndex + 1
//                        questionState = .none
//                        let currentUserRole = UtilityMethod().getValueForKey(key: ConstantOfApp.kCurrentUserRole) as? String ?? ""
//
//                        if(currentUserRole == ConstantOfApp.kCurrentUserObserver){
//                            rootViewObserver.currentPage = .observerTabBar
//                        }else{
//                            MediationService().fetchMediationInfo { message, MediationDetailResponseModel, status in
//                                     if(status == true){
//                                         rootViewObserver.currentPage = .attendeeDashboard
//                                     }
//                                 }
//                        }
//
//                    }
//                }
//            
//
//            },onChange: { value in
//                progress = "\(value)%"
//                
//                percentage = value
//                print(progress)
//            })
            .frame(
                width: 227.w,
                height: 227.h
            )
            .padding(.top, 70.h)
            
            Text(progress)
                .fontModifier(
                    font: .montserratRegular,
                    size: iPhoneFont50
                )
                .padding(.top, 28.h)
            
            Spacer(minLength: 16.h)
        }
        .onAppear {
            questionState = .answerGiving
        }
        .onChange(of: percentage) { newValue in
            if percentage >= 80 {
                headLabel = "Analysing".localized
                subLabel = "your answers".localized
            }
        }
        .statusBarStyle(color: .statusBarColor)
        .background(
            LinearGradient(
                colors: [
                    Color.primaryRed,
                    Color.thirdRed
                ],
                startPoint: .top,
                endPoint: .bottomTrailing
            )
        )
    }
}

struct AttendeeQuestionDataProcessing_Previews: PreviewProvider {
    static var previews: some View {
        AttendeeQuestionDataProcessing(questionState: .constant(.none))
    }
}
