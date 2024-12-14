//
//  ManifestoMrArthurWillEmpowerYou.swift
//  MrArthur
//
//  Created by IPS-157 on 01/08/22.
//

import SwiftUI

struct ManifestoMrArthurWillEmpowerYou: View {
    
    var body: some View {
        VStack(spacing: 0){
     
            Image("stepOnboardingAttendeeManifestoMrArthurWillEmpowerYou")
                .resizable()
                .padding(.top, statusBarHeight + 45.h)
                .padding([.bottom, .horizontal], 45.r)
                .frame(
                    width: UIScreen.screenWidth,
                    height: ScreenUtils.heightByScreenPercent(50)
                )
                .background(Color.secondaryRed)

            ManifestoTextContainerView {
                Group{
                    Text("mr.arthur ".localized)
                        .fontModifier(
                            font: .montserratBlack,
                            size: iPhoneFont25,
                            color: .primaryRed
                        )
                    +
                    Text("will help you suggest a more reasonable screen time to your parents.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size:  iPhoneFont25,
                            color: .primaryBlue
                        )
                }
                .padding(.bottom, 34.h)
                .padding(.horizontal, 8.h)
                
                Text("Don’t worry; your devices aren’t going anywhere ;)".localized)
                    .fontModifier(
                        font: .montserratRegular,
                        size: iPhoneFont25,
                        color: .primaryBlue
                    )
                    .padding(.horizontal, 8.h)

            }
            .multilineTextAlignment(.center)
        }
    }
}

//struct ManifestoMrArthurWillEmpowerYou_Previews: PreviewProvider {
//    static var previews: some View {
//        ManifestoMrArthurWillEmpowerYou()
//            .multiPreview
//    }
//}
