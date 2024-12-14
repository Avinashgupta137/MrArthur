//
//  ObserverAccountInDetails.swift
//  MrArthur
//
//  Created by IPS-157 on 08/08/22.
//

import SwiftUI

struct ObserverAccountInDetails: View {
    @EnvironmentObject private var loaderObserver: LoaderObserver
    @EnvironmentObject private var rootViewObserver: RootViewObserver
    @StateObject var observed = Observed()
    @Binding var noOfDevice : Int
    @Binding var noOfChild : Int
    @State var deleteAccount = false
    let email = UtilityMethod().getValueForKey(key: ConstantOfApp.kEmailId) as? String ?? ""
    
    var seprator: some View {
        Rectangle()
            .fill(Color.thirdRed)
            .frame(height: 1.h)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            
            Text("ACCOUNT ID".localized)
                .fontModifier(
                    font: .montserratBold,
                    size: iPhoneFont18,
                    color: .secondaryBlue
                )
            
            Text(email)
                .fontModifier(
                    font: .montserratRegular,
                    size: iPhoneFont18,
                    color: .secondaryBlue
                )
            
            seprator
                .padding(.vertical, 20.h)
            
            VStack(alignment: .leading, spacing: 5.h){
                Text("CHILDREN AND CONNECTED DEVICES".localized)
                    .fontModifier(
                        font: .montserratBold,
                        size: iPhoneFont18,
                        color: .secondaryBlue
                    )
                
                Text("\(noOfChild) ")
                    .fontModifier(
                        font: .montserratBold,
                        size: iPhoneFont18,
                        color: .secondaryBlue
                    )
                +
                Text("children".localized)
                    .fontModifier(
                        font: .montserratRegular,
                        size: iPhoneFont18,
                        color: .secondaryBlue
                    )
                 
                Text("\(noOfDevice) ")
                    .fontModifier(
                        font: .montserratBold,
                        size: iPhoneFont18,
                        color: .secondaryBlue
                    )
                +
                Text("devices".localized)
                    .fontModifier(
                        font: .montserratRegular,
                        size: iPhoneFont18,
                        color: .secondaryBlue
                    )
            }
            
            seprator
                .padding(.top, 20.h)
            Button {
                AmplitudeService.sendEvent(
                    key: .OBS_PLUS_3_1_DELETE_MY_ACCOUNT
                )
                self.deleteAccount = true
            } label: {
                MoreCardSectionView(
                    buttonImage: "chevron.forward",
                    isSystemImage: true,
                    buttonTitle: "DELETE MY ACCOUNT".localized
                )
            }
            NavigationLink(
                "", destination:
                    DeleteObserverProfile(),
                isActive: $deleteAccount
            )
            Spacer(minLength: 16.h)
        }
        .padding(.vertical, 34.h)
        .padding(.horizontal, 24.w)

        .customNavigationViewWithoutBackWithAmplitudeEvent(
            title: "Account".localized,
            color: .white,
            amplitudeEvent: .OBS_PLUS_3_1_BACK
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

/*
struct ObserverAccountInDetails_Previews: PreviewProvider {
    static var previews: some View {
        ObserverAccountInDetails(noOfDevice: .constant(12), noOfChild: .constant(9))
    }
}*/
