//
//  attendee.howitworks.parent.educ.swift
//  MrArthur
//
//  Created by IPS-169 on 31/08/22.
//

import SwiftUI

struct AttendeeHowItWorksParentEduc: View {
    var body: some View {
        VStack(spacing: 0){
            Image(UtilityMethod.isFrench ? "AttendeeParentsInstallEducAppsFrench" : "AttendeeParentsInstallEducApps")
                .resizable()
                .scaledToFit()
                .padding(.top, 98.h + statusBarHeight)
                .padding(.horizontal, 20.w)
                .padding(.bottom, 75.h)
                .frame(
                    width: UIScreen.screenWidth,
                    height: ScreenUtils.heightByScreenPercent(50)
                )
                .background(Color.secondaryRed)
            
            ManifestoTextContainerView {
                Group{
                    Text("Your parents have installed ".localized)
                        .fontModifier(font: .montserratRegular,
                                      size: iPhoneFont25,
                                      kerning: 0,
                                      color: .primaryBlue
                        )
                    +
                    Text("fun and engaging ".localized)
                        .fontModifier(font: .montserratRegular,
                                      size: iPhoneFont25,
                                      kerning: 0,
                                      color: .primaryBlue
                        )
                    +
                    Text("educational apps ".localized)
                        .fontModifier(font: .montserratBlack,
                                      size: iPhoneFont25,
                                      kerning: 0,
                                      color: .primaryRed
                        )
                    +
                    Text("on your phone/tablet.".localized)
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


//struct AttendeeHowItWorksParentEduc_Previews: PreviewProvider {
//    static var previews: some View {
//        AttendeeHowItWorksParentEduc()
//            .multiPreview
//    }
//}
