//
//  attendeeDashboardICanDoBetterCardView.swift
//  MrArthur
//
//  Created by Troo on 02/08/22.
//

import SwiftUI

struct AttendeeDashboardICanDoBetterCardView: View {
    let color: Color = .primaryRed
    @State var isModifyGoal = false
    @State private var strDate: String = "EEEE dd MMM"
    let notificationDate: String
    var body: some View {
        NotificationBorderView(color: color) {
            ZStack() {
                VStack(alignment: .leading, spacing: 0) {
                    Group {
                        Text(strDate)
                            .fontModifier(
                                font: .montserratRegular,
                                size: iPhoneFont13,
                                color: .primaryBlue
                            )
                            .padding(.bottom, 8.h)
                        
                        Text("Your parents have refused your goal!".localized)
                            .fontModifier(
                                font: .montserratBlack,
                                size: iPhoneFont15,
                                color: color
                            )
                        
                        Text("It didn’t go through, but we’re very close. All you need to do is reduce your screen time a little more…".localized)
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
                                key: .ATT_CO_7_BIS_I_CAN_DO_BETTER
                            )
                            isModifyGoal = true
                        } label: {
                            Text("I CAN DO BETTER".localized)
                                .fontModifier(font: .montserratBlack, size: iPhoneFont15)
                                .frame(width: 224.w, height: 60.h)
                                .background(Color.primaryBlue.cornerRadius(34.r))
                        }
                        .contentShape(Rectangle())
                        Spacer()
                        Image("DashboardNotificationImprove")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 77.r, height: 77.r)
                    }
                    .padding([.leading, .top], 11.w)
                    
                }
                .padding(.trailing, 18.w)
                NavigationLink(
                    "",
                    destination: AttendeeModifyGoalView(),
                    isActive: $isModifyGoal
                )
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
struct AttendeeDashboardICanDoBetterCardView_Previews: PreviewProvider {
    static var previews: some View {
        AttendeeDashboardICanDoBetterCardView(notificationDate: "11/11/2011")
            .padding()
    }
}*/
