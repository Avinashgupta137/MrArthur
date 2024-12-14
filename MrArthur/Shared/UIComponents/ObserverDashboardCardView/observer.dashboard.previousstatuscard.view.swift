//
//  observer.dashboard.previousstatuscard.view.swift
//  MrArthur
//
//  Created by Nirav Patel on 16/11/22.
//

import SwiftUI

struct ObserverDashboardPreviousStatusCardView: View {
    let notificationDate: String
    let statusDate: String = "Sunday 06 june"
    @State private var strDate: String = "EEEE dd MMM"
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(strDate)
                .fontModifier(
                    font: .montserratRegular,
                    size: iPhoneFont13,
                    color: .primaryBlue.opacity(0.45)
                )
                .padding(.bottom, 8.resizable)
            
            Text("The goal is on its way!".localized)
                .fontModifier(
                    font: .montserratRegular,
                    size: iPhoneFont15,
                    color: .primaryBlue.opacity(0.45)
                )
            
            Text("Now it’s your turn to consider the proposal and decide whether you agree with it or not.".localized)
                .fontModifier(
                    font: .montserratRegular,
                    size: iPhoneFont15,
                    color: .primaryBlue.opacity(0.45)
                )
        }
        .padding(24.r)
        .frame(width: UIScreen.screenWidth - 48, alignment: .leading)
        .background(Color.secondaryRed.cornerRadius(24.r))
        .onAppear {
            self.strDate = DateService.shared
                .getEEEE_dd_MMMMStringDateFromDateString(
                    dateString: notificationDate
                )
        }
    }
    
}
