//
//  attendeeDashboardCreateMyGoalView.swift
//  MrArthur
//
//  Created by Troo on 01/08/22.
//

import SwiftUI

struct AttendeeDashboardCreateMyGoalCardView: View {
    let notificationDate: String
    var color: Color = .primaryRed
    let action: () -> ()
    
    @State private var strDate: String = "EEEE dd MMM"
    var body: some View {
        NotificationBorderView(color: color) {
            ZStack(alignment: .trailing){
                VStack(alignment: .leading, spacing: 0) {
                    Group {
                        Text(strDate)
                            .fontModifier(
                                font: .montserratRegular,
                                size: iPhoneFont13,
                                color: .primaryBlue
                            )
                            .padding(.bottom, 5.h)
                        
                        Group {
                            Text("You have 24 hours ".localized)
                                .fontModifier(
                                    font: .montserratBlack,
                                    size: iPhoneFont15,
                                    color: .primaryRed
                                )
                            +
                            Text("to provide ".localized)
                                .fontModifier(
                                    font: .montserratRegular,
                                    size: iPhoneFont15,
                                    color: .primaryBlue
                                )
                        }
                        .padding(.bottom, 5.h)
                        
                        Text("your parents with a goal.".localized)
                            .fontModifier(
                                font: .montserratRegular,
                                size: iPhoneFont15,
                                color: .primaryBlue
                            )
                            .padding(.bottom, 18.h)
                    }
                    .padding(.leading, 27.w)
                    
                    HStack(spacing: 0){
                        Button {
                            AmplitudeService.sendEvent(
                                key: .ATT_CO_1_CREATE_GOAL
                            )
                            action()
                        } label: {
                            Text("CREATE MY GOAL".localized)
                                .fontModifier(
                                    font: .montserratBlack,
                                    size: iPhoneFont15
                                )
                                .frame(
                                    width: 203.w,
                                    height: 60.h
                                )
                                .background(
                                    Color.primaryBlue
                                        .cornerRadius(50)
                                )
                        }
                        .padding(.leading, 14.w)
                        
                        Spacer()
                    }
                }
                
                Image("DashboardNotificationHand")
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: 140.w
                    )
            }
            .padding(.vertical, 10.h)
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
struct AttendeeDashboardCreateMyGoalCardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            Spacer()
            AttendeeDashboardCreateMyGoalCardView(
                notificationDate: "17/09/2022",
                action: {}
            )
            .padding()
            Spacer()
        }
        .multiPreview
    }
}*/
