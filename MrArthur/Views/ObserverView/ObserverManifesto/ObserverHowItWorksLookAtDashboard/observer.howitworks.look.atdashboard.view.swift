//
//  attendee.howitworks.look.atdashboard.view.swift
//  MrArthur
//
//  Created by IPS-169 on 01/09/22.
//

import SwiftUI

struct ObserverHowItWorksLookAtDashboard: View {
    
    @EnvironmentObject private var rootViewObserver: RootViewObserver
    
    var body: some View {
        VStack(spacing: 0){
           
            Spacer(minLength: 24.h)
            
            Image("LookAtYourDashboard")
                .resizable()
                .scaledToFit()
                .frame(
                    width: 337.w,
                    height: 358.42.h
                )
                .padding(.bottom, 39.h)
            
            Text("Look at your dashboard to follow your child’s progress.".localized)
                .fontModifier(
                    font: .montserratRegular,
                    size: iPhoneFont25,
                    color: .primaryBlue
                )
                .multilineTextAlignment(.center)
            
            Spacer(minLength: 24.h)
            
            BlueRoundedButton("OK!") {
                if let attendee = UserDefaultsHelper.selectedAttendee {
                    if let uuid = attendee.uuid {
                        UserDefaultsHelper.setAttendeeScreenTimeFlag(uuid: uuid)
                        AppState.shared.attendeeMediationCompletedOBS = UserDefaultsHelper.getAttendeeScreenTimeFlag(uuid: uuid)
                    }
                    UserDefaultsHelper.selectedAttendee = attendee
                    rootViewObserver.currentPage = .observerTabBar
                    AmplitudeService.sendEvent(
                        key: .OBS_HOW_IT_WORKS_2_11_OK
                    )
                }
            }
        }
        .padding(.vertical, 34.h)
        .padding(.horizontal, 44.w)
        .hideNavigation
        .background(Color.paringSetupBackground)
    }
}


struct ObserverHowItWorksLookAtDashboard_Previews: PreviewProvider {
    static var previews: some View {
        ObserverHowItWorksLookAtDashboard()
        .multiPreview
    }
}
