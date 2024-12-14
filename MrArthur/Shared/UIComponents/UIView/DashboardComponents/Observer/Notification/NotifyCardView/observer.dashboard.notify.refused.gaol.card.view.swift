//
//  observer.dashboard.notify.refused.gaol.card.view.swift
//  MrArthur
//
//  Created by trootech on 14/09/22.
//

import SwiftUI

struct OBSDashboardRefusedGaolCardView: View {
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
                
                Text("You have refused your child’s goal!".localized)
                    .fontModifier(
                        font: .montserratBold,
                        size: iPhoneFont15,
                        color: color
                    )
                
                Text("It didn’t go through, but we’re very close. Your child will be notified about your refusal".localized)
                    .fontModifier(
                        font: .montserratRegular,
                        size: iPhoneFont15,
                        color: .primaryBlue
                    )
                HStack(alignment: .top, spacing: 0) {
                    
                    Text("The new improved goal will show up here.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont15,
                            color: .primaryBlue
                        )
                    Spacer()
                    Image("DashboardNotificationImprove")
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: 77.r,
                            height: 77.r
                        )
                        .padding(.top, 24.h)
                }
                .padding(.trailing, 16.w)
                .padding(.bottom, 12.h)
            }
            .padding(.leading, 24.w)
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


//struct OBSDashboardAcceptedGaolCardViewPreview: PreviewProvider {
//    static var previews: some View {
//        VStack{
//            Spacer()
//            OBSDashboardRefusedGaolCardView(
//                notificationDate: "17/09/2022"
//            )
//            ObserverDashboardPreviousStatusCardView(notificationDate: "17/09/2022")
//            Spacer()
//        }
//            .padding(24.r)
//            .background(Color.validateGreen)
//            .multiPreview
//    }
//}
