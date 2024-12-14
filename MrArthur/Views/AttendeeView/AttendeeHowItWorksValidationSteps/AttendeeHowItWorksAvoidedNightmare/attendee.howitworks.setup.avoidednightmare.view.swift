//
//  att.howitworks.setup.view.swift
//  MrArthur
//
//  Created by IPS-169 on 31/08/22.
//

import SwiftUI

struct AttendeeHowItWorksAvoidedNightmareView: View {
    var body: some View {
        VStack(spacing: 0){
            Image("AttendeeAvoidedNightmare")
                .resizable()
                .padding(.top, 150.h + statusBarHeight)
                .padding(.horizontal, 41.w)
                .padding(.bottom, 60.h)
                .frame(
                    width: UIScreen.screenWidth,
                    height: ScreenUtils.heightByScreenPercent(50)
                )
                .background(Color.secondaryRed)
            
            ManifestoTextContainerView {
                Text("Congrats kid".localized)
                    .fontModifier(
                        font: .montserratBlack,
                        size: iPhoneFont25,
                        kerning: 0,
                        color: .primaryRed
                    )
                    .multilineTextAlignment(.center)
                Text("you just avoided a nightmare. No parent’s tyrannie, everything will be fine now…".localized)
                    .fontModifier(
                        font: .montserratRegular,
                        size: iPhoneFont25,
                        kerning: 0,
                        color: .primaryBlue
                    )
                    .multilineTextAlignment(.center)
            }
        }
    }
}

//struct AttendeeHowItWorksAvoidedNightmareView_Previews: PreviewProvider {
//    static var previews: some View {
//        AttendeeHowItWorksAvoidedNightmareView()
//            .multiPreview
//    }
//}
