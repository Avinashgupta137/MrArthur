//
//  ManifestoMrArthurIsaNurse.swift
//  MrArthur
//
//  Created by IPS-157 on 01/08/22.
//

import SwiftUI

struct ManifestoMrArthurIsaNurse: View {
    var body: some View {
        VStack(spacing: 0){
            
            Image("stepOnboardingAttendeeManifestoMrArthurIsANurse")
                .resizable()
                .scaledToFit()
                .padding(.top, statusBarHeight + 45.h)
                .padding(.bottom, 68.r)
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
                    Text("is on your side! First, we analyse your screen time usage, and then we make a sensible proposal to your parents!".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size:  iPhoneFont25,
                            color: .primaryBlue
                        )
                }
                .multilineTextAlignment(.center)
                .padding(.horizontal, 8.w)
            }
        }
        
    }
}

//struct ManifestoMrArthurIsaNurse_Previews: PreviewProvider {
//    static var previews: some View {
//        ManifestoMrArthurIsaNurse()
//            .multiPreview
//    }
//}
