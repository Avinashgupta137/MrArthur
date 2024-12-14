//
//  attendee.howitworks.look.atdashboard.view.swift
//  MrArthur
//
//  Created by IPS-169 on 01/09/22.
//

import SwiftUI

struct AttendeeHowItWorksLookAtDashboard: View {
    var bottomPadding: CGFloat = 16
    var imageHeightRatio: CGFloat = 0.40
    var body: some View {
        VStack{
            Image("LookAtYourDashboard")
                .resizable()
                .scaledToFit()
                .frame(
                    width: 337.w,
                    height: 358.42.h
                )
                .padding(.bottom, 40.h)
                .padding(.top, 102.h + statusBarHeight)
            Text("Look at your dashboard to know where you’re at and see goals and special bonuses to win !".localized)
                .fontModifier(
                    font: .montserratRegular,
                    size: iPhoneFont25,
                    color: .primaryBlue
                )
                .multilineTextAlignment(.center)
                .padding(.horizontal, 60.w)
            Spacer(minLength: 16.h)
        }
        .frame(width: UIScreen.screenWidth)
        .background(Color.secondaryRed)
    }
}

//struct AttendeeHowItWorksLookAtDashboard_Previews: PreviewProvider {
//    static var previews: some View {
//        AttendeeHowItWorksLookAtDashboard()
//            .multiPreview
//    }
//}
