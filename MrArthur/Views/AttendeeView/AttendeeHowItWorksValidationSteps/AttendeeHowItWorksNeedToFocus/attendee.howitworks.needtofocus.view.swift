//
//  attendee.how.it.works.needtofocus.view.swift
//  MrArthur
//
//  Created by IPS-169 on 31/08/22.
//

import SwiftUI

struct AttendeeHowItWorksNeedToFocus: View {
    var body: some View {
        VStack(spacing: 0){
            Image("AttendeeNeedToFocus")
                .resizable()
                .scaledToFit()
                .padding(.top, 110.h + statusBarHeight)
                .padding(.horizontal, 58.w)
                .padding(.bottom, 70.h)
                .frame(
                    width: UIScreen.screenWidth,
                    height: ScreenUtils.heightByScreenPercent(50)
                )
                .background(Color.secondaryRed)
             
            ManifestoTextContainerView {
                Group{
                    Text("You have to spend ".localized)
                        .fontModifier(font: .montserratRegular,
                                      size: iPhoneFont25,
                                      kerning: 0,
                                      color: .primaryBlue
                        )
                    +
                    Text("a minimum of 5 minutes ".localized)
                        .fontModifier(font: .montserratBlack,
                                      size: iPhoneFont25,
                                      kerning: 0,
                                      color: .primaryRed
                        )
                    +
                    Text("on educational apps otherwise it won’t be credited, we need you focused !".localized)
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

//struct AttendeeHowItWorksNeedToFocus_Previews: PreviewProvider {
//    static var previews: some View {
//        AttendeeHowItWorksNeedToFocus()
//            .multiPreview
//    }
//}
