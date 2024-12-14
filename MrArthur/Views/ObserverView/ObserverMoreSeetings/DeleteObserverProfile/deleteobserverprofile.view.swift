//
//  deleteobserverprofile.view.swift
//  MrArthur
//
//  Created by IPS-172 on 17/10/22.
//

import Foundation
import SwiftUI

struct DeleteObserverProfile: View {
    
    @State private var isTickMarkShow = false
    @StateObject private var observed = Observed()
    @EnvironmentObject private var rootViewObserver: RootViewObserver
    @State var show = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0){
                Text("Deleting your account will permanently erase all your children’s data and registered devices.".localized)
                    .fontModifier(
                        font: .montserratRegular,
                        size: iPhoneFont18,
                        color: .primaryBlue
                    )
                    .padding(.bottom, 34.h)
                
                Text("You have to delete the account on each devices you have registered.".localized)
                    .fontModifier(
                        font: .montserratRegular,
                        size: iPhoneFont18,
                        color: .primaryBlue
                    )
                
                Spacer()
                
                if isTickMarkShow {
                    
                    HStack{
                        Spacer()
                        VStack{
                            Image("iconValidateBig")
                            Text("ACCOUNT IS DELETED".localized)
                                .fontModifier(
                                    font: .montserratBlack,
                                    size: iPhoneFont15,
                                    color: .primaryBlue
                                )
                        }
                        Spacer()
                    }
                    Spacer()
                }
                
                if !isTickMarkShow {
                    HStack{
                        Spacer()
                        Button {
                            withAnimation {
                                self.show = true
                            }
                        } label: {
                            Text("DELETE MY ACCOUNT".localized)
                                .fontModifier(
                                    font: .montserratBlack,
                                    size: iPhoneFont15
                                )
                                .frame(
                                    width: 341.w,
                                    height: 60.h
                                )
                                .background(
                                    RoundedRectangle(cornerRadius: 44.r)
                                        .fill(Color.primaryRed)
                                )
                        }
                        .contentShape(Rectangle())
                        Spacer()
                    }
                    
                }
            }
            if self.show{
                CustomAlertPopup(
                    alertHeading: "Do you really want to delete your account?".localized,
                    leftButtonTitle: "CANCEL".localized,
                    rightButtonTitle: "DELETE_ACCOUNT".localized,
                    action: { actionStatus in
                        if actionStatus{
                            onDelete()
                        }
                        self.show = false
                    }
                )
            }
        }
        .padding(.horizontal, 24.w)
        .padding(.vertical, 34.h)
        .customNavigationViewWithBackWidgit(
            title: "Delete my account ".localized,
            color: .whiteColor
        )
        .background(
            LinearGradient(
                colors: [
                    Color.lightPink,
                    Color.secondaryRed
                ],
                startPoint: .top,
                endPoint: .bottomTrailing
            )
            
        )
        .edgesIgnoringSafeArea(.bottom)
    }
    
    private func onDelete() {
        AmplitudeService.sendEvent(
            key: .OBS_PLUS_3_1_DELETE_MY_ACCOUNT
        )
        let subscriptionValue = UtilityMethod().getValueForKey(key: ConstantOfApp.kUUIDForSubscription) as? String
        let deleteSubscriptionparam = DeleteSubscriptionRequesModel(SubscriptionUUID: subscriptionValue ?? "")
        print(deleteSubscriptionparam)
        if let param = try? deleteSubscriptionparam.asDictionary() {
            observed.deleteSubscriptionAPI(
                withToken: ConstantOfApp.kObserverTokenSend,
                param: param
            ) { message, status in
                print("status ---> \(status)")
                print("message ---> \(message ?? "")")
                switch status{
                case true :
                    isTickMarkShow = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        UtilityMethod.logoutObserver {
                            self.rootViewObserver.currentPage = .welcome
                        }
                    }
                case false :
                    print("\(message ?? "")")
                }
            }
        }
    }
    
}
struct DeleteObserverProfile_Previews: PreviewProvider {
    static var previews: some View {
        DeleteObserverProfile()
    }
}
