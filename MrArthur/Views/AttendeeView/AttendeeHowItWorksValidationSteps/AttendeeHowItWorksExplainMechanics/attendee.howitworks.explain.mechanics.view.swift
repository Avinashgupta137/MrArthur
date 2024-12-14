//
//  attendee.howitworks.explain.mechanics.view.swift
//  MrArthur
//
//  Created by IPS-169 on 31/08/22.
//

import SwiftUI

struct AttendeeHowItWorksExplainMechanics: View {
    var body: some View {
        VStack(spacing: 0){
            Image("AttendeeExplainMechanics")
                .resizable()
                .scaledToFit()
                .padding(.top, 65.h + statusBarHeight)
                .padding(.horizontal, 67.w)
                .padding(.bottom, 54.h)
                .frame(
                    width: UIScreen.screenWidth,
                    height: ScreenUtils.heightByScreenPercent(50)
                )
                .background(Color.secondaryRed)
            
            ManifestoTextContainerView {
                Group{
                    Text("Let me explain you ".localized)
                        .fontModifier(font: .montserratRegular,
                                      size: iPhoneFont25,
                                      color: .primaryBlue
                        )
                    +
                    Text("\n")
                    +
                    Text("how the ".localized)
                        .fontModifier(font: .montserratRegular,
                                      size: iPhoneFont25,
                                      color: .primaryBlue
                        )
                    +
                    Text("mechanics ".localized)
                        .fontModifier(font: .montserratBlack,
                                      size: iPhoneFont25,
                                      color: .primaryRed
                        ) +
                    Text("works.".localized)
                        .fontModifier(font: .montserratRegular,
                                      size: iPhoneFont25,
                                      color: .primaryBlue
                        )
                }
                .multilineTextAlignment(.center)
            }
        }
        
    }
}

//struct AttendeeHowItWorksExplainMechanics_Previews: PreviewProvider {
//    static var previews: some View {
//        AttendeeHowItWorksExplainMechanics()
//            .multiPreview
//    }
//}
