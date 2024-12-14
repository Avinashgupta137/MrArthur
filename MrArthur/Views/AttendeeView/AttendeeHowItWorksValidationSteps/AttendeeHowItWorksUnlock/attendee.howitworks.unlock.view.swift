//
//  attendee.howitworks.unlock.view.swift
//  MrArthur
//
//  Created by IPS-169 on 31/08/22.
//

import SwiftUI

struct AttendeeHowItWorksUnlock: View {
    var body: some View {
        VStack(spacing: 0){
            Image("AttendeeSpendTimeToUnlock")
                .resizable()
                .scaledToFit()
                .padding(.top, 60.h + statusBarHeight)
                .padding(.horizontal, 92.w)
                .padding(.bottom, 37.h)
                .frame(
                    width: UIScreen.screenWidth,
                    height: ScreenUtils.heightByScreenPercent(50)
                )
                .background(Color.secondaryRed)
             
            ManifestoTextContainerView {
                Group{
                    Text("Just spend some time on those apps and you ".localized)
                        .fontModifier(font: .montserratRegular,
                                      size: iPhoneFont25,
                                      kerning: 0,
                                      color: .primaryBlue
                        )
                    +
                    Text("unlock entertainment ".localized)
                        .fontModifier(font: .montserratBlack,
                                      size: iPhoneFont25,
                                      kerning: 0,
                                      color: .primaryRed
                        )
                    +
                    Text("in real time.".localized)
                        .fontModifier(font: .montserratRegular,
                                      size: iPhoneFont25,
                                      kerning: 0,
                                      color: .primaryBlue
                        )
                }
                .multilineTextAlignment(.center)
            }
        }
    }
    
}

//struct AttendeeHowItWorksUnlock_Previews: PreviewProvider {
//    static var previews: some View {
//        AttendeeHowItWorksUnlock()
//            .multiPreview
//    }
//}
