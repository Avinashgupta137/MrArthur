//
//  attendeeDashboardSeeMyGoalCardView.swift
//  MrArthur
//
//  Created by Troo on 01/08/22.
//

import SwiftUI

struct AttendeeDashboardSeeMyGoalCardView: View {
    let notificationDate: String
    var color: Color = .primaryOrange
    let action: () -> ()
    
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
                        
                        Text("Congratulations".localized)
                            .fontModifier(
                                font: .montserratBlack,
                                size: iPhoneFont15,
                                color: .primaryOrange
                            )
                        +
                        Text("!".localized)
                            .fontModifier(
                                font: .montserratRegular,
                                size: iPhoneFont15,
                                color: .primaryBlue
                            )
                        Text("You’ve just sent your parents your first goal. It’s time for them to review your proposal. They’ll send you their answer here!".localized)
                            .fontModifier(
                                font: .montserratRegular,
                                size: iPhoneFont15,
                                color: .primaryBlue
                            )
                    }
                    .padding(.leading, 27.w)
                    
                    HStack(spacing: 0) {
                        Button {
                            AmplitudeService.sendEvent(
                                key: .ATT_CO_5_SEE_MY_GOAL
                            )
                            action()
                        } label: {
                            Text("SEE MY GOAL".localized)
                                .fontModifier(
                                    font: .montserratBlack,
                                    size: iPhoneFont15
                                )
                                .frame(width: 185.w, height: 60.h)
                                .background(
                                    Color.primaryBlue
                                        .cornerRadius(43.r)
                                )
                        }
                        
                        Spacer(minLength: 16.w)
                        
                        Image("DashboardNotificationMessage")
                            .resizable()
                            .scaledToFit()
                            .frame(
                                width: 150.w
                            )
                    }
                    .padding([.leading, .top], 16.r)
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
struct AttendeeDashboardSeeMyGoalCardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 0){
            Spacer()
            AttendeeDashboardSeeMyGoalCardView(
                notificationDate: "17/09/2022",
                action: {}
            )
            
            AttendeeDashboardPreviousStatusCardView(
                notificationDate: "17/09/2022"
            )
            
            Spacer()
        }
        .padding()
        .multiPreview
    }
}*/
