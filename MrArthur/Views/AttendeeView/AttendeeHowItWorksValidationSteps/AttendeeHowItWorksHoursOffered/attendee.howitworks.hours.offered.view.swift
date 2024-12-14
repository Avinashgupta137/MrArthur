//
//  attendee.howitworks.hours.offered.view.swift
//  MrArthur
//
//  Created by IPS-169 on 31/08/22.
//

import SwiftUI

struct AttendeeHowItWorksHoursOffered: View {
    var body: some View {
        VStack(spacing: 0){
            Image("Attendee2HoursOffered")
                .resizable()
                .scaledToFit()
                .padding(.top, 78.h + statusBarHeight)
                .padding(.horizontal, 48.w)
                .padding(.bottom, 33.h)
                .frame(
                    width: UIScreen.screenWidth,
                    height: ScreenUtils.heightByScreenPercent(50)
                )
                .background(Color.secondaryRed)
            
            ManifestoTextContainerView {
                Group{
                    Text("You start with ".localized)
                        .fontModifier(font: .montserratRegular,
                                      size: iPhoneFont25,
                                      kerning: 0,
                                      color: .primaryBlue
                        )
                    +
                    Text("2 free ".localized)
                        .fontModifier(font: .montserratBlack,
                                      size: iPhoneFont25,
                                      kerning: 0,
                                      color: .primaryRed
                        )
                }
                .multilineTextAlignment(.center)
                .padding(.horizontal,30)
                Group{
                    Text("hours ".localized)
                        .fontModifier(font: .montserratBlack,
                                      size: iPhoneFont25,
                                      kerning: 0,
                                      color: .primaryRed
                        )
                    
                    +
                    Text("of entertainment as a gift for your engagement".localized)
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

