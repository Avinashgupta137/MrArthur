//
//  observer.dashboard.notify.accepted.gaol.card.view.swift
//  MrArthur
//
//  Created by trootech on 14/09/22.
//

import SwiftUI

struct OBSDashboardAcceptedGaolCardView: View {
    let notificationDate: String
    var color: Color = .validateGreen
    let onSeeMore: () -> ()
    @State var showGoalSummary = false
    @State private var strDate: String = "EEEE dd MMM"
    @EnvironmentObject private var rootViewObserver: RootViewObserver
    var body: some View {
        NotificationBorderView(color:color) {
            VStack(alignment: .leading, spacing: 0) {
                Group {
                    Text(strDate)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont13,
                            color: .primaryBlue
                        )
                        .padding(.bottom, 8.h)
                    
                    Text("You have accepted the goal! ".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont15,
                            color: color
                        )
                    Text("Your child can start achieving it, and you can follow his progress.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont15,
                            color: .primaryBlue
                        )
                }
                .padding(.leading, 28.w)
                
                HStack(spacing: 0) {
                    BlueRoundedButton("SEE MORE", width: 224.18) {
                        AmplitudeService.sendEvent(
                            key: .OBS_CO_4_SEE_MORE
                        )
                        rootViewObserver.currentPage = .mediationApproved
                    }
                    .padding(.trailing, 12.w)
                    
                    Image("DashboardNotificationSuccess")
                        .resizable()
                        .scaledToFit()
                        .frame(
                            height: 104.h
                        )
                    
                    Spacer(minLength: 12.w)
                }
                .padding(.leading, 16.w)
            }
            .padding(.trailing, 16.w)
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
struct OBSDashboardAcceptedGaolCardViewPreview: PreviewProvider {
    static var previews: some View {
        OBSDashboardAcceptedGaolCardView(
            notificationDate: "17/09/2022",
            onSeeMore: {}
        )
            .padding(24.r)
            .multiPreview
    }
}*/
