//
//  AttendeeDashboardLetsGetStartedCardView.swift
//  MrArthur
//
//  Created by Troo on 02/08/22.
//

import SwiftUI

struct AttendeeDashboardLetsGetStartedCardView: View {
    let color: Color = .validateGreen
    let notificationDate: String
    @State var howItworkSetup = false
    @State private var strDate: String = "EEEE dd MMM"
    @EnvironmentObject private var rootViewObserver: RootViewObserver
    var body: some View {
        NotificationBorderView(color: color) {
            VStack(alignment: .leading, spacing: 0) {
                Group {
                    Text(strDate)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont13,
                            color: .primaryBlue
                        )
                        .padding(.bottom, 8.h)
                    
                    Text("Your parents have confirmed your goal!".localized)
                        .fontModifier(
                            font: .montserratBlack,
                            size: iPhoneFont15,
                            color: color
                        )
                    
                    Text("You should be very proud of yourself because setting goals is already an achievement.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont15,
                            color: .primaryBlue
                        )
                }
                .padding(.leading, 27.w)
                
                HStack{
                    Button {
                        AmplitudeService.sendEvent(
                            key: .ATT_CO_6_LETS_GET_STARTED
                        )
                        rootViewObserver.currentPage = .attendeeHowItsWorkValidation
                    } label: {
                        Text("LET’S GET STARTED!".localized)
                            .fontModifier(
                                font: .montserratBlack,
                                size: iPhoneFont15
                            )
                            .frame(width: 224.w, height: 60.h)
                            .background(Color.primaryBlue.cornerRadius(34.r))
                    }
                    .contentShape(Rectangle())
                    Spacer()
                    Image("DashboardNotificationSuccess")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 108.w, height: 105.h)
                    
                    Spacer()
                }
                .padding(.leading, 11.w)
            }
        }
        .onAppear {
            self.strDate = DateService.shared
                .getEEEE_dd_MMMMStringDateFromDateString(
                    dateString: notificationDate
                )
        }
    }
}

/*
struct AttendeeDashboardLetsGetStartedCardView_Previews: PreviewProvider {
    static var previews: some View {
        AttendeeDashboardLetsGetStartedCardView(notificationDate: "11/11/2011")
            .padding()
    }
}*/
