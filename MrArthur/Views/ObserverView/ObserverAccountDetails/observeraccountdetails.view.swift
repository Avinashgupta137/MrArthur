//
//  ObserverAccountDetails.swift
//  MrArthur
//
//  Created by IPS-157 on 08/08/22.
//

import SwiftUI

struct ObserverAccountDetails: View {
    @StateObject var observed = Observed()
    @State var showObserverAccount = false
    let email = UtilityMethod().getValueForKey(key: ConstantOfApp.kEmailId) as? String ?? ""
    var body: some View {
        VStack(alignment: .leading, spacing: 22.h) {
            Button {
                AmplitudeService.sendEvent(
                    key: .OBS_PLUS_3_ACCOUNT_DETAILS
                )
                self.showObserverAccount = true
            } label: {
                HStack(spacing: 0){
                    VStack(alignment: .leading, spacing: 3.h){
                        Text("ACCOUNT ID".localized)
                            .fontModifier(
                                font: .montserratRegular,
                                size: iPhoneFont18,
                                color: .secondaryBlue
                            )
                        Text(email)
                            .fontModifier(
                                font: .montserratBold,
                                size: iPhoneFont18,
                                color: .secondaryBlue
                            )
                    }
                    Spacer(minLength: 16.w)
                    Image(systemName: "chevron.forward")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.secondaryBlue)
                        .frame(width: 25.r, height: 25.r)
                }
            }
            
            Rectangle()
                .fill(Color.thirdRed)
                .frame(height: isiPad() ? 2 : 1)
                .padding(.bottom, 10.resizable)
            
            Spacer(minLength: 16.h)
            
            NavigationLink(
                "", destination:
                    ObserverAccountInDetails(
                        noOfDevice: $observed.numberOfDevices,
                        noOfChild: $observed.numberOfChild
                    ),
                isActive: $showObserverAccount
            )
            
        }
        .padding(.horizontal, 24.w)
        .padding(.vertical, 34.h)
        
        .customNavigationViewWithBackWidgit(
            title: "Account".localized,
            color: .whiteColor
        )
        .background(
            LinearGradient(
                colors: [
                    Color.lightPink,
                    Color.secondaryRed
                ],
                startPoint: .top,
                endPoint: .bottomTrailing)
        )
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct ObserverAccountDetails_Previews: PreviewProvider {
    static var previews: some View {
        ObserverAccountDetails()
    }
}
//
