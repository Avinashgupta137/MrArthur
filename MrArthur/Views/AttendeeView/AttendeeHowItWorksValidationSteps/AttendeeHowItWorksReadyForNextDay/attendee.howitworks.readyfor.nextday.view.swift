//
//  attendee.howitworks.readyfor.nextday.view.swift
//  MrArthur
//
//  Created by IPS-169 on 01/09/22.
//

import SwiftUI

struct AttendeeHowItWorksReadyForNextDay: View {
    var body: some View {
        VStack(spacing: 0){
            Image("AttendeeReadyForNextDay")
                .resizable()
                .scaledToFit()
                .padding(.top, 55.h + statusBarHeight)
                .padding(.horizontal, 60.w)
                .padding(.bottom, 46.h)
                .frame(
                    width: UIScreen.screenWidth,
                    height: ScreenUtils.heightByScreenPercent(50)
                )
                .background(Color.secondaryRed)
            Group{
                Text("At the end of the day if you still have entertainment time left you will have an ".localized)
                    .fontModifier(
                        font: .montserratRegular,
                        size: iPhoneFont25,
                        color: .primaryBlue
                    )
                +
                Text("advance of 50% ".localized)
                    .fontModifier(
                        font: .montserratBlack,
                        size: iPhoneFont25,
                        color: .primaryRed
                    )
                +
                Text("of that time to start the next day !".localized)
                    .fontModifier(
                        font: .montserratRegular,
                        size: iPhoneFont25,
                        color: .primaryBlue
                    )
            }
            .multilineTextAlignment(.center)
            .padding(.top, 50)
            .padding(.horizontal, 20.h)
        }
    }
}
