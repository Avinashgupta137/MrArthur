//
//  observer.dashboard.notify.received.gaol.card.view.swift
//  MrArthur
//
//  Created by trootech on 13/09/22.
//

import SwiftUI

struct OBSReceivedGaolCardView: View {
    let notificationDate: String
    var color: Color = .primaryRed
    
    @State private var strDate: String = "EEEE dd MMM"
    var body: some View {
        NotificationBorderView(color:color) {
            VStack(alignment: .leading, spacing: 0) {
                Text(strDate)
                    .fontModifier(
                        font: .montserratRegular,
                        size: iPhoneFont13,
                        color: .primaryBlue
                    )
                    .padding(.bottom, 8.h)
                
                Group {
                    Text("Your child has".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont15,
                            color: .primaryBlue
                        )
                    +
                    Text(" 24 hours ".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont15,
                            color: color
                        )
                    +
                    Text("to send you his goal. Make sure to follow up!".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont15,
                            color: .primaryBlue
                        )
                }
                .padding(.trailing, 64.w)
                
                HStack(alignment: .top, spacing: 0){
                    Text("You’ll be notified as your joint efforts progress.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont15,
                            color: .primaryBlue
                        )
                    Spacer()
                    Image("DashboardNotificationSandtimer")
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: 41.w,
                            height: 65.h
                        )
                        .padding(.trailing, 24.w)
                        .padding(.bottom, 12.w)
                }
                
            }
            .padding(.leading, 24.w)
        }
        .onAppear {
            self.strDate = DateService.shared
                .getEEEE_dd_MMMMStringDateFromDateString(
                    dateString: notificationDate
                )
        }
    }
}

//struct OBSReceivedGaolCardViewPreviews: PreviewProvider {
//    static var previews: some View {
//        OBSReceivedGaolCardView(
//            notificationDate: "01/01/2022"
//        )
//        .padding(24.r)
//        .multiPreview
//    }
//}
