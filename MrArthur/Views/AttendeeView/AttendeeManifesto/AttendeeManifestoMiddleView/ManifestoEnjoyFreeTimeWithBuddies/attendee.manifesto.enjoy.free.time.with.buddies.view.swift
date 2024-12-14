//
//  ManifestoEnjoyFreeTimeWithBuddies.swift
//  MrArthur
//
//  Created by IPS-157 on 01/08/22.
//

import SwiftUI

struct ManifestoEnjoyFreeTimeWithBuddies: View {
    var body: some View {
        ZStack {
            Image("stepOnboardingAttendeeManifestoEnjoyFreeTimeWithBuddies")
                .resizable()
                .scaledToFit()
                
            Text("Of course, you can also spend the free time you earn with friends!".localized)
                .fontModifier(
                    font: .montserratRegular,
                    size: iPhoneFont25,
                    color: .white
                )
                .multilineTextAlignment(.center)
        }
        .padding(.top, statusBarHeight + 44.h)
        .padding(.bottom, 150.h)
        .padding(.horizontal, 34.w)
        .frame(width: UIScreen.screenWidth)
        .background(
            LinearGradient(
                colors: [
                    Color.primaryRed,
                    Color.thirdRed
                ],
                startPoint: .top,
                endPoint: .bottomTrailing
            )
        )
    }
}

//struct ManifestoEnjoyFreeTimeWithBuddies_Previews: PreviewProvider {
//    static var previews: some View {
//        ManifestoEnjoyFreeTimeWithBuddies()
//            .multiPreview
//    }
//}
