//
//  observer.manifesto.question_interlude.view.swift
//  MrArthur
//
//  Created by IPS-169 on 14/07/22.
//

import SwiftUI
struct ManifestoQuestioninterlude: View {
    @StateObject private var observed = Observed()
    var body: some View {
        VStack(spacing: 0){
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Group{
                        Text("Two more minuets, and we are done!".localized)
                            .fontModifier(
                                font: .montserratRegular,
                                size: iPhoneFont25,
                                color: .primaryBlue
                            )
                        +
                        Text(UtilityMethod.isFrench ? "" : "\n\nYour child is unique, ")
                            .fontModifier(
                                font: .montserratRegular,
                                size: iPhoneFont25,
                                color: .primaryBlue
                            )
                        +
                        
                        Text("mr.arthur's ".localized)
                            .fontModifier(
                                font: .montserratBlack,
                                size: iPhoneFont25,
                                color: .primaryBlue
                            )
                        +
                        Text("help is personalized.".localized)
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
        .padding(.top, 50.h)
        .statusBarStyle(color: .white)
        .fullScreenFrame
        .background(Color.backgroundOffWhite)
    }
}

struct ManifestoQuestioninterlude_Previews: PreviewProvider {
    static var previews: some View {
        ManifestoQuestioninterlude()
        //.multiPreview
    }
}
