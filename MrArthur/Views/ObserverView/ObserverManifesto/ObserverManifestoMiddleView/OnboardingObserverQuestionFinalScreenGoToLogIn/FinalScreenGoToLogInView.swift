//
//  FinalScreenGoToLogInView.swift
//  MrArthur
//
//  Created by IPS-157 on 20/07/22.
//

import SwiftUI

struct FinalScreenGoToLogInView: View {
    let image = "tepOnboardingObserverQuestionFinalScreenGoToLogIn"
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            
            HStack{
                VStack(alignment: .leading, spacing: 0) {
                    Text("Perfect !".localized)
                        .fontModifier(
                            font: .montserratBlack,
                            size: iPhoneFont25
                        )
                        .padding(.bottom, 30.h)
                    
                    Text("Sign up to save your answers!".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont25
                        )
                    
                }
                Spacer(minLength: 16.w)
            }
            .padding(.horizontal, 22.w)
            .padding(.top, 50.h)
            
            Spacer(minLength: 16.h)
            
            Image(image)
                .resizable()
                .scaledToFit()
                .padding(.trailing, 170.w)
                .frame(
                    width: UIScreen.screenWidth,
                    alignment: .leading
                )
            
            Spacer(minLength: 150.h)
            
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

struct FinalScreenGoToLogInView_Previews: PreviewProvider {
    static var previews: some View {
        FinalScreenGoToLogInView()
            .multiPreview
    }
}
