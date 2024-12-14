//
//  ManifestoMrArthurWillMakeYouSmart.swift
//  MrArthur
//
//  Created by IPS-157 on 01/08/22.
//

import SwiftUI

struct ManifestoMrArthurWillMakeYouSmart: View {
    
    var body: some View {
        VStack(spacing: 0){
          
            Image("stepOnboardingAttendeeManifestoMrArthurWillMakeYouSmart")
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
                            size:  iPhoneFont25,
                            color: .primaryRed
                        )
                    +
                    Text("also wants you to make the most of digital content to stay informed and learn new things.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont25,
                            color: .primaryBlue
                        )
                }
                .multilineTextAlignment(.center)
                .padding(.horizontal, 8.w)
            }
            
        }
    }
}

//struct ManifestoMrArthurWillMakeYouSmart_Previews: PreviewProvider {
//    static var previews: some View {
//        ManifestoMrArthurWillMakeYouSmart()
//            .multiPreview
//    }
//}
