//
//  observer.addup.notification.view.swift
//  MrArthur
//
//  Created by IPS-157 on 06/09/22.
//

import SwiftUI

struct ObserverAddupNotificationView: View {
    @EnvironmentObject private var rootViewObserver: RootViewObserver
    @EnvironmentObject private var observerManifestoObservedObject: ObserverManifesto
    var userExistingOrNew = UtilityMethod().getValueForKey(key: ConstantOfApp.kIsUserNewOrExist) as? String ?? ""
    var body: some View {
        VStack(spacing: 0){
            VStack(alignment: .leading, spacing: 20.h){
                Text("Help your child!".localized)
                    .fontModifier(
                        font: .montserratBlack,
                        size: iPhoneFont25,
                        color: .primaryBlue
                    )
                Text("Our program works 95% better with notifications.".localized)
                    .fontModifier(
                        font: .montserratRegular,
                        size: iPhoneFont22,
                        color: .primaryBlue
                    )
                
                Text("We’ll let you know if your child plays along, if he needs help and when he achieves goals!".localized)
                    .fontModifier(
                        font: .montserratRegular,
                        size: iPhoneFont22,
                        color: .primaryBlue
                    )
            }
            
            Spacer(minLength: 16.h)
            
            Image("Notifications")
                .resizable()
                .scaledToFit()
                .frame(width: 278.79.w, height: 244.85.h)
            
            Spacer(minLength: 16.h)
            
            BlueRoundedButton(
                "ENABLE NOTIFICATIONS",
                width: 286.43,
                height: 60
            ) {
                AmplitudeService.sendEvent(key: .OBS_ADD_UP_NOTIFICATIONS_1_ENABLE_NOTIFICATIONS)
                self.notificationEnablePopup()
            }
            .padding(.bottom, 30.h)
            
            Button {
                AmplitudeService.sendEvent(key: .OBS_ADD_UP_NOTIFICATIONS_1_MAYBE_LATER)
                notificationRoute()
            } label: {
                Text("MAYBE LATER".localized)
                    .fontModifier(
                        font: .montserratBlack,
                        size: iPhoneFont15,
                        color: .primaryBlue
                    )
                    .frame(
                        width: 184.14.sp,
                        height: 60.h
                    )
            }
            .contentShape(Rectangle())
            .overlay(
                RoundedRectangle(cornerRadius: 30.r)
                    .stroke(Color.primaryBlue, lineWidth: 2.r)
            )
             
        }
        .padding(.vertical, 32.h)
        .padding(.horizontal, 24.w)
        .customNavigationViewWithBackWidgit(
            title: "Notifications".localized,
            color: .whiteColor,
            showBackButton: false
        )
        .background(
            LinearGradient(
                colors: [
                    Color.secondaryRed,
                    Color.lightPink
                ],
                startPoint: .top,
                endPoint: .bottomTrailing
            )
        )
    }
    
    private func notificationEnablePopup() {
        DispatchQueue.main.async {
            Task{
                PushNotificationsService.setPermission{ isAllowed in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.notificationRoute()
                    }
                }
            }
        }
    }
    
    private func notificationRoute(){
        if (userExistingOrNew == ConstantOfApp.kExistingUser) {
            if let signInResponeRoute = UserDefaultsHelper.signInResponeRoute {
                if let rootView = ERootView(rawValue: signInResponeRoute.rootScreen ?? "welcome") {
                    rootViewObserver.currentPage = rootView
                }
                observerManifestoObservedObject.currentIndex = signInResponeRoute.manifestoIndex ?? 0
                observerManifestoObservedObject.currentHowItWorksIndex = signInResponeRoute.howitworkIndex ?? 0
            }
        } else {
            rootViewObserver.currentPage = .observerQuestionPerfectWellDone
        }
    }
}

/*
struct ObserverAddupNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        ObserverAddupNotificationView()
            .multiPreview
    }
}*/
