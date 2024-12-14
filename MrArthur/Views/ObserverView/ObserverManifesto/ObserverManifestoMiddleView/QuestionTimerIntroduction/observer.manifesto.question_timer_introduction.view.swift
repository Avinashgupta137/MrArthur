//
//  observer.manifesto.question_timer_introduction.view.swift
//  MrArthur
//
//  Created by IPS-157 on 14/07/22.
//

import SwiftUI

struct QuestionTimerIntroductionView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            
            VStack(alignment: .leading, spacing: 0) {
                Group{
                    Text("To help you, ".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont25
                        )
                    +
                    Text("mr.arthur".localized)
                        .fontModifier(
                            font: .montserratBlack,
                            size: iPhoneFont25
                        ) +
                    Text(" needs to ask you a few questions.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont25
                        )
                }
                .padding(.bottom, 20.h)
                Group{
                    Text("Please answer the questions with the child facing the biggest challenges.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont25
                        )
                    
                    
                }
            }
            .padding(.top, 50.h)
            .padding(.horizontal, 24.w)
            .padding(.bottom, 100.h)
            
            HStack(spacing: 16.h){
                Image("iconTimer")
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: 35.w,
                        height: 40.h
                    )
                
                Rectangle()
                    .fill(Color.white)
                    .frame(
                        width: 1.r,
                        height: 63.h
                    )
                    .padding(.trailing, 4.w)
                
                VStack(alignment: .leading, spacing: 0){
                    Text("ESTIMATED TIME".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont12,
                            color: .primaryBlue
                        )
                    
                    Text("3 min".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont20,
                            color: .primaryBlue
                        )
                }
            }
            .padding(.horizontal, 24.w)
            
            Spacer(minLength: 16.h)
            
            Image("stepOnboardingObserverQuestionTimerIntroduction")
                .resizable()
                .scaledToFit()
                .padding(.trailing, 130.w)
                .frame(
                    width: UIScreen.screenWidth,
                    alignment: .leading
                )
            
            Spacer(minLength: 16.h)
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

struct QuestionTimerIntroductionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionTimerIntroductionView()
    }
}
