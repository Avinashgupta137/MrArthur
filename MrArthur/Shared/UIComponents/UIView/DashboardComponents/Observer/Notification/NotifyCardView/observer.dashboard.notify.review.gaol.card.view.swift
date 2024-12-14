//
//  observer.dashboard.notify.review.gaol.card.view.swift
//  MrArthur
//
//  Created by trootech on 14/09/22.
//

import SwiftUI

struct OBSDashboardReviewGaolCardView: View {
    let notificationDate: String
    var color: Color = .primaryYellow
    let onSeeGoal: () -> ()
    
    @State private var strDate: String = "EEEE dd MMM"
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
                    
                    Text("The goal is on its way!".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont15,
                            color: color
                        )
                    
                    Text("Now it’s your turn to consider the proposal and decide whether you agree with it or not.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont15,
                            color: .primaryBlue
                        )
                }
                .padding(.leading, 28.w)
                
                HStack(spacing: 0) {
                    
                    BlueRoundedButton(
                        "SEE CHILD’S GOAL",
                        width: 224.18
                    ) {
                        onSeeGoal()
                    }
                    .padding(.trailing, 12.w)
                    
                    Image("DashboardNotificationMessage")
                        .resizable()
                        .scaledToFit()
                        .frame(
                            height: 83.h
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
struct OBSDashboardOngoingGaolCardViewPreview: PreviewProvider {
    static var previews: some View {
        OBSDashboardReviewGaolCardView(
            notificationDate: "17/09/2022",
            onSeeGoal: {}
        )
            .padding(24.r)
            .multiPreview
    }
}*/
