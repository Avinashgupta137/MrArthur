//
//  attendee.howitorks.attendee.minadvance.view.swift
//  MrArthur
//
//  Created by IPS-169 on 01/09/22.
//

import SwiftUI

struct AttendeeHowItWorksAttendeeMinadvance: View {
    var body: some View {
        VStack(spacing: 0){
            Image("Attendee30MinAdvance")
                .resizable()
                .scaledToFit()
                .padding(.top, 140.h + statusBarHeight)
                .padding(.horizontal, 60.w)
                .padding(.bottom, 94.h)
                .frame(
                    width: UIScreen.screenWidth,
                    height: ScreenUtils.heightByScreenPercent(50)
                )
                .background(Color.secondaryRed)
            
            ManifestoTextContainerView {
                Group{
                    Text("each day at 6 am you start with an “advance” of ".localized)
                        .fontModifier(font: .montserratRegular,
                                      size: iPhoneFont25,
                                      kerning: 0,
                                      color: .primaryBlue
                        )
                    +
                    Text("minimum 5 minutes ".localized)
                        .fontModifier(font: .montserratBlack,
                                      size: iPhoneFont25,
                                      kerning: 0,
                                      color: .primaryRed
                        )
                    +
                    Text("of entertainment time.".localized)
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


//struct AttendeeHowItWorksAttendeeMinadvance_Previews: PreviewProvider {
//    static var previews: some View {
//        AttendeeHowItWorksAttendeeMinadvance()
//            .multiPreview
//    }
//}
