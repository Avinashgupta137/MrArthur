//
//  QuestionCourageLittleTimeLeft.swift
//  MrArthur
//
//  Created by IPS-157 on 03/08/22.
//

import SwiftUI

struct QuestionCourageLittleTimeLeft: View {
    @StateObject private var observed = Observed()
    var body: some View {
        VStack(spacing: 0){
            
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Great! ".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont25,
                            color: .primaryBlue
                        )
                        .padding(.bottom, 30.h)

                    Group{
                        Text("Keep up playing along and ".localized)
                            .fontModifier(
                                font: .montserratRegular,
                                size: iPhoneFont25,
                                color: .primaryBlue
                            )
                        +
                        Text("you'll have control over your ".localized)
                            .fontModifier(
                                font: .montserratRegular,
                                size: iPhoneFont25,
                                color: .primaryBlue
                            )
                        +
                        Text("screen time! ".localized)
                            .fontModifier(
                                font: .montserratRegular,
                                size: iPhoneFont25,
                                color: .primaryBlue
                            )
                    }
                    
                }
                
                Spacer(minLength: 16.w)
            }
            .padding(.bottom, 120.h)
            .padding(.horizontal, 24.w)
            
            Image("stepOnboardingAttendeeQuestionCourageLittleTimeLeft")
                .resizable()
                .frame(
                    width: UIScreen.screenWidth,
                    height: 250.h
                )
            Spacer(minLength: 16.h)
        }
        .padding(.top, 50.h + statusBarHeight)
        .fullScreenFrame
        .background(Color.secondaryRed)
    }
}

//struct QuestionCourageLittleTimeLeft_Previews: PreviewProvider {
//    static var previews: some View {
//        QuestionCourageLittleTimeLeft()
//            .multiPreview
//    }
//}
