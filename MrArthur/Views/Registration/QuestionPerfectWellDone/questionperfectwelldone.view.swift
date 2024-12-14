//
//  QuestionPerfectWellDone.swift
//  MrArthur
//
//  Created by IPS-169 on 22/07/22.
//

import SwiftUI

struct QuestionPerfectWellDone: View {
    @EnvironmentObject private var observerManifestoObservedObject: ObserverManifesto
    @EnvironmentObject private var rootViewObserver: RootViewObserver
    @StateObject private var observed = Observed()
    var body: some View {
        VStack(spacing: 0){
            VStack(alignment: .leading, spacing: 0) {
                Text("Let's do this!".localized)
                    .fontModifier(
                        font: .montserratBlack,
                        size: iPhoneFont25
                    )
                    .padding(.bottom, 30.h)
                
                Group{
                    Text("With ".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont25
                        )
                    +
                    Text("mr.arthur,".localized)
                        .fontModifier(
                            font: .montserratBlack,
                            size: iPhoneFont25
                        )
                }
                
                Text("we guide you through your first mediation every step of the way!".localized)
                    .fontModifier(
                        font: .montserratRegular,
                        size: iPhoneFont25
                    )
            }
            
            Spacer(minLength: 16.h)
            
            Image("stepOnboardingObserverQuestionPerfectWellDone")
                .resizable()
                .scaledToFit()
                .frame(
                    width: 267.w,
                    height: 265.h
                )
            
            Spacer(minLength: 16.h)
            
            BlueRoundedButton(
                "NEXT",
                width: 184.14,
                height: 60
            ) {
                AmplitudeService.sendEvent(
                    key: .OBS_MAIL_FINISH_NEXT
                )
                observerManifestoObservedObject.currentIndex = 25
                rootViewObserver.currentPage = .attendeeList
            }
            
        }
        .padding(.vertical, 40.h)
        .padding(.horizontal, 24)
        .statusBarStyle(color: .statusBarColor)
        .background(
            LinearGradient(
                colors: [
                    Color.primaryRed
                    , Color.thirdRed
                ],
                startPoint: .top,
                endPoint: .bottomTrailing
            )
        )
        .edgesIgnoringSafeArea(.all)
    }
    
}

//struct QuestionPerfectWellDone_Previews: PreviewProvider {
//    static var previews: some View {
//        QuestionPerfectWellDone()
//            .multiPreview
//    }
//}
