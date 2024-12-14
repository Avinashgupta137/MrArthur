//
//  AttendeeDashboardPreviousStatusCardView.swift
//  MrArthur
//
//  Created by Troo on 02/08/22.
//

import SwiftUI

struct AttendeeDashboardPreviousStatusCardView: View {
    let notificationDate: String
    let statusDate: String = "Sunday 06 june"
    let cardTitle : String
    let cardMessage : String
    @State private var strDate: String = "EEEE dd MMM"
    var body: some View {
        VStack(alignment: .leading, spacing: 2.h) {
            HStack(spacing: 0){
                Text(strDate)
                    .fontModifier(
                        font: .montserratRegular,
                        size: iPhoneFont13,
                        color: .primaryBlue
                    )
                Spacer()
            }
            .padding(.bottom, 8.h)
            Group{
                Text(cardTitle.localized)
                    .fontModifier(
                        font: .montserratRegular,
                        size: iPhoneFont15,
                        color: .primaryBlue
                    )
                
                Text(cardMessage.localized)
                    .fontModifier(
                        font: .montserratRegular,
                        size: iPhoneFont15,
                        color: .primaryBlue
                    )
            }
        }
        .padding(.horizontal, 20.w)
        .padding(.vertical, 14.h)
        .opacity(0.45)
        .background(Color.secondaryRed.cornerRadius(28.r))
        .onAppear {
            self.strDate = DateService.shared
                .getEEEE_dd_MMMMStringDateFromDateString(
                    dateString: notificationDate
                )
        }
    }
    
}
