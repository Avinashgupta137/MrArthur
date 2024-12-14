//
//  ManifestoMrArthurIsYourFriend.swift
//  MrArthur
//
//  Created by IPS-169 on 29/07/22.
//

import SwiftUI

struct ManifestoMrArthurIsYourFriend: View {
    @StateObject private var  observed = Observed()
    var body: some View {
        VStack(spacing: 0){
           
            Image("stepOnboardingAttendeeManifestoMrArthurIsYourFriend")
                .resizable()
                .scaledToFit()
                .padding(.top, statusBarHeight + 53.h)
                .frame(
                    width: UIScreen.screenWidth,
                    height: ScreenUtils.heightByScreenPercent(50)
                )
                .background(Color.secondaryRed)
            
            ManifestoTextContainerView {
                Group {
                    Text("mr.arthur is here to help you. ".localized)
                        .fontModifier(
                            font: .montserratBlack,
                            size:  iPhoneFont25,
                            color: .primaryRed
                        )
                    +
                    Text("He’ll do everything he can to stop your parents from taking away your phone and screens.".localized)
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

//struct ManifestoMrArthurIsYourFriend_Previews: PreviewProvider {
//    static var previews: some View {
//        ManifestoMrArthurIsYourFriend()
//            .multiPreview
//    }
//}
