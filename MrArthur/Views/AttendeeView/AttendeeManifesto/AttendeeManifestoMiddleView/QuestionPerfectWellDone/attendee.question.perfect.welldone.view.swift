//
//  QuestionPerfectWellDone.swift
//  MrArthur
//
//  Created by IPS-157 on 03/08/22.
//

import SwiftUI

struct AttendeeQuestionPerfectWellDone: View {
    @StateObject private var observed = Observed()
    @State private var howItWorks = false
    @EnvironmentObject private var attendeeManifestoObservedObject : AttendeeManifestoObserver
    
    var body: some View {
        VStack(spacing: 0){
            VStack(alignment: .leading, spacing: 0) {
                Text("Perfect!".localized)
                    .fontModifier(
                        font: .montserratBlack,
                        size: iPhoneFont25
                    )
                    .padding(.bottom, 30.h)
                
                Text("You can analyse your screen time and create your first goal!".localized)
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
        }
        .padding(.vertical, 40.h)
        .padding(.horizontal, 24.w)
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

//struct AttendeeQuestionPerfectWellDone_Previews: PreviewProvider {
//    static var previews: some View {
//        AttendeeQuestionPerfectWellDone()
//            .multiPreview
//    }
//}
